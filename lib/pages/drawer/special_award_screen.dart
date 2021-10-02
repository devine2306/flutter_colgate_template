import 'package:colgate/controllers/appdrawer/special_award_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialAwardScreen extends StatelessWidget {
  final SpecialAwaredController _con = Get.put(SpecialAwaredController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
        bottom: false,
        child: Obx(
          () => _con.isLoading.value
              ? AppLoader()
              : Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: Dsize.getSize(
                            180,
                            diffSize: 25,
                          ),
                          width: Dsize.width,
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "Special awards",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppConfig.appFontFamily2,
                                        fontSize:
                                            Dsize.getSize(30, diffSize: 5),
                                        letterSpacing: 0.4,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "MVPs of the season",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppConfig.appFontFamily2,
                                        fontSize:
                                            Dsize.getSize(18, diffSize: 5),
                                        letterSpacing: 0.4,
                                      ),
                                ),
                              ),
                              Container()
                            ],
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => _con.speciaAwardList.isNotEmpty
                                ? ListView.builder(
                                    itemBuilder: (context, index) {
                                      return awardTile(index);
                                    },
                                    itemCount: _con.speciaAwardList.length,
                                  )
                                : commingSoon(),
                          ),
                        ),
                      ],
                    ),
                    customDropDown(
                      expanded: _con.expand,
                      selectedValue: _con.selectedYear,
                      list: _con.listOfyear,
                      dropDownColor: AppColors.accentColor,
                      buttonColor: AppColors.appColor,
                      textColor: Colors.white,
                      onTap: () => _con.onTap(),
                      topHeight: Dsize.getSize(105, diffSize: 14),
                      onSelectedTab: (index) {
                        _con.selectedYear.value = _con.listOfyear[index].name;
                        _con.expand.value = !_con.expand.value;
                        _con.isPageLoading.value = true;
                        _con.getAwards();
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  commingSoon() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AppImage.comingsoon,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Awards Results coming soon!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppConfig.appFontFamily2,
                fontWeight: FontWeight.w700,
                fontSize: Dsize.getSize(35, diffSize: 5),
                letterSpacing: 0.15,
              ),
            ),
            Text(
              "watch this space",
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppConfig.appFontFamily2,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.15,
              ),
            )
          ],
        ),
      );

  awardTile(int index) => Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              imagePreview(
                url:
                    "${AppConfig.apiBaseUrl}${_con?.speciaAwardList[index]?.image?.url}",
                width: double.infinity,
                height: Dsize.height * 0.35,
              ),
              Padding(
                padding: EdgeInsets.all(
                  Dsize.getSize(30, diffSize: 5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _con.speciaAwardList[index]?.competitor?.fullName ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConfig.appFontFamily2,
                        fontWeight: FontWeight.w700,
                        fontSize: Dsize.getSize(25, diffSize: 5),
                        letterSpacing: 0.15,
                      ),
                    ),
                    Text(
                      "${_con.speciaAwardList[index]?.competitor?.schoolCity ?? ""}, ${_con.speciaAwardList[index]?.competitor?.schoolState ?? ""}",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConfig.appFontFamily2,
                        fontWeight: FontWeight.w400,
                        fontSize: Dsize.getSize(16, diffSize: 4),
                        letterSpacing: 0.15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: Dsize.getSize(30, diffSize: 5),
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _con.speciaAwardList[index]?.awardType?.title ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConfig.appFontFamily2,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.15,
                  ),
                ),
                Text(
                  _con.speciaAwardList[index]?.caption ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConfig.appFontFamily2,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 0.15,
                  ),
                )
              ],
            ),
          )
        ],
      );
}
