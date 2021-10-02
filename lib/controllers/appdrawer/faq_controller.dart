import 'package:colgate/models/faqs_model.dart';
import 'package:colgate/repository/drawer/faq_repo.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class FAQController extends GetxController {
  RxBool isLoading = false.obs;
  List<FaqModel> faqList = [];
  @override
  void onInit() {
    super.onInit();
    getFAQS();
  }

  getFAQS() async {
    isLoading.value = true;
    var res = await FAQRepo.getFAQAPI();
    if (res != null && res.isNotEmpty) {
      res[0]['FAQ'].forEach((element) {
        faqList.add(FaqModel.fromJson(element));
      });
    }
    isLoading.value = false;
  }
}
