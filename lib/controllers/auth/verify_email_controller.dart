import 'dart:convert';

import 'package:colgate/controllers/auth/regsiter_competitor_controller.dart';
import 'package:colgate/repository/auth/register_competitor_repo.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:colgate/utils/widgets/country_list.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';
import 'package:http/http.dart' as http;

class VerifyEmailController extends GetxController {
  RxBool tAndc = false.obs;
  RxString name = ''.obs;
  RxString nameError = ''.obs;
  RxString emailAddress = ''.obs;
  RxString emailError = ''.obs;
  RxString number = ''.obs;
  RxString numberError = ''.obs;
  RxString tAndcError = ''.obs;
  RegisterCompetitorController registerCompetitorController;
  RxString token = ''.obs;
  RxString installationCountryCode = "".obs;
  RxString installationCode = ''.obs;

  @override
  void onInit() {
    registerCompetitorController = Get.find();
    getTelephonyInfo();
    name.value = registerCompetitorController.pfirstName.value +
        " " +
        registerCompetitorController.pfirstName.value;
    emailAddress.value = registerCompetitorController.pemail.value;
    number.value = registerCompetitorController.pphoneNumber.value;
    super.onInit();
  }

  bool valid() {
    RxBool isValid = true.obs;
    nameError.value = "";
    numberError.value = "";
    emailError.value = '';
    tAndcError.value = "";
    if (name.isEmpty) {
      nameError.value = "*Please enter name";
      isValid.value = false;
    }
    if (emailAddress.isEmpty) {
      emailError.value = "*Please enter email";
      isValid.value = false;
    } else if (!Helper.isEmail(emailAddress.value)) {
      emailError.value = "*Please enter valid email";
      isValid.value = false;
    }
    if (number.isEmpty) {
      numberError.value = "*Please enter phone number";
      isValid.value = false;
    } else if (!Helper.isPassword(number.value)) {
      numberError.value = "*Please enter valid phone number";
      isValid.value = false;
    }

    if (!tAndc.value) {
      tAndcError.value = "*Please T&C apply";
      isValid.value = false;
    }
    return isValid.value;
  }

  void onVerifyAndProceed() {
    if (valid()) {
      LoadingOverlay.of(Get.context).show();
      registerCompetitor(Get.context);
      LoadingOverlay.of(Get.context).hide();
    }
  }

  sendEmail() async {
    final mailer = Mailer(AppConfig.apiKeySendGrid);
    final toAddress = Address(emailAddress.value);
    final fromAddress = Address('adnan@appify.digital');
    final subject = 'Colgate App';
    final personalization = Personalization([toAddress]);
    final email = Email([personalization], fromAddress, subject,
        templateId: "d-c2b4d15017be43489b75aa6e5d675d88");
    mailer.send(email).then((result) {
      if (result.isError) {
        toast("Somthing went wrong!");
      } else {
        toast("Email sent successfully!");
      }
    });
  }

  registerCompetitor(context) async {
    LoadingOverlay.of(context).show();
    var res = await RegisterCompetitorRepo.registerCompetitorAPI(
      email: registerCompetitorController?.email?.value ?? "",
      firstName: registerCompetitorController?.firstName?.value ?? "",
      lastName: registerCompetitorController?.lastName?.value ?? "",
      phone:
          "+${installationCountryCode.value}${registerCompetitorController.phoneNumber.value}",
      isunder18: "yes",
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
      pFirstName: registerCompetitorController.pfirstName.value,
      pLastName: registerCompetitorController.plastName.value,
      pemail: registerCompetitorController.pemail.value,
      pPhone:
          "+${installationCountryCode.value}${registerCompetitorController.pphoneNumber.value}",
    );
    LoadingOverlay.of(context).hide();
    if (res != null) {
      sendEmail();
      token.value = '';
      Get.offNamedUntil(Routes.SPLASH, (route) => false);
      Get.toNamed(Routes.ACCOUNT_CREATED_SCREEN, arguments: "email");
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
