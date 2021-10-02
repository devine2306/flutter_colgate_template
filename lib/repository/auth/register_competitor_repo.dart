import 'dart:convert';
import 'dart:developer';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;

class RegisterCompetitorRepo {
  static Future registerCompetitorAPI({
    String firstName,
    String lastName,
    String phone,
    String email,
    String isunder18,
    bool registered,
    String dob,
    String addressStreet,
    String addressCity,
    String addressState,
    String apartMentNo,
    String zipcode,
    int eventDivison,
    String schoolName,
    String schoolCity,
    String schoolState,
    int eventTypeOne,
    int eventTypeTwo,
    int eventGrade,
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
        print(url);

        Map bodyMap = {
          "username": "$email",
          "email": "$email",
          "password": "$password",
          "confirmed": true,
          "blocked": false,
          "userType": [
            {
              "__component": "user.competitor",
              "phoneNumberParent": "$pPhone",
              "lastName": "$lastName",
              "registered": "no",
              "firstNameParent": "$pFirstName",
              "emailParent": "$pemail",
              "eventDivision": {"id": eventDivison},
              "lastNameParent": "$pLastName",
              "eventTypeOne": {"id": eventTypeOne},
              "address": {
                "AddressStreet": "$addressStreet",
                "AddressCity": "$addressCity",
                "AddressState": "$addressState",
                "AddressZipCode": zipcode,
                "AddressApartmentNo": "$apartMentNo"
              },
              "phoneNumber": "$phone",
              "eventTypeTwo": {"id": eventTypeTwo},
              "dateOfBirth": dob.substring(0, 10),
              "fullName": "$firstName $lastName",
              "firstName": "$firstName",
              "eventGrade": {"id": eventGrade},
              "school": {
                "schoolName": "$schoolName",
                "schoolCity": "$schoolCity",
                "schoolState": "$schoolState"
              },
              "under18": isunder18
            }
          ]
        };

        print(bodyMap);
        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(bodyMap),
        );
        print("=-=-=-=-=-=-=-=-=-=-=-");
        print(response.statusCode);
        log(response.body.toString());
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
          return null;
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
          return null;
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast(decoded['message'][0]['messages'][0]['message']);
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

  static Future sendConfirmationMail({
    String pemail,
    String token,
  }) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = '${AppConfig.apiBaseUrl}/competitors';
        print(url);

        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode({'email': pemail}),
        );
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          print(response.body);
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          var decoded = jsonDecode(response.body);

          toast(decoded['message'][0]['messages'][0]['message']);
          return null;
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
          return null;
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast(decoded['message'][0]['messages'][0]['message']);
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
