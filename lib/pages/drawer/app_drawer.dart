import 'package:colgate/controllers/appdrawer/app_drawer_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  final AppDrawerController _con = Get.put(AppDrawerController());
  final prefs = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(appdawer: true),
      body: LocalStorage.token == null || LocalStorage.token.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  text: "LOGIN",
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN_SCREEN);
                  },
                  color: AppColors.accentColor,
                  textColor: AppColors.textwhiteColor,
                ),
                orLine(context),
                registerButton(),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    itemCount: _con.withoutLoginList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        leading: SvgPicture.asset(
                          _con.withoutLoginList[index][0],
                          color: AppColors.appColor,
                        ),
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.offAndToNamed(
                                Routes.SPECIAL_AWARD_SCREEN,
                              );
                              break;
                            case 1:
                              Get.offAndToNamed(Routes.CONTACT_SCREEN);
                              break;
                            case 2:
                              Get.offAndToNamed(Routes.FAQS_SCREEN);
                              break;
                            case 3:
                              Get.offAndToNamed(
                                  Routes.RULES_AND_REGULATIONS_SCREEN);
                              break;
                          }
                        },
                        title: Text(
                          _con.withoutLoginList[index][1],
                          style: TextStyle(
                            color: AppColors.appColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 0.1,
                          ),
                        ),
                      );
                    })
              ],
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 30),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  leading: SvgPicture.asset(
                    _con.list[index][0],
                    color: AppColors.appColor,
                  ),
                  onTap: () {
                    switch (index) {
                      case 0:
                        Get.offAndToNamed(
                          Routes.TiCKET_SCREEN,
                        );
                        break;
                      case 1:
                        Get.offAndToNamed(Routes.SPECIAL_AWARD_SCREEN);
                        break;
                      case 2:
                        Get.offAndToNamed(Routes.CONTACT_SCREEN);
                        break;
                      case 3:
                        Get.offAndToNamed(Routes.FAQS_SCREEN);
                        break;
                      case 4:
                        Get.offAndToNamed(Routes.RULES_AND_REGULATIONS_SCREEN);
                        break;
                      case 5:
                        Get.offAndToNamed(
                            Routes.NOTIFICATION_PREFERENCE_SCREEN);
                        break;
                      case 6:
                        LocalStorage.userType == "competitor"
                            ? Get.offAndToNamed(
                                Routes.EDIT_COMPETITOR_PROFILE_SCREEN,
                              )
                            : Get.offAndToNamed(
                                Routes.EDIT_SPECTATOR_PROFILE_SCREEN,
                              );
                        break;
                      case 7:
                        prefs.deleteAll().then((_) => Get.offAllNamed(
                              Routes.SPLASH,
                            ));
                        break;
                      default:
                        break;
                    }
                  },
                  title: Text(
                    _con.list[index][1],
                    style: TextStyle(
                      color: AppColors.appColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 0.1,
                    ),
                  ),
                );
              },
              itemCount: _con.list.length,
            ),
    );
  }

  registerButton() => ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.REGISTER_TYPE_SCREEN);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.accentColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
              side: BorderSide(
                color: AppColors.accentColor,
                width: 2,
              ),
            ),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            constraints: BoxConstraints(
              maxWidth: Dsize.width - 60,
              minHeight: Dsize.getSize(48, diffSize: 8),
            ),
            alignment: Alignment.center,
            child: Text(
              "REGISTER",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.accentColor,
                fontSize: Dsize.getSize(15, diffSize: 3),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.25,
              ),
            ),
          ),
        ),
      );

  orLine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: Dsize.getSize(
          15,
          diffSize: 5,
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: AppColors.accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "or",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
