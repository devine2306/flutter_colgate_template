import 'dart:io';

import 'package:colgate/controllers/spectator/spectator_profile_controller.dart';
import 'package:colgate/models/users_model.dart';
import 'package:colgate/repository/spectator/profile_repo.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class EditSpectatorProfileController extends GetxController {
  SpectatorProfileScreenController _controller = Get.find();

  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameFocus = FocusNode();
  RxString firstname = "".obs;

  TextEditingController lastNameController = TextEditingController();
  FocusNode lastNameFocus = FocusNode();
  RxString lastname = "".obs;

  TextEditingController phoneNumberControlller = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  RxString phoneNumber = "".obs;

  RxBool isLoading = false.obs;
  RxString userType = ''.obs;
  UsersModel userModel;
  Rx<File> profileImage = File("").obs;
  dio.MultipartFile multipartFile;

  RxString profileID = ''.obs;

  final picker = ImagePicker();

  @override
  void onInit() {
    getProfileDetails();
    super.onInit();
  }

  getProfileDetails() async {
    isLoading.value = true;
    var res = await ProfileRepo.getProfileAPI();
    if (res != null) {
      userModel = UsersModel.fromJson(res);
      firstNameController.text = userModel?.userType[0]?.firstName ?? "";
      lastNameController.text = userModel?.userType[0]?.lastName ?? "";
      phoneNumberControlller.text = userModel?.userType[0]?.phoneNumber ?? "";
      userType.value = userModel?.userType[0]?.userType;
    }
    isLoading.value = false;
  }

  updateProfileDetails(context) async {
    LoadingOverlay.of(context).show();
    if (multipartFile != null) {
      var response = await ProfileRepo.uploadProfile(multipartFile);
      profileID.value = response[0]['id'].toString();
    }
    var res = await ProfileRepo.updateSpectatorProfileAPI(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneNumberControlller.text,
      image: multipartFile,
      usersModel: userModel,
      profileID: profileID.value,
    );
    LoadingOverlay.of(context).hide();
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
}
