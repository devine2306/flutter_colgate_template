import 'dart:async';

import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Dsize.init(MediaQuery.of(Get.context).size);
    LocalStorage.loadData();
    super.onInit();
  }

  /// * init mediaquery size globally
  RxBool isTimerRunning = false.obs;

  Future<bool> willPopCallback() async {
    if (!isTimerRunning.value) {
      isTimerRunning.value = true;
      new Timer.periodic(new Duration(seconds: 2), (time) {
        isTimerRunning.value = false;
        time.cancel();
      });
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }
}
