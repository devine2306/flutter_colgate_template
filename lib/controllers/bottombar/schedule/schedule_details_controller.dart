import 'package:colgate/models/drop_down/event_grade_model.dart';
import 'package:colgate/models/drop_down/event_stage_model.dart';
import 'package:colgate/models/drop_down/grade_model.dart';
import 'package:colgate/models/schedule_model.dart';
import 'package:colgate/repository/bottom_bar/schedule/schedule_repo.dart';
import 'package:colgate/repository/drop_down/event-grade_repo.dart';
import 'package:colgate/repository/drop_down/event_stage_repo.dart';
import 'package:colgate/repository/drop_down/grade_repo.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleDetailsController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  RxBool isLoading = false.obs;
  RxBool isPageLoading = false.obs;
  RxBool isScrolled = true.obs;
  RxBool expandEventGrade = false.obs;
  RxBool expandStage = false.obs;
  RxBool expandGrade = false.obs;
  RxString selectedEventGrade = "".obs;
  RxInt selectedEventGradeId = 0.obs;
  RxString selectedStage = "".obs;
  RxInt selectedStageId = 0.obs;
  RxString selectedGrade = "".obs;
  RxInt selectedGradeId = 0.obs;

  RxList eventStageList = [].obs;
  List<GradeModel> gradeList = [];
  RxList eventGradeList = [].obs;
  RxList filterEventGradeList = [].obs;
  RxList scheduleList = [].obs;

  onTapEventGrade() {
    expandEventGrade.value = !expandEventGrade.value;
    expandGrade.value = false;
    expandStage.value = false;
  }

  onTapEventStage() {
    expandStage.value = !expandStage.value;
    expandEventGrade.value = false;
    expandGrade.value = false;
  }

  onTapGrade() {
    expandGrade.value = !expandGrade.value;
    expandEventGrade.value = false;
    expandStage.value = false;
  }

  @override
  void onInit() {
    getAllEventStages();
    getAllGrades();
    getAllEventGrades().then((_) => setEventGrade().then((_) => getSchedule()));
    super.onInit();
  }

  filter(List list) => filterEventGradeList.value = eventGradeList
      .where(
        (element) => list.contains(element.name),
      )
      .toList();

  Future setEventGrade() async {
    switch (selectedGrade.value) {
      case "Elementary A":
        filter(["1st", "2nd", "3rd"]);
        break;
      case "Elementary B":
        filter(["4th", "5th"]);
        break;
      case "Middle School":
        filter(["6th", "7th", "8th"]);
        break;
      case "High School":
        filter(["9th", "10th", "11th", "12th"]);
        break;
      case "30 Plus":
        filter(["30's Plus"]);
        break;
      default:
        filterEventGradeList.value = eventGradeList;
        break;
    }
    if (filterEventGradeList.isNotEmpty) {
      selectedEventGrade.value = filterEventGradeList[0].name;
      selectedEventGradeId.value = filterEventGradeList[0].id;
    }
  }

  void getAllEventStages() async {
    isLoading.value = true;
    var response = await EventStageRepo.getEventStagesAPI();
    response.forEach((element) {
      eventStageList.add(EventStageModel.fromJson(element));
    });
    selectedStage.value = eventStageList[0].name;
    selectedStageId.value = eventStageList[0].id;
    isLoading.value = false;
  }

  Future getAllGrades() async {
    isLoading.value = true;
    var response = await GradeRepo.getGradesAPI();
    if (response != null) {
      response.forEach((element) {
        gradeList.add(GradeModel.fromJson(element));
      });
      List<GradeModel> selectedEventList =
          gradeList.where((element) => element.id == Get.arguments).toList();
      selectedGrade.value = selectedEventList[0].name;
      selectedGradeId.value = selectedEventList[0].id;
    }
    isLoading.value = false;
  }

  Future getAllEventGrades() async {
    isLoading.value = true;
    var response = await EventGradeRepo.getEventGradesAPI();
    if (response != null) {
      response.forEach((element) {
        eventGradeList.add(EventGradeModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }

  void getSchedule() async {
    if (isPageLoading.value) {
      LoadingOverlay.of(Get.context).show();
    } else {
      isLoading.value = true;
    }

    scheduleList.clear();
    var response = await ScheduleRepo.getScheduleAPI(
      eventDivisionId: selectedGradeId.value,
      eventStage: selectedStageId.value,
      eventGradeId: selectedEventGradeId.value,
    );
    if (response != null && response.isNotEmpty) {
      response[0]['Schedule'].forEach((element) {
        scheduleList.add(ScheduleModel.fromJson(element));
      });
    }
    if (isPageLoading.value) {
      LoadingOverlay.of(Get.context).hide();
      isPageLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
