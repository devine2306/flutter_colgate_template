import 'package:colgate/utils/config/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawerController extends GetxController {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  final List<List<String>> list = [
    [
      AppImage.file,
      "Ticket",
    ],
    [
      AppImage.award,
      "Special Awards",
    ],
    [
      AppImage.contact,
      "Contact",
    ],
    [
      AppImage.edit,
      "FAQs",
    ],
    [
      AppImage.info,
      "Rules & Regulations",
    ],
    [
      AppImage.flag,
      "Notification Preferences",
    ],
    [
      AppImage.settings,
      "Edit Profile",
    ],
    [
      AppImage.logout,
      "Logout",
    ],
  ];
  final List withoutLoginList = [
    [
      AppImage.award,
      "Awards",
    ],
    [
      AppImage.contact,
      "Contact",
    ],
    [
      AppImage.info,
      "FAQs",
    ],
    [
      AppImage.info,
      "Rules & Reguations",
    ],
  ];
}
