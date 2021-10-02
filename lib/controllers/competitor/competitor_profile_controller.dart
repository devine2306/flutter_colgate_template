import 'package:colgate/models/users_model.dart';
import 'package:colgate/repository/spectator/profile_repo.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompetitorProfileController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  RxInt tabIndex = 0.obs;
  RxBool selected = false.obs;
  RxBool isLoading = false.obs;

  final List<List<String>> listOfWorkOuts = [
    [AppImage.championPostjpg, "50 Miles in 10 Days", "10% Completed"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "100% Completed"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, "50 Miles in 10 Days", "Begin Workout"],
    [AppImage.championPostjpg, " 50 Miles in 10 Days", "Begin Workout"],
  ];

  RxList<RxList> listOfEvents = [
    ["Week 1 Results", false].obs,
    ["Week 2 Results", false].obs,
    ["Week 3 Results", false].obs,
    ["Semi-finals Results", false].obs,
    ["Finals Results", false].obs,
    ["Cumulative", false].obs,
  ].obs;

  RxList<RxList> listOfSchedule = [
    ["Dec 16: Preliminary Week 1", false].obs,
    ["Week 2", false].obs,
    ["Week 3", false].obs,
    ["Semi-finals", false].obs,
    ["Finals", false].obs,
  ].obs;

  UsersModel userModel;
  RxList selectedRace = [].obs;
  selectRace(int index) {
    if (selectedRace.length == 1) {
      selectedRace.removeAt(0);
    }
    selectedRace.add(index);
  }

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
    }
    isLoading.value = false;
  }
}
