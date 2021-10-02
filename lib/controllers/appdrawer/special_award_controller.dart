import 'package:colgate/models/award_model.dart';
import 'package:colgate/repository/drawer/special_award_repo.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:get/get.dart';

class SpecialAwaredController extends GetxController {
  List<Year> listOfyear = [];
  RxBool expand = false.obs;
  RxString selectedYear = "".obs;
  RxBool isLoading = false.obs;
  RxBool isPageLoading = false.obs;
  RxList speciaAwardList = [].obs;

  @override
  void onInit() {
    super.onInit();
    yearList();
    getAwards();
  }

  onTap() {
    expand.value = !expand.value;
  }

  void getAwards() async {
    print(selectedYear.value);
    speciaAwardList.clear();
    if (isPageLoading.value) {
      LoadingOverlay.of(Get.context).show();
    } else {
      isLoading.value = true;
    }
    var response =
        await SpecialAwardRepo.getSpecialAwardAPI(selectedYear.value);
    if (response != null && response.isNotEmpty) {
      response[0]["Awards"].forEach((element) {
        speciaAwardList.add(SpecialAwardModel.fromJson(element));
      });
    }

    if (isPageLoading.value) {
      LoadingOverlay.of(Get.context).hide();
    } else {
      isLoading.value = false;
    }
  }

  yearList() {
    for (int i = DateTime.now().year; i > 2013; i--) {
      listOfyear.add(Year(name: i.toString()));
    }
    selectedYear.value = listOfyear[0].name;
  }
}

class Year {
  String name;
  Year({this.name});
}
