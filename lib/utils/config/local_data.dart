import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

import 'constant.dart';

class LocalStorage {
  static String userId = "";
  static String deviceIP = "";
  static String token = "";
  static String userEmail = "";
  static String fullName = "";
  static String userMobile = "";
  static String userType = "";
  static String deviceId = "";
  static String deviceToken = "";
  static String deviceType = "";
  static dynamic under18 = "";

  static bool isLogin = false;

  static Future storeDataInfo(
    json,
  ) async {
    final prefs = new FlutterSecureStorage();
    //* Store Token
    await prefs.write(key: PrefsKey.TOKEN, value: json['jwt']);
    //* Store UserId
    await prefs.write(
        key: PrefsKey.USER_ID, value: json['user']['id']?.toString() ?? "");
    //* Store firstName
    await prefs.write(
        key: PrefsKey.FULL_NAME,
        value: json['user']['userType'][0]['fullName'] ?? "");
    //* Store email
    await prefs.write(
        key: PrefsKey.USER_EMAIL, value: json['user']['email'] ?? "");
    //* Store mobile
    await prefs.write(
        key: PrefsKey.MOBILE,
        value: json['user']['phoneNumber']?.toString() ?? "");
    //* Store User Profile Image
    await prefs.write(
        key: PrefsKey.USER_TYPE,
        value: json['user']['userType'][0]['__component']
                .toString()
                .split('.')[1] ??
            "");
    //* User is Under 18 or not
    await prefs.write(
        key: PrefsKey.UNDER_18,
        value: json['user']['userType'][0]['under18'] ?? "");
    //* set data
  }

  static Future loadData() async {
    final prefs = new FlutterSecureStorage();
    userId = await prefs.read(key: PrefsKey.USER_ID);
    token = await prefs.read(key: PrefsKey.TOKEN);
    userEmail = await prefs.read(key: PrefsKey.USER_EMAIL);
    fullName = await prefs.read(key: PrefsKey.FULL_NAME);
    userMobile = await prefs.read(key: PrefsKey.MOBILE);
    userType = await prefs.read(key: PrefsKey.USER_TYPE);
    under18 = await prefs.read(key: PrefsKey.UNDER_18);
  }

  static void storeDeviceInfo(
    String deviceID,
    String deviceTOKEN,
    String deviceTYPE,
  ) async {
    String ip = "";
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        ip = addr.address;
      }
    }
    final prefs = GetStorage();
    //* Store device id
    prefs.write(PrefsKey.DEVICE_ID, deviceID);
    //* Store device token
    prefs.write(PrefsKey.DEVICE_TOKEN, deviceTOKEN);
    //* Store device type
    prefs.write(PrefsKey.DEVICE_TYPE, deviceTYPE);
    //* Store devide ip address
    prefs.write(PrefsKey.DEVICE_IP, ip);
    //* set data
    deviceId = prefs.read(PrefsKey.DEVICE_ID);
    deviceToken = prefs.read(PrefsKey.DEVICE_TOKEN);
    deviceType = prefs.read(PrefsKey.DEVICE_TYPE);
    deviceIP = prefs.read(PrefsKey.DEVICE_IP);
  }
}
