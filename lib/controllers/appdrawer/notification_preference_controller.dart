import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NotificationPreferenceController extends GetxController {
  RxBool upcomingEvents = false.obs;
  RxBool newResults = false.obs;
}
