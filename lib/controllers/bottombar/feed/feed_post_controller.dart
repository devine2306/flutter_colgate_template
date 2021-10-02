import 'package:colgate/models/feed_model.dart';
import 'package:colgate/repository/feed_post_repo.dart';
import 'package:get/get.dart';

class FeedpostController extends GetxController {
  RxBool isLoading = false.obs;
  int feedId;
  FeedModel feedPost;

  @override
  void onInit() {
    feedId = Get.arguments;
    getFeedPost();
    super.onInit();
  }

  void getFeedPost() async {
    isLoading.value = true;
    var response = await FeedPostRepo.getFeedPostDetailAPI(feedId.toString());
    feedPost = FeedModel.fromJson(response);
    isLoading.value = false;
  }
}
