// import 'package:colgate/utils/config/app_images.dart';

import 'package:colgate/models/feed_model.dart';
import 'package:colgate/repository/feed_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  RxInt selectedBottomItem = 0.obs;
  RxBool isDrawerOpen = false.obs;
  RxList selectedFeed = [].obs;
  ScrollController scrollController;
  RxBool isScrolled = true.obs;
  RxBool isLoading = false.obs;
  List<FeedModel> feedList = [];

  @override
  void onInit() {
    getAllFeeds();
    super.onInit();
  }

  selectFeed(int index) {
    if (index != 0) {
      if (selectedFeed.length == 1) {
        selectedFeed.removeAt(0);
      }
      selectedFeed.add(index);
    }
  }

  void getAllFeeds() async {
    feedList.clear();
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
