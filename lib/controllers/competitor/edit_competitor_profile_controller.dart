import 'dart:io';

import 'package:colgate/controllers/competitor/competitor_profile_controller.dart';
import 'package:colgate/models/drop_down/event_grade_model.dart';
import 'package:colgate/models/drop_down/event_type_model.dart';
import 'package:colgate/models/drop_down/grade_model.dart';
import 'package:colgate/models/users_model.dart';
import 'package:colgate/repository/drop_down/event-grade_repo.dart';
import 'package:colgate/repository/drop_down/event_type_repo.dart';
import 'package:colgate/repository/drop_down/grade_repo.dart';
import 'package:colgate/repository/spectator/profile_repo.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class EditCompetitorProfileController extends GetxController {
  CompetitorProfileController _controller = Get.find();

  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameFocus = FocusNode();
  RxString firstname = "".obs;

  TextEditingController lastNameController = TextEditingController();
  FocusNode lastNameFocus = FocusNode();
  RxString lastname = "".obs;

  TextEditingController phoneNumberControlller = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  RxString phoneNumber = "".obs;

  TextEditingController instagramController = TextEditingController();
  FocusNode instagramFoccus = FocusNode();
  RxString instagram = "".obs;

  TextEditingController facebookController = TextEditingController();
  FocusNode facebookFocus = FocusNode();
  RxString facebook = "".obs;

  TextEditingController tiktokController = TextEditingController();
  FocusNode tiktokFocus = FocusNode();
  RxString tiktok = "".obs;

  TextEditingController addressController = TextEditingController();
  FocusNode addressFocus = FocusNode();
  RxString address = "".obs;

  TextEditingController cityController = TextEditingController();
  FocusNode cityFocus = FocusNode();
  RxString city = "".obs;

  TextEditingController stateController = TextEditingController();
  FocusNode stateFocus = FocusNode();
  RxString statename = "".obs;

  TextEditingController zipCodeController = TextEditingController();
  FocusNode zipcodeFocus = FocusNode();
  RxString zipCode = "".obs;

  TextEditingController schoolNameController = TextEditingController();
  FocusNode schoolNameFocus = FocusNode();
  RxString schoolName = "".obs;

  TextEditingController schoolCityController = TextEditingController();
  FocusNode schoolCityFocus = FocusNode();
  RxString schoolCity = "".obs;

  TextEditingController divisionController = TextEditingController();
  FocusNode divisionFocus = FocusNode();

  RxList selectedEvent = [].obs;
  RxList selectedEventId = [].obs;
  RxList eventTypeList = [].obs;
  List<GradeModel> gradeList = [];
  List<EventGradeModel> eventGradeList = [];
  UsersModel userModel;
  RxString selectedGrade = "".obs;
  RxInt initialIndex = 1.obs;
  RxInt selectedDivisionId = 0.obs;
  RxInt selectedGradeId = 0.obs;

  Rx<File> profileImage = File("").obs;
  dio.MultipartFile multipartFile;
  void ontap(int eventId) {
    if (selectedEvent.contains(eventId))
      selectedEvent.remove(eventId);
    else if (selectedEvent.length >= 2) {
      selectedEvent.removeAt(0);
      selectedEvent.add(eventId);
    } else {
      selectedEvent.add(eventId);
    }
  }

  RxBool isLoading = false.obs;
  final picker = ImagePicker();
  RxString profileID = ''.obs;

  @override
  void onInit() {
    getProfileDetails().then((_) => getAllEventTypes());
    getAllGrades();
    getAllEventGrades();
    super.onInit();
  }

  void getAllEventTypes() async {
    isLoading.value = true;
    var response = await EventTypeRepo.getEventTypesAPI();

    if (response != null) {
      response.forEach((element) {
        eventTypeList.add(EventTypeModel.fromJson(element));
      });
      if (userModel != null && userModel?.userType[0] != null) {
        List events = eventTypeList
            .where((element) => [
                  userModel?.userType[0]?.eventTypeOne?.id,
                  userModel?.userType[0]?.eventTypeTwo?.id
                ].contains(element.id))
            .toList();
        events.forEach((element) {
          selectedEvent.add(element.id);
        });
      }
      isLoading.value = false;
    }
  }

  getProfileDetails() async {
    isLoading.value = true;
    var res = await ProfileRepo.getProfileAPI();
    if (res != null) {
      userModel = UsersModel.fromJson(res);
      firstNameController.text = userModel?.userType[0]?.firstName ?? "";
      lastNameController.text = userModel?.userType[0]?.lastName ?? "";
      phoneNumberControlller.text = userModel?.userType[0]?.phoneNumber ?? "";
      schoolNameController.text =
          userModel?.userType[0]?.school?.schoolName ?? "";
      schoolCityController.text =
          userModel?.userType[0]?.school?.schoolCity ?? "";
      stateController.text =
          userModel?.userType[0]?.address?.addressState ?? "";
      zipCodeController.text =
          userModel?.userType[0]?.address?.addressZipCode?.toString() ?? "";
      cityController.text = userModel?.userType[0]?.address?.addressCity ?? "";
      addressController.text =
          userModel?.userType[0]?.address?.addressStreet ?? "";
      divisionController.text =
          userModel?.userType[0]?.eventDivision?.name ?? "";
      selectedDivisionId.value = userModel?.userType[0]?.eventDivision?.id;
      selectedGrade.value = userModel?.userType[0]?.eventGrade?.grade ?? "";
      selectedGradeId.value = userModel?.userType[0]?.eventGrade?.id;
      isLoading.value = false;
    }
  }

  updateProfileDetails() async {
    LoadingOverlay.of(Get.context).show();
    if (multipartFile != null) {
      var response = await ProfileRepo.uploadProfile(multipartFile);
      profileID.value = response[0]['id'].toString();
    }
    var res = await ProfileRepo.updateCompetitorProfileAPI(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneNumberControlller.text,
      addressCity: cityController.text,
      addressState: stateController.text,
      addressStreet: addressController.text,
      schoolCity: schoolCityController.text,
      schoolName: schoolNameController.text,
      zipcode: zipCodeController.text,
      eventTypeOne: selectedEvent.length > 0 ? selectedEvent[0] : null,
      eventTypeTwo: selectedEvent.length > 1 ? selectedEvent[1] : null,
      usersModel: userModel,
      profileID: profileID.value,
      eventDivision: selectedDivisionId.value,
      eventGrade: selectedGradeId.value,
    );
    LoadingOverlay.of(Get.context).hide();
    if (res != null) {
      Get.back();
      _controller.getProfileDetails();
    }
  }

  void pickProfileFile(context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () async {
                Get.back();
                await picImage(false);
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text("Gallery"),
              onTap: () async {
                Get.back();
                await picImage(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future picImage(bool fromGallery) async {
    PickedFile pickedFile;
    try {
      pickedFile = await picker.getImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 500,
        maxWidth: 500,
      );
    } catch (e) {
      print(e);
    }
    if (pickedFile != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 300, ratioY: 300),
        compressQuality: 50,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit',
          statusBarColor: AppColors.appColor,
          toolbarColor: AppColors.appColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Edit',
        ),
      );
      if (croppedFile != null) {
        profileImage.value = File(croppedFile.path);
        multipartFile = dio.MultipartFile.fromFileSync(
          File(croppedFile.path).path,
          filename: path.basename(File(croppedFile.path).path),
        );
      }
    } else
      return;
  }

  void setDivision() {
    if (["1st", "2nd", "3rd"].contains(selectedGrade.value)) {
      divisionController.text = "Elementary A";
    } else if (["4th", "5th"].contains(selectedGrade.value)) {
      divisionController.text = "Elementary B";
    } else if (["6th", "7th", "8th"].contains(selectedGrade.value)) {
      divisionController.text = "Middle School";
    } else if (["9th", "10th", "11th", "12th"].contains(selectedGrade.value)) {
      divisionController.text = "High School";
    } else if (selectedGrade.value == "30's Plus") {
      divisionController.text = "30 Plus";
    } else {
      divisionController.text = selectedGrade.value;
    }
  }

  void selectEventGrade() {
    setDivision();
    List<GradeModel> gradeElement = gradeList
        .where((element) => element.name == divisionController.text)
        .toList();
    if (gradeElement.isNotEmpty) {
      print(gradeElement[0].id);
      selectedDivisionId.value = gradeElement[0].id;
    }
    List<EventGradeModel> element = eventGradeList
        .where((element) => element.name == selectedGrade.value)
        .toList();
    selectedGradeId.value = element[0].id;
    Navigator.of(Get.context).pop();
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
}
