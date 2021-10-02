import 'package:colgate/models/drop_down/event_stage_model.dart';
import 'package:colgate/models/drop_down/event_type_model.dart';
import 'package:colgate/models/drop_down/grade_model.dart';
import 'package:colgate/models/results/results_model.dart';
import 'package:colgate/repository/drop_down/event_stage_repo.dart';
import 'package:colgate/repository/drop_down/event_type_repo.dart';
import 'package:colgate/repository/drop_down/grade_repo.dart';
import 'package:colgate/repository/result_repo.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultDetailsController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  RxBool expandType = false.obs;
  RxBool expandYear = false.obs;
  RxBool expandStage = false.obs;
  RxBool expandGrade = false.obs;
  RxBool isLoading = false.obs;
  RxBool isPageLoading = false.obs;

  onTaptype() {
    expandType.value = !expandType.value;
    expandYear.value = false;
    expandStage.value = false;
    expandGrade.value = false;
  }

  onTapYear() {
    expandYear.value = !expandYear.value;
    expandType.value = false;
    expandStage.value = false;
    expandGrade.value = false;
  }

  onTapStage() {
    expandStage.value = !expandStage.value;
    expandType.value = false;
    expandYear.value = false;
    expandGrade.value = false;
  }

  onTapGrade() {
    expandGrade.value = !expandGrade.value;
    expandType.value = false;
    expandYear.value = false;
    expandStage.value = false;
  }

  RxString selectedType = "".obs;
  RxString selectedYear = "".obs;
  RxString selectedStage = "".obs;
  RxString selectedGrade = "".obs;

  RxInt selectedTypeId = 0.obs;
  RxInt selectedStageId = 0.obs;
  RxInt selectedGradeId = 0.obs;

  List listOfYear = [];

  List<EventStageModel> eventStageList = [];
  List<EventTypeModel> eventTypeList = [];
  List<GradeModel> gradeList = [];
  RxList resultList = [].obs;

  @override
  void onInit() {
    yearList();
    getAllEventStages();
    getAllEventTypes();
    getAllGrades().then((_) => getAllResults());
    super.onInit();
  }

  void getAllResults() async {
    resultList.clear();
    if (isPageLoading.value) {
      LoadingOverlay.of(Get.context).show();
    } else {
      isLoading.value = true;
    }
    var response = await ResultRepo.getAllResultsAPI(
      eventType: selectedTypeId.value,
      eventGradeId: selectedGradeId.value,
      eventStage: selectedStageId.value,
    );

    if (response != null && response.isNotEmpty) {
      response[0]['Entries'].forEach((element) {
        resultList.add(ResultModel.fromJson(element));
      });
      isLoading.value = false;
    }
    if (isPageLoading.value) {
      LoadingOverlay.of(Get.context).hide();
    } else {
      isLoading.value = false;
    }
    print(resultList.length);
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

  void getAllEventTypes() async {
    isLoading.value = true;
    var response = await EventTypeRepo.getEventTypesAPI();

    if (response != null) {
      response.forEach((element) {
        eventTypeList.add(EventTypeModel.fromJson(element));
      });
    }
    List<EventTypeModel> selectedEventType =
        eventTypeList.where((element) => element.id == Get.arguments).toList();
    selectedType.value = selectedEventType[0].name;
    selectedTypeId.value = selectedEventType[0].id;
    isLoading.value = false;
  }

  Future getAllGrades() async {
    isLoading.value = true;
    var response = await GradeRepo.getGradesAPI();
    if (response != null) {
      response.forEach((element) {
        gradeList.add(GradeModel.fromJson(element));
      });
    }

    selectedGrade.value = gradeList[0].name;
    selectedGradeId.value = gradeList[0].id;
    isLoading.value = false;
  }

  yearList() {
    for (int i = DateTime.now().year; i > 2013; i--) {
      listOfYear.add(Year(name: i.toString()));
    }
    selectedYear.value = listOfYear[0].name;
  }
}

class Year {
  String name;
  Year({this.name});
}
