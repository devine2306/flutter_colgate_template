import 'package:colgate/models/competitor_model.dart';
import 'package:colgate/repository/competitor/competitor_repo.dart';
import 'package:get/get.dart';

class ResultCompetitorProfileController extends GetxController {
  RxList<RxList> listOfEvents = [
    ["Week 1 Results", false].obs,
    ["Week 2 Results", false].obs,
    ["Week 3 Results", false].obs,
    ["Semi-finals Results", false].obs,
    ["Finals Results", false].obs,
    ["Cumulative", false].obs,
  ].obs;
  RxList<Map<String, Object>> events = [
    {"title": "Week 1 Results".obs, "bool": false.obs},
  ].obs;

  RxBool isLoading = false.obs;
  CompetitorModel competitorModel;

  @override
  void onInit() {
    getCompetitorProfileDetails();
    super.onInit();
  }

  getCompetitorProfileDetails() async {
    isLoading.value = true;
    var res = await CompetitorRepo.getCompetitorAPI(Get.arguments.toString());
    if (res != null) {
      competitorModel = CompetitorModel.fromJson(res);
    }
    isLoading.value = false;
  }
}
