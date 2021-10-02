import 'dart:convert';
import 'dart:math';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/widgets/country_list.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:http/http.dart' as http;

class ResendCodeController extends GetxController {
  RxString phoneNumber = "".obs;
  RxString phoneNumberError = "".obs;
  TwilioFlutter twilioFlutter;
  RxString sendOTP = "".obs;
  RxString installationCountryCode = "".obs;
  RxString installationCode = ''.obs;
  @override
  void onInit() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC6c713245e94a1696d2c33407bce50a3d',
        authToken: '9a8836c64811128b1c37c7ebee6cd276',
        twilioNumber: '+19282321742');
    getTelephonyInfo();
    super.onInit();
  }

  bool valid() {
    RxBool valid = true.obs;
    if (phoneNumber.isEmpty) {
      phoneNumberError.value = "*Please enter Mobile Number";
      valid.value = false;
    } else if (!Helper.isPhoneNumber(phoneNumber.value)) {
      phoneNumberError.value = "*Please enter Valid Mobile Number";
      valid.value = false;
    }
    return valid.value;
  }

  void onResendCode() {
    if (valid()) {
      sendSms();
      Get.back();
    }
  }

  void sendSms() {
    otpGenerator();
    twilioFlutter.sendSMS(
        toNumber: '+${installationCountryCode.value} ${phoneNumber.value}',
        messageBody:
            'Hii everyone this is a\nColgate app sms ${sendOTP.value}.');
  }

  void otpGenerator() {
    sendOTP.value =
        (Random().nextDouble() * 1000000.floor()).toString().substring(0, 6);
  }

  Future<void> getTelephonyInfo() async {
    http.Response response;
    bool result = await DataConnectionChecker().hasConnection;
    if (result) {
      response = await http
          .get(
        Uri.parse('http://ip-api.com/json/'),
      )
          .catchError(
        (e) {
          print(e);
        },
      );
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        if (decoded['countryCode'] != null) {
          installationCode.value = decoded['countryCode'];
        } else {
          installationCode.value = 'NG';
        }
        print(installationCode.value);
        if (installationCode.value != null) {
          installationCountryCode.value =
              Country.getPhoneCountryCode(installationCode.value);
        } else {
          installationCountryCode.value = '234';
        }
        print(installationCountryCode.value);
      } else if (response.statusCode == 406 || response.statusCode == 400) {
        var decoded = jsonDecode(response.body);
        toast('${decoded['message']}');
      } else if (response.statusCode == 401) {
        var decoded = jsonDecode(response.body);
        toast('${decoded['message']}');
      } else if (response.statusCode == 503) {
        var decoded = jsonDecode(response.body);
        toast('${decoded['message']}');
      } else {
        toast(AppConfig.noInternetText);
      }
    } else {
      toast(AppConfig.noInternetText);
    }
  }
}
