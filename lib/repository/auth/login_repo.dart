import 'dart:convert';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  static Future loginAPI({
    String email,
    String password,
  }) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = '${AppConfig.apiBaseUrl}/auth/local/';
        print("<=================================================>");
        print(url);
        print({
          "identifier": "$email",
          "password": "$password",
        });

        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "identifier": "$email",
            "password": "$password",
          }),
        );
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          print(response.body);
          var decoded = jsonDecode(response.body);
          await LocalStorage.storeDataInfo(decoded);
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          var decoded = jsonDecode(response.body);

          toast(decoded['message'][0]['messages'][0]['message']);
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast(decoded['message'][0]['messages'][0]['message']);
        } else {
          toast('${AppConfig.apiError}');
        }
      } else {
        toast(AppConfig.noInternetText);
      }
    } catch (e) {
      toast("${AppConfig.apiError}");
      return null;
    }
  }
}
