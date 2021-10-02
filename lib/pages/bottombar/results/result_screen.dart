import 'package:colgate/controllers/bottombar/results/result_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  final ResultController _con = Get.put(ResultController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: Dsize.getSize(
                70,
                diffSize: 20,
              ),
              width: Dsize.width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                ),
                color: AppColors.appColor,
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Results",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConfig.appFontFamily2,
                            fontSize: Dsize.getSize(35, diffSize: 10),
                            letterSpacing: 0.4,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dsize.getSize(100, diffSize: 20),
            ),
            Container(
              color: AppColors.appColor,
              height: 2,
              width: Dsize.width,
            ),
            Obx(
              () => Expanded(
                child: _con.isLoading.value
                    ? AppLoader()
                    : RefreshIndicator(
                        onRefresh: () async {
                          _con.getAllEventTypes();
                        },
                        color: AppColors.appColor,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _con.selectRace(index);
                                Get.toNamed(
                                  Routes.RESULT_DETAILS_SCREEN,
                                  arguments: _con.eventTypeList[index].id,
                                );
                              },
                              child: Obx(
                                () => Container(
                                  width: Dsize.width,
                                  color: _con.selectedRace.contains(index)
                                      ? AppColors.appRedWhiteColor
                                      : null,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dsize.getSize(
                                      15,
                                      diffSize: 5,
                                    ),
                                    vertical: _con.selectedRace.contains(index)
                                        ? Dsize.getSize(
                                            15,
                                            diffSize: 5,
                                          )
                                        : 0,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: _con.selectedRace.isNotEmpty
                                              ? _con.selectedRace
                                                          .contains(index) ||
                                                      index ==
                                                          (_con.selectedRace[
                                                                  0] +
                                                              1)
                                                  ? 0
                                                  : Dsize.getSize(
                                                      15,
                                                      diffSize: 5,
                                                    )
                                              : Dsize.getSize(
                                                  15,
                                                  diffSize: 5,
                                                ),
                                        ),
                                        child: imagePreview(
                                          url:
                                              "${AppConfig.apiBaseUrl}${_con?.eventTypeList[index]?.heroImage?.formats?.thumbnail?.url}",
                                          height: Dsize.getSize(
                                            112,
                                            diffSize: 20,
                                          ),
                                          width: Dsize.getSize(
                                            140,
                                            diffSize: 20,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            _con?.eventTypeList[index]?.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                  color: _con.selectedRace
                                                          .contains(index)
                                                      ? Colors.white
                                                      : AppColors
                                                          .textThreeBlack,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppConfig.appFontFamily2,
                                                  fontSize: Dsize.getSize(
                                                    25,
                                                    diffSize: 5,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: _con.eventTypeList.length,
                        ),
                      ),
              ),
            )
          ],
        ),
        searchBox()
      ],
    );
  }

  searchBox() => Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: _con.expand.value
              ? double.parse(
                      (_con.competitors.length * Dsize.getSize(50, diffSize: 5))
                          .toString()) +
                  Dsize.getSize(48, diffSize: 8)
              : Dsize.getSize(48, diffSize: 8),
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            left: 30,
            right: 30,
            top: Dsize.getSize(96, diffSize: 26),
          ),
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: _con.expand.value
                ? [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.black54,
                      offset: Offset(0, 3),
                    )
                  ]
                : null,
          ),
          child: Column(
            children: [
              searchByController(),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.RESULT_COMPETITOR_PROFILE_SCREEN,
                            arguments: _con.competitors[index].id);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _con.competitors[index].fullName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dsize.getSize(15, diffSize: 2),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _con.competitors.length,
                ),
              )
            ],
          ),
        ),
      );

  searchByController() => Container(
        height: Dsize.getSize(
          48,
          diffSize: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: AppColors.accentColor,
            width: 2,
          ),
        ),
        child: TextFormField(
          cursorColor: AppColors.accentColor,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.accentColor,
          ),
          onFieldSubmitted: (value) {
            _con.getCompetitors(value);
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.accentColor,
            ),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Search by competitor",
            hintStyle: TextStyle(
              color: AppColors.accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: Dsize.getSize(
                Dsize.getSize(13, diffSize: -1),
                diffSize: 3,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      );
}
