import 'package:colgate/controllers/auth/register_option_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/config/app_colors.dart';
import '../../utils/config/device_size.dart';
import '../../utils/config/globals.dart';
import '../../utils/navigation/routes.dart';

class RegisterOptionsScreen extends StatelessWidget {
  final RegisterOptionController _con = Get.put(RegisterOptionController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: Color(0xff7BB6BD),
            appBar: appbar(),
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: Dsize.height * 0.15,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text(
                      "Welcome to the 47th\nseason of Colgate\nWomen's Games",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppConfig.appFontFamily2,
                        fontWeight: FontWeight.w400,
                        fontSize: Dsize.getSize(24, diffSize: 7),
                        color: AppColors.appColor,
                      ),
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: Dsize.getSize(Dsize.height * 0.66,
                            diffSize: -Dsize.height * 0.1),
                        width: Dsize.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              AppImage.joinTheGamesPostjpg,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Signup",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dsize.getSize(32, diffSize: 5),
                                    fontFamily: AppConfig.appFontFamily2,
                                  ),
                            ),
                            Spacer(),
                            button(
                              color: AppColors.textwhiteColor,
                              onPressed: () {
                                _con.roleName.value = "Competitor";
                                Get.toNamed(
                                  Routes.REGISTER_COMPETITOR_SCREEN,
                                );
                              },
                              text: "I'M AN ATHLETE",
                              textColor: AppColors.accentColor,
                            ),
                            orLine(context),
                            button(
                              color: AppColors.textwhiteColor,
                              onPressed: bottomSheet,
                              text: "I'M A...",
                              textColor: AppColors.accentColor,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!_con.continueButton.value)
            Container(
              color: Colors.black.withOpacity(0.8),
              height: Dsize.height,
              width: Dsize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create your account and\ncomplete entry form here.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: Dsize.getSize(25, diffSize: 5),
                          letterSpacing: 0.25,
                          fontFamily: AppConfig.appFontFamily2,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dsize.getSize(80, diffSize: 20),
                      vertical: 20,
                    ),
                    child: button(
                      text: "CONTINUE",
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.white,
                      onPressed: () {
                        _con.continueButton.value = !_con.continueButton.value;
                      },
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  bottomSheet() async {
    await Get.bottomSheet(
      BottomSheet(
        backgroundColor: Colors.transparent,
        onClosing: () {},
        builder: (context) {
          return Container(
            height: Dsize.getSize(65, diffSize: 15) *
                double.parse(_con.role.length.toString()),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: Dsize.getSize(30, diffSize: 5),
                right: Dsize.getSize(30, diffSize: 5),
                top: Dsize.getSize(25, diffSize: 10),
              ),
              itemCount: _con.role.length,
              separatorBuilder: (context, index) {
                return Container(height: 2, color: Colors.grey[300]);
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _con.roleName.value = _con.role[index];
                    Get.back();
                    Get.toNamed(
                      Routes.REGISTER_SPECTATOR_SCREEN,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _con.role[index],
                          style: TextStyle(
                            fontFamily: AppConfig.appFontFamily2,
                            fontSize: Dsize.getSize(20, diffSize: 4),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: AppColors.accentColor,
                          radius: Dsize.getSize(15, diffSize: 5),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: Dsize.getSize(15, diffSize: 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  orLine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: Dsize.getSize(25, diffSize: 10),
      ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 3,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "or",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Flexible(
            child: Container(
              height: 3,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
