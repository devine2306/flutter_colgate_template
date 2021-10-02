import 'dart:convert';
import 'package:colgate/models/users_model.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

class ProfileRepo {
  static Future getProfileAPI({String userId}) async {
    print(userId);
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = userId == null
            ? '${AppConfig.apiBaseUrl}/users/${LocalStorage.userId}'
            : '${AppConfig.apiBaseUrl}/users/$userId';
        print(url);
        http.Response response = await http.get(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${LocalStorage.token}"},
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

  static Future updateSpectatorProfileAPI(
      {String firstName,
      String lastName,
      String phoneNumber,
      dynamic image,
      UsersModel usersModel,
      String profileID}) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;

      if (connection) {
        String url = '${AppConfig.apiBaseUrl}/users/${LocalStorage.userId}';

        Map bodyMap = profileID.isEmpty
            ? {
                "userType": [
                  {
                    "__component": "user.spectator",
                    "lastName": "$lastName",
                    "registered": "yes",
                    "userType": usersModel?.userType[0]?.userType,
                    "phoneNumber": "$phoneNumber",
                    "dateOfBirth": "${usersModel?.userType[0]?.dateOfBirth}",
                    "fullName": "$firstName $lastName",
                    "firstName": "$firstName",
                    "under18": usersModel?.userType[0]?.under18,
                    "firstNameParent": usersModel?.userType[0]?.firstNameParent,
                    "lastNameParent": usersModel?.userType[0]?.lastNameParent,
                    "emailParent": usersModel?.userType[0]?.emailParent,
                    "phoneNumberParent":
                        usersModel?.userType[0]?.phoneNumberParent
                  }
                ],
              }
            : {
                "userType": [
                  {
                    "__component": "user.spectator",
                    "lastName": "$lastName",
                    "registered": "yes",
                    "userType": usersModel?.userType[0]?.userType,
                    "phoneNumber": "$phoneNumber",
                    "dateOfBirth": "${usersModel?.userType[0]?.dateOfBirth}",
                    "fullName": "$firstName $lastName",
                    "firstName": "$firstName",
                    "under18": usersModel?.userType[0]?.under18,
                    "firstNameParent": usersModel?.userType[0]?.firstNameParent,
                    "lastNameParent": usersModel?.userType[0]?.lastNameParent,
                    "emailParent": usersModel?.userType[0]?.emailParent,
                    "phoneNumberParent":
                        usersModel?.userType[0]?.phoneNumberParent
                  }
                ],
                "profileImage": profileID
              };
        http.Response response = await http.put(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.token}"
          },
          body: jsonEncode(bodyMap),
        );

        if (response.statusCode == 200) {
          toast("Update successfully");
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          toast('Something went wrong');
          showDialogAlert(Get.context, 'Something went wrong');
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
          showDialogAlert(Get.context, "Timeout Error");
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast('${decoded['error']['message']}');
          showDialogAlert(Get.context, '${decoded['error']['message']}');
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

  static Future updateCompetitorProfileAPI({
    String firstName,
    String lastName,
    String phoneNumber,
    String addressStreet,
    String addressCity,
    String addressState,
    String zipcode,
    String schoolName,
    String schoolCity,
    int eventDivision,
    int eventTypeOne,
    int eventTypeTwo,
    int eventGrade,
    UsersModel usersModel,
    String profileID,
  }) async {
    try {
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection) {
        String url = '${AppConfig.apiBaseUrl}/users/${LocalStorage.userId}';
        print({
          "id": eventTypeOne,
          "id1": eventTypeTwo,
          "eventDivision": eventDivision
        });

        Map bodyMap = profileID.isEmpty
            ? {
                "userType": [
                  {
                    "__component": "user.competitor",
                    "phoneNumberParent":
                        usersModel?.userType[0]?.phoneNumberParent,
                    "lastName": "$lastName",
                    "registered": "no",
                    "firstNameParent": usersModel?.userType[0]?.firstNameParent,
                    "emailParent": usersModel?.userType[0]?.emailParent,
                    "eventDivision": {"id": eventDivision},
                    "lastNameParent": usersModel?.userType[0]?.lastNameParent,
                    "eventTypeOne": {"id": eventTypeOne},
                    "address": {
                      "AddressStreet": "$addressStreet",
                      "AddressCity": "$addressCity",
                      "AddressState": "$addressState",
                      "AddressZipCode": zipcode,
                      "AddressApartmentNo":
                          usersModel?.userType[0]?.address?.addressApartmentNo,
                    },
                    "phoneNumber": "$phoneNumber",
                    "eventTypeTwo": {"id": eventTypeTwo},
                    "dateOfBirth": "${usersModel?.userType[0]?.dateOfBirth}",
                    "fullName": "$firstName $lastName",
                    "firstName": "$firstName",
                    "eventGrade": {"id": eventGrade},
                    "school": {
                      "schoolName": "$schoolName",
                      "schoolCity": "$schoolCity",
                      "schoolState":
                          usersModel?.userType[0]?.school?.schoolState
                    },
                    "under18": usersModel?.userType[0]?.under18
                  }
                ],
              }
            : {
                "userType": [
                  {
                    "__component": "user.competitor",
                    "phoneNumberParent":
                        usersModel?.userType[0]?.phoneNumberParent,
                    "lastName": "$lastName",
                    "registered": "no",
                    "firstNameParent": usersModel?.userType[0]?.firstNameParent,
                    "emailParent": usersModel?.userType[0]?.emailParent,
                    "eventDivision": {"id": eventDivision},
                    "lastNameParent": usersModel?.userType[0]?.lastNameParent,
                    "eventTypeOne": {"id": eventTypeOne},
                    "address": {
                      "AddressStreet": "$addressStreet",
                      "AddressCity": "$addressCity",
                      "AddressState": "$addressState",
                      "AddressZipCode": zipcode,
                      "AddressApartmentNo":
                          usersModel?.userType[0]?.address?.addressApartmentNo,
                    },
                    "phoneNumber": "$phoneNumber",
                    "eventTypeTwo": {"id": eventTypeTwo},
                    "dateOfBirth": "${usersModel?.userType[0]?.dateOfBirth}",
                    "fullName": "$firstName $lastName",
                    "firstName": "$firstName",
                    "eventGrade": {"id": eventGrade},
                    "school": {
                      "schoolName": "$schoolName",
                      "schoolCity": "$schoolCity",
                      "schoolState":
                          usersModel?.userType[0]?.school?.schoolState
                    },
                    "under18": usersModel?.userType[0]?.under18
                  }
                ],
                "profileImage": profileID
              };
        http.Response response = await http.put(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.token}"
          },
          body: jsonEncode(bodyMap),
        );

        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          toast("Update successfully");
          return jsonDecode(response.body);
        } else if (response.statusCode == 400 ||
            response.statusCode == 409 ||
            response.statusCode == 403 ||
            response.statusCode == 500) {
          toast('Something went wrong');
          return null;
        } else if (response.statusCode == 504) {
          toast("Timeout Error");
          return null;
        } else if (response.statusCode == 401) {
          var decoded = jsonDecode(response.body);
          toast('${decoded['error']['message']}');
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

  static Future uploadProfile(image) async {
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection) {
      String url = '${AppConfig.apiBaseUrl}/upload/';
      var uri = Uri.parse(url);
      try {
        dio.Response response = await dio.Dio().post(
          "$uri",
          options: dio.Options(
              headers: {"Authorization": "Bearer ${LocalStorage.token}"}),
          data: dio.FormData.fromMap({"files": image}),
        );
        if (response.statusCode == 200) {
          return response.data;
        } else {
          return null;
        }
      } catch (e) {
        print("Exception");
        print(e);
      }
    } else {
      toast(AppConfig.noInternetText);
      return null;
    }
  }
}
