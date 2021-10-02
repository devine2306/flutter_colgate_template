import 'dart:convert';
import 'dart:developer';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;

class RegisterSpectatorRepo {
  static Future registerSpectatorAPI({
    String firstName,
    String lastName,
    String phone,
    String email,
    bool isunder18,
    String userType,
    bool registered,
    String dob,
    String password,
    String pFirstName,
    String pLastName,
    String pemail,
    String pPhone,
  }) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = '${AppConfig.apiBaseUrl}/auth/local/register';
        print("<=================================================>");
        print(url);

        Map bodyMap = isunder18
            ? {
                "username": "$email",
                "email": "$email",
                "password": "$password",
                "confirmed": true,
                "blocked": false,
                "userType": [
                  {
                    "__component": "user.spectator",
                    "lastName": "$lastName",
                    "registered": "yes",
                    "userType": "$userType",
                    "phoneNumber": "$phone",
                    "dateOfBirth": dob.substring(0, 10),
                    "fullName": "$firstName $lastName",
                    "firstName": "$firstName",
                    "under18": "yes",
                    "firstNameParent": "$pFirstName",
                    "lastNameParent": "$pLastName",
                    "emailParent": "$pemail",
                    "phoneNumberParent": "$pPhone"
                  }
                ]
              }
            : {
                "username": "$email",
                "email": "$email",
                "password": "$password",
                "confirmed": true,
                "blocked": false,
                "userType": [
                  {
                    "__component": "user.spectator",
                    "lastName": "$lastName",
                    "registered": "yes",
                    "userType": "$userType",
                    "phoneNumber": "$phone",
                    "dateOfBirth": dob.substring(0, 10),
                    "fullName": "$firstName $lastName",
                    "firstName": "$firstName",
                    "under18": "no",
                  }
                ]
              };
        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(bodyMap),
        );
        log(response.body.toString());
        print(response.statusCode);
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.body);
          await LocalStorage.storeDataInfo(decoded);
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          var decoded = jsonDecode(response.body);
          List<String> emailErrors = [];
          decoded['data']['errors'].forEach((k, v) {
            emailErrors.add(v.first.toString());
          });
          toast(emailErrors[0]);
          return null;
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
          return null;
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          List<String> emailErrors = [];
          decoded['data']['errors'].forEach((k, v) {
            emailErrors.add(v.first.toString());
          });
          toast(emailErrors[0]);
          return null;
        } else {
          toast('${AppConfig.apiError}');
          return null;
        }
      } else {
        toast(AppConfig.noInternetText);
        return null;
      }
    } catch (e) {
      toast("${AppConfig.apiError}");

      return null;
    }
  }
}
