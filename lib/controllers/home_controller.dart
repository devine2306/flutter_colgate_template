import 'dart:async';

import 'package:colgate/models/drop_down/grade_model.dart';
import 'package:colgate/models/feed_model.dart';
import 'package:colgate/repository/drop_down/grade_repo.dart';
import 'package:colgate/repository/feed_repo.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedBottomItem = 0.obs;
  RxBool isLoading = false.obs;
  RxList gradeList = [].obs;
  RxInt selectedEventFilter = 0.obs;
  List<FeedModel> feedList = [];

  @override
  void onInit() {
    getAllGrades();
    Dsize.init(MediaQuery.of(Get.context).size);
    getAllFeeds();
    LocalStorage.loadData();
    print(LocalStorage.token);
    print(LocalStorage.userEmail);
    print(LocalStorage.userId);
    print(LocalStorage.userType);
    print(LocalStorage.fullName);
    print(LocalStorage.under18);
    super.onInit();
  }

  List bottomIconList = [
    [AppImage.navHomesvg, "Home"],
    [AppImage.navFeedsvg, "Feed"],
    [AppImage.navSchedulesvg, "Schedule"],
    [AppImage.navResultssvg, "Results"],
    [AppImage.navProfilesvg, "Profile"]
  ];
  RxBool isTimerRunning = false.obs;

  Future<bool> willPopCallback() async {
    if (!isTimerRunning.value) {
      isTimerRunning.value = true;
      new Timer.periodic(new Duration(seconds: 2), (time) {
        isTimerRunning.value = false;
        time.cancel();
      });
      toast("Press back again to exit");
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
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

  void getAllFeeds() async {
    isLoading.value = true;
    var response = await FeedRepo.getAllFeedAPI();
    if (response != null) {
      response.forEach((element) {
        feedList.add(FeedModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }
}
