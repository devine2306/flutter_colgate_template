import 'package:colgate/controllers/bottombar/results/result_competitor_profile_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResultCompetitorProfileScreen extends StatelessWidget {
  final ResultCompetitorProfileController _con =
      Get.put(ResultCompetitorProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(menu: true, back: true),
      backgroundColor: Colors.white,
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader()
            : SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dsize.getSize(
                          25,
                          diffSize: 5,
                        ),
                        vertical: 20,
                      ),
                      width: Dsize.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _con?.competitorModel?.fullName ?? "",
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.appColor,
                                      fontSize: Dsize.getSize(
                                        25,
                                        diffSize: 5,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              profiledetails(context),
                              competitordetails(context),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo\"",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.accentColor,
                                      fontSize: Dsize.getSize(
                                        14,
                                        diffSize: 2,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buttons()
                        ],
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 2,
                          color: Colors.white,
                        );
                      },
                      itemBuilder: (context, index) {
                        return eventTile(context, index);
                      },
                      itemCount: _con.listOfEvents.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  competitordetails(context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Text(
                  "3rd",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.black,
                        fontSize: Dsize.getSize(
                          50,
                          diffSize: 10,
                        ),
                      ),
                ),
                Text(
                  "${_con?.competitorModel?.points ?? "0"} pts",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
          forshareandcheers(context, AppImage.share, "Shares", "100"),
          forshareandcheers(
            context,
            AppImage.cheerIcon,
            "Cheers",
            "${_con?.competitorModel?.cheerCount ?? "0"}",
          ),
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

  buttons() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Dsize.width * 0.4,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.appRedWhiteColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                _con?.competitorModel?.eventTypeOne?.name ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.25,
                  fontSize: Dsize.getSize(
                    14,
                    diffSize: 2,
                  ),
                  color: AppColors.textwhiteColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: Dsize.width * 0.4,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.appRedWhiteColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                _con?.competitorModel?.eventTypeTwo?.name ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.25,
                  fontSize: Dsize.getSize(
                    14,
                    diffSize: 2,
                  ),
                  color: AppColors.textwhiteColor,
                ),
              ),
            ),
          ],
        ),
      );

  profiledetails(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageCircle(context),
          Text(
            _con?.competitorModel?.schoolName ?? "",
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
          Text(
            "${_con?.competitorModel?.eventDivision?.name ?? ""}\n${_con?.competitorModel?.schoolCity ?? ""}, ${_con?.competitorModel?.schoolState ?? ""}",
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
          const SizedBox(
            height: 10,
          ),
          socialMedia(context, "  @janelaurie", AppImage.facebook),
          const SizedBox(
            height: 10,
          ),
          socialMedia(context, "  @janelaurie", AppImage.instagram)
        ],
      );

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

  eventTile(BuildContext context, int index) => Obx(
        () => ExpansionTile(
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
          trailing: _con.listOfEvents[index][1]
              ? SvgPicture.asset(
                  AppImage.checkAccountCreatedIconsvg,
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  AppImage.uncheckIconsvg,
                  color: Colors.white,
                ),
          tilePadding: EdgeInsets.symmetric(horizontal: 30),
          onExpansionChanged: (val) {
            _con.listOfEvents[index][1] = val;
          },
          collapsedBackgroundColor: AppColors.appRedWhiteColor,
          backgroundColor: AppColors.appRedWhiteColor,
          title: Text(
            _con.listOfEvents[index][0],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: 0.15,
            ),
          ),
          leading: _con.listOfEvents[index][1]
              ? Icon(
                  Icons.add,
                  color: AppColors.appRedWhiteColor,
                )
              : Icon(
                  Icons.add,
                  color: Colors.white,
                ),
        ),
      );
  imageCircle(context) =>
      _con?.competitorModel?.profileImage?.formats?.thumbnail?.url != null
          ? CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.appColor,
              backgroundImage: NetworkImage(
                "${AppConfig.apiBaseUrl}${_con?.competitorModel?.profileImage?.formats?.thumbnail?.url}",
              ),
            )
          : Image.asset(
              AppImage.profileCircle,
            );
}
