import 'package:colgate/repository/auth/forgot_password_repo.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxString emailAddress = ''.obs;
  RxString emailError = ''.obs;
  RxString sendOTP = "".obs;

  bool valid() {
    RxBool isValid = true.obs;
    if (emailAddress.isEmpty) {
      emailError.value = '*Please enter email';
      isValid.value = false;
    } else if (!Helper.isEmail(emailAddress.value.trim())) {
      emailError.value = '*Please enter valid email';
      isValid.value = false;
    }
    return isValid.value;
  }

  onSend() {
    if (valid()) {
      forgotPassword();
    }
  }

  forgotPassword() async {
    LoadingOverlay.of(Get.context).show();
    var res = await ForgotPasswordRepo.forgotPasswordAPI(
        email: emailAddress.value.trim());
    if (res != null) {
      Get.back();
      toast("Email sent successfully");
    }
    LoadingOverlay.of(Get.context).hide();
  }
  // sendEmail() async {
  //   final mailer = Mailer(AppConfig.apiKeySendGrid);
  //   final toAddress = Address(emailAddress.value);
  //   final fromAddress = Address('adnan@appify.digital');
  //   final subject = 'Colgate App';
  //   final personalization = Personalization([toAddress]);
  //   final email = Email([personalization], fromAddress, subject,
  //       templateId: "d-9ed18dd902d44f8d94fd79d4b180dcc9");
  //   mailer.send(email).then((result) {
  //     if (result.isError) {
  //       toast("Somthing went wrong!");
  //     } else {
  //       Get.back();
  //       toast("Email sent successfully");
  //     }
  //   });
  // }
}
