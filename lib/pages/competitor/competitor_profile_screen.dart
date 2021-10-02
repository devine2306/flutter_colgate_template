import 'package:colgate/controllers/competitor/competitor_profile_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CompetitorProfileScreen extends StatelessWidget {
  final CompetitorProfileController _con =
      Get.put(CompetitorProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.isLoading.value
          ? AppLoader()
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  discription(context),
                  Container(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        userName(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            profileDetails(context),
                            profilePointsDetails(context),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            socialMedia(
                              context,
                              "  Add facebook",
                              AppImage.facebook,
                              color: AppColors.accentColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            socialMedia(
                              context,
                              "  Add Instagram",
                              AppImage.instagram,
                              color: AppColors.accentColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            socialMedia(
                              context,
                              "   Add Tiktok",
                              AppImage.tiktok,
                              color: AppColors.accentColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Add bio text",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.accentColor,
                                    fontFamily: AppConfig.appFontFamily2,
                                    fontSize: Dsize.getSize(
                                      14,
                                      diffSize: 2,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            container(
                              AppColors.appColor,
                              _con?.userModel?.userType[0].eventTypeOne?.name ??
                                  "",
                              Dsize.width * 0.4,
                              Dsize.getSize(8, diffSize: 3),
                            ),
                            container(
                              AppColors.appColor,
                              _con?.userModel?.userType[0]?.eventTypeTwo
                                      ?.name ??
                                  "",
                              Dsize.width * 0.4,
                              Dsize.getSize(8, diffSize: 3),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Share a moment",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentColor,
                                fontFamily: AppConfig.appFontFamily2,
                                fontSize: Dsize.getSize(
                                  30,
                                  diffSize: 5,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImage.facebook,
                              color: AppColors.accentColor,
                              height: Dsize.getSize(
                                30,
                                diffSize: 5,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              AppImage.instagram,
                              color: AppColors.accentColor,
                              height: Dsize.getSize(
                                30,
                                diffSize: 5,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  tabbar(),
                  Obx(
                    () => _con.tabIndex.value == 0
                        ? result(context)
                        : schedule(context),
                  ),
                ],
              ),
            ),
    );
  }

  socialMedia(context, String text, String icon,
          {Color color = Colors.black}) =>
      Row(
        children: [
          SvgPicture.asset(icon),
          Text(
            text,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontFamily: AppConfig.appFontFamily2,
                  fontSize: Dsize.getSize(
                    12,
                    diffSize: 2,
                  ),
                  letterSpacing: 0.15,
                ),
          ),
        ],
      );

  userName() => Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      "${_con?.userModel?.userType[0]?.firstName ?? ""} ${_con?.userModel?.userType[0]?.lastName ?? ""}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.appColor,
                    fontSize: 22,
                  ),
                ),
                TextSpan(
                  text: " Edit Profile",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Get.toNamed(Routes.EDIT_COMPETITOR_PROFILE_SCREEN),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  profilePointsDetails(context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "${_con?.userModel?.userType[0]?.points ?? "0"}",
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.black,
                    fontSize: Dsize.getSize(
                      50,
                      diffSize: 10,
                    ),
                  ),
            ),
          ),
          forshareandcheers(context, AppImage.share, "Shares", "0"),
          forshareandcheers(context, AppImage.cheerIcon, "Cheers",
              "${_con?.userModel?.userType[0]?.cheerCount ?? "0"}"),
        ],
      );

  forshareandcheers(context, String icon, String title, String point) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: Colors.black,
                  height: Dsize.getSize(30, diffSize: 10),
                ),
                Text(
                  " " + title,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: AppConfig.appFontFamily2,
                        fontSize: Dsize.getSize(
                          Dsize.getSize(
                            20,
                            diffSize: 2,
                          ),
                          diffSize: 5,
                        ),
                        letterSpacing: 0.15,
                      ),
                ),
              ],
            ),
            Text(
              point,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentColor,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: Dsize.getSize(
                      Dsize.getSize(
                        25,
                        diffSize: 2,
                      ),
                      diffSize: 2,
                    ),
                    letterSpacing: 0.15,
                  ),
            ),
          ],
        ),
      );

  discription(context) => Container(
        color: AppColors.appColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Entry form submitted\n",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppColors.textwhiteColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: Dsize.getSize(
                        20,
                        diffSize: 2,
                      ),
                    ),
              ),
              TextSpan(
                text:
                    "You're almost done. you will receive an email confirmation with information to complete your registration.\n\n",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppColors.textwhiteColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: Dsize.getSize(18, diffSize: 2),
                    ),
              ),
              TextSpan(
                text: "Registration Day\n",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppColors.textwhiteColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: Dsize.getSize(
                        20,
                        diffSize: 2,
                      ),
                    ),
              ),
              TextSpan(
                text: "Saturday, October 30,2021,10AM-2PM at the Armory.",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppColors.textwhiteColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: Dsize.getSize(18, diffSize: 2),
                    ),
              )
            ],
          ),
        ),
      );

  profileDetails(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          imageCircle(context),
          const SizedBox(
            height: 10,
          ),
          container(
            AppColors.accentColor,
            'competitor',
            Dsize.width * 0.3,
            Dsize.getSize(3, diffSize: 1),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            _con?.userModel?.userType[0]?.school?.schoolName ?? "",
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: AppConfig.appFontFamily2,
                  fontSize: Dsize.getSize(
                    14,
                    diffSize: 2,
                  ),
                ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            _con?.userModel?.userType[0]?.eventDivision?.name ?? "",
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: AppConfig.appFontFamily2,
                  fontSize: Dsize.getSize(
                    14,
                    diffSize: 2,
                  ),
                ),
          ),
          Text(
            "${_con?.userModel?.userType[0]?.school?.schoolCity ?? ""}, ${_con?.userModel?.userType[0]?.school?.schoolState ?? ""}",
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: AppConfig.appFontFamily2,
                  fontSize: Dsize.getSize(
                    14,
                    diffSize: 2,
                  ),
                ),
          ),
        ],
      );

  schedule(BuildContext context) => ListView.separated(
        key: Key("2"),
        separatorBuilder: (context, index) {
          return Container(
            height: 2,
            color: Colors.white,
          );
        },
        itemBuilder: (context, index) {
          return scheduleTile(context, index);
        },
        itemCount: _con.listOfSchedule.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      );

  result(BuildContext context) => ListView.separated(
        key: Key("1"),
        separatorBuilder: (context, index) {
          return Container(
            height: 2,
            color: Colors.white,
          );
        },
        itemBuilder: (context, index) {
          return resultTile(context, index);
        },
        itemCount: _con.listOfEvents.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      );

  container(Color color, String title, double size, double verticalpadding) =>
      Container(
        width: size,
        padding: EdgeInsets.symmetric(vertical: verticalpadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textwhiteColor,
            fontSize: Dsize.getSize(14, diffSize: 2),
            letterSpacing: 0.25,
          ),
        ),
      );

  resultTile(BuildContext context, int index) => ExpansionTile(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "55 M Dash",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  "30 Sec",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  "10",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  "3rd",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "200 M Dash",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  "30 Sec",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  "13",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  "2rd",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          )
        ],
        leading: Obx(
          () => _con.listOfEvents[index][1]
              ? Icon(
                  Icons.add,
                  color: AppColors.appRedWhiteColor,
                )
              : Icon(
                  Icons.add,
                  color: Colors.white,
                ),
        ),
        onExpansionChanged: (val) {
          _con.listOfEvents[index][1] = val;
        },
        collapsedBackgroundColor: AppColors.appRedWhiteColor,
        backgroundColor: AppColors.appRedWhiteColor,
        title: Text(
          _con.listOfEvents[index][0],
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            letterSpacing: 0.15,
          ),
        ),
        trailing: Obx(
          () => _con.listOfEvents[index][1]
              ? SvgPicture.asset(
                  AppImage.checkAccountCreatedIconsvg,
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  AppImage.uncheckIconsvg,
                  color: Colors.white,
                ),
        ),
      );

  scheduleTile(BuildContext context, int index) => ExpansionTile(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "55 M Dash",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.25,
                  ),
                ),
                Text(
                  "9:00 AM",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.25,
                  ),
                ),
                Text(
                  "Area A",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "200 M Dash",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.25,
                  ),
                ),
                Text(
                  "12:00 PM",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.25,
                  ),
                ),
                Text(
                  "Area A",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          )
        ],
        tilePadding: EdgeInsets.symmetric(horizontal: 50),
        onExpansionChanged: (val) {
          _con.listOfSchedule[index][1] = val;
        },
        collapsedBackgroundColor: Color(0xff71B6BC),
        backgroundColor: Color(0xff71B6BC),
        title: Text(
          _con.listOfSchedule[index][0],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Obx(
          () => _con.listOfSchedule[index][1]
              ? SvgPicture.asset(
                  AppImage.checkAccountCreatedIconsvg,
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  AppImage.uncheckIconsvg,
                  color: Colors.white,
                ),
        ),
      );

  tabbar() => DefaultTabController(
        length: 2,
        child: TabBar(
          unselectedLabelColor: Colors.black,
          labelColor: AppColors.appColor,
          indicatorColor: AppColors.appColor,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          onTap: (index) {
            _con.tabIndex.value = index;
          },
          tabs: [
            Tab(
              text: "Results",
            ),
            Tab(
              text: "Schedule",
            )
          ],
        ),
      );

  imageCircle(context) =>
      _con?.userModel?.profileImage?.formats?.thumbnail?.url != null
          ? CircleAvatar(
              maxRadius: 50,
              backgroundColor: Colors.grey[200],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: imagePreview(
                  url:
                      "${AppConfig.apiBaseUrl}${_con?.userModel?.profileImage?.formats?.thumbnail?.url}",
                ),
              ),
            )
          : Image.asset(
              AppImage.profileCircle,
            );
}
