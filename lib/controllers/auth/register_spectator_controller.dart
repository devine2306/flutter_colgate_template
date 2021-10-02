import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterSpactatorController extends GetxController {
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  RxString dob = "Date of Birth".obs;
  RxString password = "".obs;
  RxString firstFormError = "".obs;

  RxString pfirstName = "".obs;
  RxString plastName = "".obs;
  RxString pphoneNumber = "".obs;
  RxString pemail = "".obs;

  RxInt year18Plus = 0.obs;

  RxString onChangeDatetime = "".obs;

  bool validateFirstForm() {
    RxBool valid = true.obs;
    firstFormError.value = "";
    if (firstName.isEmpty) {
      firstFormError.value = '*Please enter first name';
      valid.value = false;
    } else if (lastName.isEmpty) {
      firstFormError.value = '*Please enter fast name';
      valid.value = false;
    } else if (phoneNumber.isEmpty) {
      firstFormError.value = '*Please enter mobile number';
      valid.value = false;
    } else if (!Helper.isPhoneNumber(phoneNumber.value)) {
      firstFormError.value = "*Please enter valid mobile number";
      valid.value = false;
    } else if (email.isEmpty) {
      firstFormError.value = '*Please enter email address';
      valid.value = false;
    } else if (!Helper.isEmail(email.value.trim())) {
      firstFormError.value = '*Please enter valid email';
      valid.value = false;
    } else if (dob.isEmpty) {
      firstFormError.value = '*Please enter date of birth';
      valid.value = false;
    } else if (password.isEmpty) {
      firstFormError.value = '*Please enter password';
      valid.value = false;
    } else if (year18Plus.value == 1) {
      if (!validateParentForm()) valid.value = false;
    }
    return valid.value;
  }

  validateParentForm() {
    RxBool valid = true.obs;
    firstFormError.value = "";
    if (pfirstName.isEmpty) {
      firstFormError.value = '*Please enter parent\'s first name';
      valid.value = false;
    } else if (plastName.isEmpty) {
      firstFormError.value = '*Please enter parent\'s last name';
      valid.value = false;
    } else if (pphoneNumber.isEmpty) {
      firstFormError.value = '*Please enter parent\'s mobile number';
      valid.value = false;
    } else if (!Helper.isPhoneNumber(phoneNumber.value)) {
      firstFormError.value = "*Please enter valid mobile number";
      valid.value = false;
    } else if (pemail.isEmpty) {
      firstFormError.value = 'Please enter parent\'s email address';
      valid.value = false;
    } else if (!Helper.isEmail(pemail.value)) {
      firstFormError.value = '*Please enter valid email address';
      valid.value = false;
    }
    return valid.value;
  }

  void onTapOnContiueBtn(context) {
    if (validateFirstForm()) {
      Get.toNamed(Routes.VERIFY_PHONE_SCREEN);
    }
  }
}
