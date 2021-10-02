import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketController extends GetxController {
  List weeks = [
    "Week 1",
    "Week 2",
    "Week 3",
    "Week 4",
    "Week 5",
    "Week 6",
    "Week 7",
  ];
  RxList selectedWeek = [0].obs;
  ontap(int index) {
    if (selectedWeek.length == 1) {
      selectedWeek.removeAt(0);
      selectedWeek.add(index);
    }
  }

  TextEditingController eventController = TextEditingController();
  FocusNode eventFocus = FocusNode();
  RxString event = "".obs;

  TextEditingController dateTimeController = TextEditingController();
  FocusNode dateTimeFocus = FocusNode();
  RxString dateTime = "".obs;

  TextEditingController venueController = TextEditingController();
  FocusNode venueFocus = FocusNode();
  RxString venue = "".obs;
}
