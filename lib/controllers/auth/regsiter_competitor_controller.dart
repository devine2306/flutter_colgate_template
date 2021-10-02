import 'package:colgate/models/drop_down/event_grade_model.dart';
import 'package:colgate/models/drop_down/event_type_model.dart';
import 'package:colgate/models/drop_down/grade_model.dart';
import 'package:colgate/repository/drop_down/event-grade_repo.dart';
import 'package:colgate/repository/drop_down/event_type_repo.dart';
import 'package:colgate/repository/drop_down/grade_repo.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCompetitorController extends GetxController {
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  RxString dob = "Date of Birth".obs;
  RxString password = "".obs;

  RxString pfirstName = "".obs;
  RxString plastName = "".obs;
  RxString pphoneNumber = "".obs;
  RxString pemail = "".obs;

  RxString streetAddress = "".obs;
  RxString apartMent = "".obs;
  RxString cityName = "".obs;
  RxString stateName = "".obs;
  RxString zipcode = "".obs;

  RxString schoolName = "".obs;
  RxString schoolCity = "".obs;
  RxString schoolState = "".obs;
  RxString schoolGrade = "".obs;

  RxInt initialIndex = 1.obs;
  RxString selectedDivision = "Select a grade".obs;
  RxInt selectedDivisionId = 0.obs;
  RxString selectedGrade = "Grade".obs;
  RxInt selectedGradeId = 0.obs;

  RxString selectedAddEvent = "".obs;
  RxString selectedAddEventError = "".obs;

  RxString firstFormError = "".obs;
  RxString secondFormError = "".obs;
  RxString thirdFormError = "".obs;

  RxInt currStep = 1.obs;
  RxInt year18Plus = 0.obs;
  RxString onChangeDatetime = "".obs;

  RxBool isLoading = false.obs;
  List<EventTypeModel> eventTypeList = [];
  List<GradeModel> gradeList = [];
  List<EventGradeModel> eventGradeList = [];
  RxList selectedEventIdsList = [].obs;

  @override
  void onInit() {
    getAllEventTypes();
    getAllGrades();
    getAllEventGrades();
    super.onInit();
  }

  bool validateFirstForm() {
    RxBool valid = true.obs;
    firstFormError.value = "";
    if (firstName.isEmpty) {
      firstFormError.value = '*Please enter first name';
      valid.value = false;
    } else if (lastName.isEmpty) {
      firstFormError.value = '*Please enter last name';
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
      firstFormError.value = '*Please enter valid email address';
      valid.value = false;
    } else if (dob.value == "Date of Birth") {
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

  bool validateParentForm() {
    RxBool valid = true.obs;
    firstFormError.value = "";
    if (pfirstName.isEmpty) {
      firstFormError.value = '*Please enter parent\'s first name';
      valid.value = false;
    } else if (plastName.isEmpty) {
      firstFormError.value = '*Please enter parent\'s last name';
      valid.value = false;
    } else if (pphoneNumber.isEmpty) {
      firstFormError.value = '*Please enter parent\'s phonenumber';
      valid.value = false;
    } else if (!Helper.isPhoneNumber(pphoneNumber.value)) {
      firstFormError.value = "*Please enter valid parent\'s phonenumber";
      valid.value = false;
    } else if (pemail.isEmpty) {
      firstFormError.value = 'Please enter parent\'s email';
      valid.value = false;
    } else if (!Helper.isEmail(pemail.value)) {
      firstFormError.value = '*Please enter valid parent\'s email';
      valid.value = false;
    }
    return valid.value;
  }

  bool validateSecondForm() {
    RxBool valid = true.obs;
    secondFormError.value = "";
    if (streetAddress.isEmpty) {
      secondFormError.value = '*Please enter street address';
      valid.value = false;
    } else if (apartMent.isEmpty) {
      secondFormError.value = '*Please enter apartment';
      valid.value = false;
    } else if (cityName.isEmpty) {
      secondFormError.value = '*Please enter city';
      valid.value = false;
    } else if (stateName.isEmpty) {
      secondFormError.value = '*Please enter state';
      valid.value = false;
    } else if (zipcode.isEmpty) {
      secondFormError.value = '*Please enter zipcode';
      valid.value = false;
    }
    return valid.value;
  }

  bool validateThirdForm() {
    RxBool valid = true.obs;
    thirdFormError.value = "";
    if (schoolName.isEmpty &&
        !["Open", "30's Plus"].contains(selectedDivision.value)) {
      thirdFormError.value = '*Please enter school name';
      valid.value = false;
    } else if (schoolCity.isEmpty) {
      thirdFormError.value = '*Please enter city';
      valid.value = false;
    } else if (schoolState.isEmpty) {
      thirdFormError.value = '*Please enter state';
      valid.value = false;
    } else if (schoolGrade.isEmpty) {
      thirdFormError.value = '*Please select grade';
      valid.value = false;
    }
    return valid.value;
  }

  void onSelectEvent(int eventIndex) {
    if (selectedEventIdsList.contains(eventIndex))
      selectedEventIdsList.remove(eventIndex);
    else if (selectedEventIdsList.length >= 2) {
      selectedEventIdsList.removeAt(0);
      selectedEventIdsList.add(eventIndex);
    } else {
      selectedEventIdsList.add(eventIndex);
    }
  }

  void onTapOnContiueBtn(context) {
    if (currStep.value == 1 && validateFirstForm()) {
      currStep.value = 2;
    } else if (currStep.value == 2 && validateSecondForm()) {
      currStep.value = 3;
    } else if (currStep.value == 3 && validateThirdForm()) {
      currStep.value = 4;
    } else if (selectedEventIdsList.length > 0) {
      if (year18Plus.value == 1) {
        Get.toNamed(Routes.VERIFY_EMAIL_SCREEN);
      } else {
        Get.toNamed(Routes.VERIFY_PHONE_SCREEN);
      }
    }
  }

  void onContinueWithGoogle() {}
  void onContinueWithFacebook() {}
  void onContinueWithApple() {}

  void setDivision() {
    if (["1st", "2nd", "3rd"].contains(selectedGrade.value)) {
      selectedDivision.value = "Elementary A";
    } else if (["4th", "5th"].contains(selectedGrade.value)) {
      selectedDivision.value = "Elementary B";
    } else if (["6th", "7th", "8th"].contains(selectedGrade.value)) {
      selectedDivision.value = "Middle School";
    } else if (["9th", "10th", "11th", "12th"].contains(selectedGrade.value)) {
      selectedDivision.value = "High School";
    } else if (selectedGrade.value == "30's Plus") {
      selectedDivision.value = "30 Plus";
    } else {
      selectedDivision.value = selectedGrade.value;
    }
  }

  void selectEventGrade() {
    List<GradeModel> gradeElement = gradeList
        .where((element) => element.name == selectedDivision.value)
        .toList();
    if (gradeElement.isNotEmpty) {
      selectedDivisionId.value = gradeElement[0].id;
    }
    schoolGrade.value = "select";
    if (selectedGrade.value == 'Grade') {
      selectedGrade.value = "2nd";
    }
    List<EventGradeModel> element = eventGradeList
        .where((element) => element.name == selectedGrade.value)
        .toList();
    selectedGradeId.value = element[0].id;
    setDivision();
    Navigator.of(Get.context).pop();
  }

  void getAllEventTypes() async {
    isLoading.value = true;
    var response = await EventTypeRepo.getEventTypesAPI();
    if (response != null) {
      response.forEach((element) {
        eventTypeList.add(EventTypeModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }

  void getAllGrades() async {
    isLoading.value = true;
    var response = await GradeRepo.getGradesAPI();
    if (response != null) {
      response.forEach((element) {
        gradeList.add(GradeModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }

  void getAllEventGrades() async {
    isLoading.value = true;
    var response = await EventGradeRepo.getEventGradesAPI();
    if (response != null) {
      response.forEach((element) {
        eventGradeList.add(EventGradeModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }
}
