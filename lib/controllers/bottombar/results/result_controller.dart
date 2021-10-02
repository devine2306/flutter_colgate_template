import 'package:colgate/models/drop_down/event_type_model.dart';
import 'package:colgate/models/competitor_model.dart';
import 'package:colgate/repository/bottom_bar/results/result_repo.dart';
import 'package:colgate/repository/drop_down/event_type_repo.dart';
import 'package:colgate/utils/config/overlay_loading.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  RxList selectedRace = [].obs;
  RxBool expand = false.obs;
  RxBool isLoading = false.obs;
  List<EventTypeModel> eventTypeList = [];
  List<CompetitorModel> competitors = [];
  selectRace(int index) {
    if (selectedRace.length == 1) {
      selectedRace.removeAt(0);
    }
    selectedRace.add(index);
  }

  @override
  void onInit() {
    getAllEventTypes();
    super.onInit();
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

  void getCompetitors(String searchInput) async {
    competitors.clear();
    LoadingOverlay.of(Get.context).show();
    var response = await ResultRepo.getCompetitorsAPI(searchInput);
    if (response != null) {
      response.forEach((element) {
        competitors.add(CompetitorModel.fromJson(element));
      });
    }

    if (competitors.isNotEmpty) {
      expand.value = true;
    } else {
      expand.value = false;
    }

    LoadingOverlay.of(Get.context).hide();
  }
}
