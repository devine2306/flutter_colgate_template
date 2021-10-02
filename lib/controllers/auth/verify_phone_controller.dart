import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:colgate/controllers/auth/register_option_controller.dart';
import 'package:colgate/controllers/auth/register_spectator_controller.dart';
import 'package:colgate/controllers/auth/regsiter_competitor_controller.dart';
import 'package:colgate/controllers/auth/resend_otp_controller.dart';
import 'package:colgate/repository/auth/register_competitor_repo.dart';
import 'package:colgate/repository/auth/register_spectator_repo.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:colgate/utils/widgets/country_list.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/twilio_flutter.dart';

class VerifyPhoneController extends GetxController {
  RxString otp = "".obs;
  RxString otpError = "".obs;
  TwilioFlutter twilioFlutter;
  RxString installationCountryCode = "".obs;
  RxString installationCode = ''.obs;
  RxString sendOTP = ''.obs;
  RxInt timeLimit = 0.obs;
  Timer timer;
  RxString phoneNumber = "".obs;
  RegisterSpactatorController registerSpactatorController;
  RegisterCompetitorController registerCompetitorController;
  RegisterOptionController registerOptionController;
  ResendCodeController resendCodeController;
  RxString email = "".obs;
  RxString password = "".obs;

  @override
  void onInit() {
    registerOptionController = Get.find();
    if (registerOptionController?.roleName?.value == "Competitor") {
      registerCompetitorController = Get.find();
      phoneNumber = registerCompetitorController.phoneNumber;
      email = registerCompetitorController.email;
      password = registerCompetitorController.password;
    } else {
      registerSpactatorController = Get.find();
      phoneNumber = registerSpactatorController.phoneNumber;
      email = registerSpactatorController.email;
      password = registerSpactatorController.password;
    }
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC6c713245e94a1696d2c33407bce50a3d',
        authToken: '9a8836c64811128b1c37c7ebee6cd276',
        twilioNumber: '+19282321742');
    getTelephonyInfo().then((_) => sendSms());
    super.onInit();
  }

  void onVerifyAndProceed(context) {
    if (validate()) {
      if (registerOptionController?.roleName?.value == "Competitor") {
        registerCompetitor(context);
      } else {
        registerSpectator(context);
      }
    }
  }

  validate() {
    RxBool valid = true.obs;
    otpError.value = '';
    print(otp.value);
    print(sendOTP.value);
    if (otp.value.isEmpty) {
      otpError.value = '*Please enter OTP';
      valid.value = false;
    } else if (otp.value.length < 6) {
      otpError.value = '*Please enter valid OTP';
      valid.value = false;
    } else if (otp.value != sendOTP.value) {
      otpError.value = '*Please enter valid OTP';
      valid.value = false;
    }
    return valid.value;
  }

  void onResend() {
    sendSms();
  }

  void resetTimer() {
    if (timeLimit.value > 0) {
      timeLimit.value--;
    } else {
      if (timeLimit.value == 0) {
        sendOTP.value = '';
        timer.cancel();
      }
    }
  }

  timerVerfication() {
    timeLimit.value = 60;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        resetTimer();
      },
    );
  }

  void sendSms() {
    otpGenerator();
    twilioFlutter.sendSMS(
        toNumber: '+${installationCountryCode.value} ${phoneNumber.value}',
        messageBody:
            'Thank you for registering with the Colgate Women\'s Games app.\nYour one time password (OTP) code is ${sendOTP.value}.');
    timerVerfication();
  }

  void otpGenerator() {
    int min = 100000;
    int max = 999999;
    sendOTP.value = (min + Random().nextInt(max - min)).toString();
  }

  void onSendToAnotherNumber() {
    Get.toNamed(Routes.RESEND_CODE_SCREEN, arguments: twilioFlutter)
        .then((value) {
      resendCodeController = Get.find();
      if (resendCodeController.phoneNumber.value.isNotEmpty) {
        timerVerfication();
        sendOTP.value = resendCodeController.sendOTP.value;
        phoneNumber.value = resendCodeController.phoneNumber.value;
      }
    });
  }

  registerSpectator(context) async {
    LoadingOverlay.of(context).show();
    timeLimit.value = 0;
    var res = await RegisterSpectatorRepo.registerSpectatorAPI(
      email: registerSpactatorController?.email?.value ?? "",
      firstName: registerSpactatorController?.firstName?.value ?? "",
      lastName: registerSpactatorController?.lastName?.value ?? "",
      phone: "+${installationCountryCode.value}${phoneNumber.value}",
      isunder18: registerSpactatorController.year18Plus.value == 1,
      registered: true,
      userType: registerOptionController?.roleName?.value ?? "",
      dob: registerSpactatorController.dob.value,
      password: registerSpactatorController?.password?.value,
      pFirstName: registerSpactatorController.pfirstName.value,
      pLastName: registerSpactatorController.plastName.value,
      pemail: registerSpactatorController.pemail.value,
      pPhone:
          "+${installationCountryCode.value}${registerSpactatorController.pphoneNumber.value}",
    );
    LoadingOverlay.of(context).hide();
    if (res != null) {
      Get.offNamedUntil(Routes.SPLASH, (route) => false);
      Get.toNamed(Routes.ACCOUNT_CREATED_SCREEN, arguments: 'spectator');
    }
  }

  registerCompetitor(context) async {
    LoadingOverlay.of(context).show();
    var res = await RegisterCompetitorRepo.registerCompetitorAPI(
      email: registerCompetitorController?.email?.value ?? "",
      firstName: registerCompetitorController?.firstName?.value ?? "",
      lastName: registerCompetitorController?.lastName?.value ?? "",
      phone: "+${installationCountryCode.value}${phoneNumber.value}",
      isunder18: "no",
      registered: true,
      addressCity: registerCompetitorController?.cityName?.value ?? "",
      addressState: registerCompetitorController?.stateName?.value ?? "",
      addressStreet: registerCompetitorController?.streetAddress?.value ?? "",
      dob: registerCompetitorController.dob.value,
      schoolCity: registerCompetitorController?.schoolCity?.value ?? "",
      schoolName: registerCompetitorController?.schoolName?.value ?? "",
      schoolState: registerCompetitorController?.schoolState?.value ?? "",
      eventDivison: registerCompetitorController.selectedDivisionId.value,
      eventGrade: registerCompetitorController.selectedGradeId.value,
      zipcode: registerCompetitorController.zipcode.value,
      eventTypeOne: registerCompetitorController
          .eventTypeList[registerCompetitorController.selectedEventIdsList[0]]
          .id,
      eventTypeTwo: registerCompetitorController.selectedEventIdsList.length > 1
          ? registerCompetitorController
              .eventTypeList[
                  registerCompetitorController.selectedEventIdsList[1]]
              .id
          : null,
      password: registerCompetitorController.password.value,
      apartMentNo: registerCompetitorController.apartMent.value,
    );
    LoadingOverlay.of(context).hide();
    if (res != null) {
      Get.offNamedUntil(Routes.SPLASH, (route) => true);
      Get.toNamed(Routes.ACCOUNT_CREATED_SCREEN, arguments: 'competitor');
    }
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
