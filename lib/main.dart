import 'package:colgate/controllers/competitor/competitor_profile_controller.dart';
import 'package:colgate/controllers/spectator/spectator_profile_controller.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:colgate/utils/config/theme.dart';
import 'utils/navigation/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.loadData();
  LazyBindings().dependencies();
  runApp(MyApp());
}

class LazyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpectatorProfileScreenController>(
        () => SpectatorProfileScreenController());
    Get.lazyPut<CompetitorProfileController>(
        () => CompetitorProfileController());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(LocalStorage.token);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LocalStorage.token == null || LocalStorage.token.isEmpty
          ? Routes.SPLASH
          : Routes.HOME_SCREEN,
      title: AppConfig.appName,
      theme: appThemeData,
      defaultTransition: Transition.rightToLeft,
      // transitionDuration: Duration(milliseconds: 800),
      getPages: AppPages.pages,
    );
  }
}
