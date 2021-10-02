import 'package:colgate/models/option_model.dart';
import 'package:colgate/repository/bottom_bar/schedule/schedule_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  RxList selectedRace = [].obs;
  @override
  void onInit() {
    super.onInit();
    getAllGrades();
  }

  selectRace(int index) {
    if (selectedRace.length == 1) {
      selectedRace.removeAt(0);
    }
    selectedRace.add(index);
  }

  RxBool expand = false.obs;
  RxBool isLoading = false.obs;

  List<OptionModel> scheduleOptionList = [];
  void getAllGrades() async {
    isLoading.value = true;
    var response = await ScheduleRepo.getScheduleOptionAPI();
    if (response != null && response.isNotEmpty) {
      response['NavigationSchedule'].forEach((element) {
        scheduleOptionList.add(OptionModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }
}
