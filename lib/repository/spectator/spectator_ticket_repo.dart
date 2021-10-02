import 'dart:convert';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;

class SpectatorTicketRepo {
  static Future getAllOrganizationsAPI() async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = '${AppConfig.eventBriteURL}/users/me/organizations/';
        http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${AppConfig.eventBritePrivateAuthToken}"
          },
        );
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          toast('Something went wrong');
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast('${decoded['error']['message']}');
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

  static Future getAllOrganizationsEventsAPI({String orgId}) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url =
            '${AppConfig.eventBriteURL}/organizations/$orgId/events?order_by=created_desc&status=live';
        print(url);
        http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            "Authorization": "Bearer ${AppConfig.eventBritePrivateAuthToken}"
          },
        );
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          toast('Something went wrong');
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast('${decoded['error']['message']}');
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
