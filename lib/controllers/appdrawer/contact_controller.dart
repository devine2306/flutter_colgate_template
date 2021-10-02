import 'package:colgate/models/users_model.dart' as user;
import 'package:colgate/repository/spectator/profile_repo.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class ContactController extends GetxController {
  RxBool isLoading = false.obs;
  user.UsersModel userModel;
  RxString firstName = ''.obs;
  RxString firstNameError = ''.obs;
  RxString lastName = ''.obs;
  RxString lastNameError = ''.obs;
  RxString emailAddress = ''.obs;
  RxString emailAddressError = ''.obs;
  RxString message = ''.obs;
  RxString messageError = ''.obs;
  @override
  void onInit() {
    if (LocalStorage.token != null && LocalStorage.token.isNotEmpty) {
      getProfileDetails();
    }
    super.onInit();
  }

  getProfileDetails() async {
    isLoading.value = true;

    var res = await ProfileRepo.getProfileAPI();
    if (res != null) {
      userModel = user.UsersModel.fromJson(res);
    }
    isLoading.value = false;
  }

  bool valid() {
    RxBool isValid = true.obs;
    firstNameError.value = "";
    lastNameError.value = "";
    emailAddressError.value = "";
    messageError.value = "";
    if (firstName.isEmpty) {
      firstNameError.value = "*Please enter Firstname";
      isValid.value = false;
    }
    if (lastName.isEmpty) {
      lastNameError.value = "*Please enter Lastname";
      isValid.value = false;
    }
    if (emailAddress.isEmpty) {
      emailAddressError.value = "*Please enter Email";
      isValid.value = false;
    } else if (!Helper.isEmail(emailAddress.value)) {
      emailAddressError.value = "*Please enter Valid Email";
      isValid.value = false;
    }
    if (message.isEmpty) {
      messageError.value = "*Please enter Message";
      isValid.value = false;
    }
    return isValid.value;
  }

  send() {
    if (valid()) {
      LoadingOverlay.of(Get.context).show();
      sendEmail();
      LoadingOverlay.of(Get.context).hide();
    }
  }

  sendEmail() async {
    final mailer = Mailer(AppConfig.apiKeySendGrid);
    final toAddress = Address(emailAddress.value);
    final fromAddress = Address('adnan@appify.digital');
    final subject = 'Colgate App';
    final args = (LocalStorage.token != null && LocalStorage.token.isNotEmpty)
        ? {
            'firstName': userModel?.userType[0]?.firstName,
            'lastName': userModel?.userType[0]?.lastName,
            "email": userModel.email,
            'message': message.value
          }
        : {
            'firstName': firstName.value,
            'lastName': lastName.value,
            "email": emailAddress.value,
            'message': message.value
          };
    final personalization = Personalization(
      [toAddress],
      dynamicTemplateData: args,
    );
    final email = Email(
      [personalization],
      fromAddress,
      subject,
      templateId: "d-b8c536972a9446cba6af15c5d7c688e5",
    );
    mailer.send(email).then((result) {
      if (result.isError) {
        toast("Somthing went wrong!");
      } else {
        Get.back();
        toast("Email Sent Successfully");
      }
    });
  }
}
