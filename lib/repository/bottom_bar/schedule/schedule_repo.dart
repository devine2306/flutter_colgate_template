import 'dart:convert';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;

class ScheduleRepo {
  static Future getScheduleAPI(
      {int eventDivisionId, int eventGradeId, int eventStage}) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url =
            '${AppConfig.apiBaseUrl}/schedules?event_division=$eventDivisionId&event_grade=$eventGradeId&event_stage=$eventStage';
        print(url);
        http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
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

  static Future getScheduleOptionAPI(
      {int eventDivisionId, int eventGradeId, int eventStage}) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = '${AppConfig.apiBaseUrl}/options';
        print(url);
        http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
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
