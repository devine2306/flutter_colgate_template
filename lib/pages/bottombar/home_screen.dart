import 'dart:async';
import 'dart:ui';
import 'package:colgate/controllers/home_controller.dart';
import 'package:colgate/models/feed_model.dart';
import 'package:colgate/pages/auth/login_screen.dart';
import 'package:colgate/pages/bottombar/feed/feed_screen.dart';
import 'package:colgate/pages/bottombar/results/result_screen.dart';
import 'package:colgate/pages/bottombar/schedule/schedule_screen.dart';
import 'package:colgate/pages/competitor/competitor_profile_screen.dart';
import 'package:colgate/pages/spectator/spectator_profile_screen.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/config/app_colors.dart';
import '../../utils/config/device_size.dart';
import '../../utils/config/globals.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double notchPadding = (window.viewPadding.bottom == 0) ? 0 : 10;

    return WillPopScope(
      onWillPop: _con.willPopCallback,
      child: Scaffold(
        appBar: appbar(
          menu: true,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: bottomBar(context, notchPadding),
        body: Obx(
          () => _con.selectedBottomItem.value == 0
              ? homeScreen(_con.willPopCallback, context, notchPadding)
              : _con.selectedBottomItem.value == 1
                  ? FeedScreen()
                  : _con.selectedBottomItem.value == 2
                      ? ScheduleScreen()
                      : _con.selectedBottomItem.value == 3
                          ? ResultScreen()
                          : _con.selectedBottomItem.value == 4
                              ? LocalStorage.token == null ||
                                      LocalStorage.token.isEmpty
                                  ? LoginScreen(
                                      drawer: true,
                                    )
                                  : LocalStorage.userType == "competitor"
                                      ? CompetitorProfileScreen()
                                      : SpectatorProfileScreen()
                              : homeScreen(
                                  _con.willPopCallback,
                                  context,
                                  notchPadding,
                                ),
        ),
      ),
    );
  }

  Widget homeScreen(
    Future<bool> _willPopCallback(),
    BuildContext context,
    double notchPadding,
  ) {
    return Obx(
      () => _con.isLoading.value
          ? Center(child: AppLoader())
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  // Container(
                  //   height: Dsize.height * 0.2,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage(AppImage.poster2),
                  //     ),
                  //   ),
                  //   child: registerOpenTextContainer(),
                  // ),
                  topSlider(context),
                  // Stack(
                  //   alignment: Alignment.bottomCenter,
                  //   children: [
                  //     Image.asset(
                  //       AppImage.poster,
                  //       width: double.infinity,
                  //       height: Dsize.height * 0.7,
                  //       fit: BoxFit.cover,
                  //     ),
                  //     registerOpenTextContainer()
                  //   ],
                  // ),
                  shareMomentContainer(),
                  Image.asset(
                    AppImage.people,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "The Games\nEvent News",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConfig.appFontFamily2,
                          fontSize: Dsize.getSize(24, diffSize: 2),
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Stay Updated",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontSize: Dsize.getSize(18, diffSize: 2),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _con.feedList.length > 3
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dsize.getSize(
                              25,
                              diffSize: 5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_con.feedList[0].content[0].component ==
                                      "feed.external-post") {
                                    Get.toNamed(
                                      Routes.FEED_POST_WEBVIEW_SCREEN,
                                      arguments: _con
                                          .feedList[0].content[0].externalUrl,
                                    );
                                  } else {
                                    Get.toNamed(
                                      Routes.FEED_POST_SCREEN,
                                      arguments: _con.feedList[0].id,
                                    );
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    imagePreview(
                                      url:
                                          "${AppConfig.apiBaseUrl}${_con?.feedList[0]?.heroImage?.formats?.thumbnail?.url}",
                                      height: Get.height * 0.3,
                                      width: Get.width,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dateFormat(_con?.feedList[0].date),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _con?.feedList[0]?.title ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: 20,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  newsfeed(context, _con?.feedList, 1),
                                  const SizedBox(width: 16),
                                  newsfeed(context, _con?.feedList, 2)
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: appButton(
                      text: "See News Feed",
                      isOutLined: true,
                      removeSpace: true,
                      width: Dsize.width * 0.5,
                      onTap: () => _con.selectedBottomItem.value = 1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  scheduleSlider(context)
                ],
              ),
            ),
    );
  }

  scheduleSlider(context) => Container(
        height: Dsize.height * 0.55,
        width: Dsize.width,
        color: AppColors.accentColor,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Schedule",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: Dsize.getSize(
                      Dsize.getSize(28, diffSize: 4),
                      diffSize: 2,
                    ),
                  ),
            ),
            Container(
              height: Get.context.isTablet
                  ? Dsize.getSize(Dsize.width * 0.5,
                      diffSize: Dsize.width * 0.06)
                  : Dsize.getSize(Dsize.width * 0.7,
                      diffSize: Dsize.width * 0.06),
              width: Dsize.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return dashchampionTile(context, index);
                },
                itemCount: _con.gradeList.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            ElevatedButton(
              onPressed: () => _con.selectedBottomItem.value = 2,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                primary: AppColors.textwhiteColor,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: Dsize.getSize(
                    15,
                    diffSize: 5,
                  ),
                ),
              ),
              child: Text(
                "See Game Schedule",
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 0.25,
                ),
              ),
            ),
          ],
        ),
      );
  shareMomentContainer() => Container(
        width: Dsize.width,
        height: 120,
        color: AppColors.accentColor,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Share your moment",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: AppConfig.appFontFamily2,
                fontSize: Dsize.getSize(29, diffSize: 5),
                letterSpacing: 0.25,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "#colgategames",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: AppConfig.appFontFamily2,
                fontSize: 20,
                letterSpacing: 0.25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  AppImage.facebook,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  AppImage.instagram,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      );

  topSlider(context) => Container(
        alignment: Alignment.center,
        height:
            Dsize.getSize(Dsize.height * 0.5, diffSize: -Dsize.width * 0.05),
        width: double.infinity,
        color: AppColors.appColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Week 1 leaderboard",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: AppColors.textwhiteColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: Dsize.getSize(24, diffSize: 4),
                  ),
            ),
            Container(
              height: Get.context.isTablet
                  ? Dsize.getSize(Dsize.width * 0.5,
                      diffSize: Dsize.width * 0.06)
                  : Dsize.getSize(Dsize.width * 0.7,
                      diffSize: Dsize.width * 0.06),
              width: Dsize.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return championTile(context, index);
                },
                itemCount: 4,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Text(
              "#colgategames",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: AppConfig.appFontFamily2,
                fontSize: Dsize.getSize(20, diffSize: 2),
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
      );
  registerOpenTextContainer() => Container(
        color: Color.fromRGBO(212, 32, 39, 0.7),
        alignment: Alignment.center,
        height: Dsize.height * 0.2,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Registeration opens soon",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: AppConfig.appFontFamily2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Saturday, October 30, 2021\nIn the app or at the Armory\n between 10AM-2PM",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: AppConfig.appFontFamily2,
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
      );

  newsfeed(context, List<FeedModel> list, int index) => GestureDetector(
        onTap: () {
          if (list[index].content[0].component == "feed.external-post") {
            Get.toNamed(
              Routes.FEED_POST_WEBVIEW_SCREEN,
              arguments: list[index].content[0].externalUrl,
            );
          } else {
            Get.toNamed(
              Routes.FEED_POST_SCREEN,
              arguments: list[index].id,
            );
          }
        },
        child: Container(
          width: Dsize.width * 0.5 - 33,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imagePreview(
                url:
                    "${AppConfig.apiBaseUrl}${list[index]?.heroImage?.formats?.thumbnail?.url}",
                height: Get.width * 0.4,
              ),
              const SizedBox(height: 10),
              Text(
                dateFormat(list[index].date),
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: AppColors.textThreeBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                list[index]?.title ?? "",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: AppColors.textThreeBlack,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: Dsize.getSize(
                        20,
                        diffSize: 2,
                      ),
                    ),
              ),
            ],
          ),
        ),
      );

  String dateFormat(DateTime dateTime) {
    return "${DateFormat.d().format(dateTime).toString().padLeft(2, "0")}.${DateFormat.M().format(dateTime).toString().padLeft(2, "0")}.${DateFormat.y().format(dateTime)}";
  }

  dashchampionTile(context, int index) => GestureDetector(
        onTap: () => Get.toNamed(Routes.SCHEDULE_DETAILS_SCREEN,
            arguments: _con.gradeList[index].id),
        child: Container(
          margin: EdgeInsets.only(
            left: Dsize.getSize(
              25,
              diffSize: 5,
            ),
            right: index == 3
                ? Dsize.getSize(
                    25,
                    diffSize: 5,
                  )
                : 0,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              imagePreview(
                url:
                    "${AppConfig.apiBaseUrl}${_con?.gradeList[index]?.image?.formats?.thumbnail?.url}",
                width: Get.context.isTablet
                    ? Dsize.getSize(Dsize.width * 0.5,
                        diffSize: Dsize.width * 0.06)
                    : Dsize.getSize(Dsize.width * 0.7,
                        diffSize: Dsize.width * 0.06),
                height: Get.context.isTablet
                    ? Dsize.getSize(Dsize.width * 0.5,
                        diffSize: Dsize.width * 0.06)
                    : Dsize.getSize(Dsize.width * 0.7,
                        diffSize: Dsize.width * 0.06),
              ),
              Text(
                _con?.gradeList[index]?.name ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: Dsize.getSize(32, diffSize: 10),
                      letterSpacing: 0.15,
                    ),
              ),
            ],
          ),
        ),
      );

  championTile(context, int index) => Container(
        width: Get.context.isTablet
            ? Dsize.getSize(Dsize.width * 0.5, diffSize: Dsize.width * 0.06)
            : Dsize.getSize(Dsize.width * 0.7, diffSize: Dsize.width * 0.06),
        height: Get.context.isTablet
            ? Dsize.getSize(Dsize.width * 0.5, diffSize: Dsize.width * 0.06)
            : Dsize.getSize(Dsize.width * 0.7, diffSize: Dsize.width * 0.06),
        decoration: BoxDecoration(
          color: AppColors.appColor,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(AppImage.championPostjpg),
          ),
        ),
        margin: EdgeInsets.only(
          left: Dsize.getSize(25, diffSize: 5),
          right: index == 3 ? Dsize.getSize(25, diffSize: 5) : 0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jennifer Thomas",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: Dsize.getSize(18, diffSize: 6),
                    letterSpacing: 0.15,
                  ),
            ),
            Text(
              "@Jennifer Thomas",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: 12,
                    letterSpacing: 0.15,
                  ),
            ),
            Container(
              height: Dsize.getSize(3, diffSize: 1),
              margin: EdgeInsets.symmetric(vertical: 5),
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   width: Dsize.width * 0.22,
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(50),
                //   ),
                //   child: Text(
                //     "55 M Dash",
                //     style: TextStyle(
                //       fontWeight: FontWeight.w500,
                //       color: AppColors.textBlackColor,
                //       fontSize: Dsize.getSize(14, diffSize: 2),
                //       letterSpacing: 0.25,
                //     ),
                //   ),
                // ),
                SvgPicture.asset(
                  AppImage.instagram,
                  color: Colors.white,
                ),
                Spacer(),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: "8",
                //         style: Theme.of(context).textTheme.headline5.copyWith(
                //               color: Colors.white,
                //               fontWeight: FontWeight.w700,
                //               fontFamily: AppConfig.appFontFamily2,
                //               fontSize: Dsize.getSize(35, diffSize: 10),
                //               letterSpacing: 0.15,
                //             ),
                //       ),
                //       TextSpan(
                //         text: " pts",
                //         style: Theme.of(context).textTheme.headline5.copyWith(
                //               color: Colors.white,
                //               fontWeight: FontWeight.w700,
                //               fontFamily: AppConfig.appFontFamily2,
                //               fontSize: Dsize.getSize(16, diffSize: 5),
                //               letterSpacing: 0.15,
                //             ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );

  Widget bottomBar(BuildContext context, double notchPadding) {
    double bottomSheetHeight =
        Dsize.height * 0.11 > 85 ? 90 + notchPadding : Dsize.height * 0.11;
    return Container(
      height: bottomSheetHeight,
      color: AppColors.appColor,
      child: Obx(
        () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _con.bottomIconList.length,
              (index) => bottomBarItem(
                context,
                index,
                _con.bottomIconList[index][0],
                _con.bottomIconList[index][1],
              ),
            )),
      ),
    );
  }

  InkWell bottomBarItem(
    BuildContext context,
    int navIndex,
    String svgImgPath,
    String title,
  ) {
    return InkWell(
      onTap: () => _con.selectedBottomItem.value = navIndex,
      child: Container(
        height: Dsize.height * 0.08,
        width: Dsize.width / 5.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              svgImgPath,
              height: Dsize.dtype == DeviceType.smallPhone ? 20 : null,
              color: _con.selectedBottomItem.value == navIndex
                  ? Colors.white
                  : Colors.white70,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: _con.selectedBottomItem.value == navIndex
                        ? Colors.white
                        : Colors.white70,
                    fontSize: Dsize.getSize(12, diffSize: 2),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
