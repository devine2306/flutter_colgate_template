import 'dart:ui';

import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/config/app_colors.dart';
import '../../utils/config/app_images.dart';
import '../../utils/config/device_size.dart';
import '../../utils/config/globals.dart';

class AccountCreatedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(menu: false),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: Dsize.width,
              height: Dsize.height -
                  AppBar().preferredSize.height -
                  (window.viewPadding.bottom == 0
                      ? window.viewPadding.top
                      : window.viewPadding.bottom),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppImage.accountCreate),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Color(0xff009CA6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Get.arguments == "spectator"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Account created",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        color: AppColors.textwhiteColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppConfig.appFontFamily2,
                                        fontSize:
                                            Dsize.getSize(25, diffSize: 2),
                                      ),
                                ),
                              )
                            : Get.arguments == 'email'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 30,
                                      right: 30,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "Pre-registration submitted\n\n",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color:
                                                      AppColors.textwhiteColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(
                                                    22,
                                                    diffSize: 2,
                                                  ),
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                "A email has been sent to your parents to authorize your registration.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color:
                                                      AppColors.textwhiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(18,
                                                      diffSize: 2),
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 30,
                                      right: 30,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Entry form submitted\n",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color:
                                                      AppColors.textwhiteColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(
                                                    20,
                                                    diffSize: 2,
                                                  ),
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                "You're almost done. you will receive an email confirmation with information to complete your registration.\n\n",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color:
                                                      AppColors.textwhiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(18,
                                                      diffSize: 2),
                                                ),
                                          ),
                                          TextSpan(
                                            text: "Registration Day\n",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color:
                                                      AppColors.textwhiteColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(
                                                    20,
                                                    diffSize: 2,
                                                  ),
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                "Saturday, October 30,2021,10AM-2PM at the Armory.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color:
                                                      AppColors.textwhiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(18,
                                                      diffSize: 2),
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 25),
                          child: button(
                            text: Get.arguments == "spectator"
                                ? "Login"
                                : "Explore the app",
                            color: AppColors.textwhiteColor,
                            textColor: AppColors.accentColor,
                            fontWeight: FontWeight.w700,
                            onPressed: () {
                              Get.arguments == 'spectator'
                                  ? Get.back()
                                  : Get.toNamed(Routes.HOME_SCREEN,
                                      arguments: "competitor");
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
