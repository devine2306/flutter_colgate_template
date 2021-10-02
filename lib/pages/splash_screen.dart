import 'package:colgate/controllers/auth/splash_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/config/app_colors.dart';
import '../utils/config/device_size.dart';
import '../utils/config/globals.dart';
import '../utils/navigation/routes.dart';

class SplashScreen extends GetView<SplashController> {
  final SplashController _con = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _con.willPopCallback,
      child: Scaffold(
        backgroundColor: Color(0xff7BB6BD),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Image.asset(
                  AppImage.colgateLogoWhitepng,
                  height: Dsize.height * 0.06,
                ),
                Container(
                  height: Dsize.height * 0.15,
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to the 47th\nseason of Colgate\nWomen's Games",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppConfig.appFontFamily2,
                      fontWeight: FontWeight.w400,
                      fontSize: Dsize.getSize(24, diffSize: 7),
                      color: Colors.white,
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      AppImage.splashjpg,
                      width: double.infinity,
                      height: Dsize.getSize(
                        Dsize.height * 0.6,
                        diffSize: -Dsize.height * 0.1,
                      ),
                      fit: BoxFit.fill,
                    ),
                    button(
                      text: "SIGNUP",
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER_TYPE_SCREEN);
                      },
                      color: AppColors.textwhiteColor,
                      textColor: AppColors.accentColor,
                    ),
                  ],
                ),
                // Positioned(
                //   right: -Dsize.height * 0.08,
                //   top: Dsize.height * 0.22,
                //   bottom: 0,
                //   child: GestureDetector(
                //     onTap: () {
                //       Get.toNamed(
                //         Routes.HOME_SCREEN,
                //       );
                //     },
                //     child: CircleAvatar(
                //       backgroundColor: AppColors.appColor,
                //       radius: Dsize.height * 0.07,
                //       child: Row(
                //         mainAxisAlignment:
                //             MainAxisAlignment.spaceAround,
                //         children: [
                //           SvgPicture.asset(
                //             AppImage.chevronRightsvg,
                //           ),
                //           Container(),
                //         ],
                //       ),
                //     ),
                //   ),
                // )
                SizedBox(
                  height: Dsize.height * 0.03,
                ),
                button(
                  text: "LOGIN",
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN_SCREEN);
                  },
                  color: AppColors.textwhiteColor,
                  textColor: AppColors.accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
