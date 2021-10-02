import 'dart:developer';

import 'package:colgate/models/users_model.dart';
import 'package:colgate/repository/spectator/profile_repo.dart';
import 'package:colgate/repository/spectator/spectator_ticket_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpectatorProfileScreenController extends GetxController {
  RxInt tabIndex = 0.obs;
  RxBool reserveTicket = false.obs;
  RxBool isLoading = false.obs;
  UsersModel userModel;
  RxString ticketURL = "".obs;

  @override
  void onInit() {
    getProfileDetails();
    getEventTicketURL();
    super.onInit();
  }

  ontab(int index) {
    tabIndex.value = index;
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

  getProfileDetails() async {
    isLoading.value = true;
    var res = await ProfileRepo.getProfileAPI();
    if (res != null) {
      userModel = UsersModel.fromJson(res);
    }
    isLoading.value = false;
  }

  getEventTicketURL() async {
    isLoading.value = true;
    SpectatorTicketRepo.getAllOrganizationsAPI().then((resOrg) {
      if (resOrg != null) {
        isLoading.value = true;
        SpectatorTicketRepo.getAllOrganizationsEventsAPI(
                orgId: resOrg['organizations'][0]['id'])
            .then((resOrgEvents) {
          if (resOrgEvents != null) {
            log(resOrgEvents['events'][0]['url'].toString());
            ticketURL.value = resOrgEvents['events'][0]['url'];
          }
        });
      }
      isLoading.value = false;
    });
    isLoading.value = false;
  }
}
