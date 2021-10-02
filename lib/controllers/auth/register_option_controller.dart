import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterOptionController extends GetxController {
  final RxBool continueButton = false.obs;
  final List role = ["Fan", "Parent", "Coach", "Media"];
  RxString roleName = ''.obs;
}
