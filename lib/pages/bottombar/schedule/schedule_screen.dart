import 'package:colgate/controllers/bottombar/schedule/schedule_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleScreen extends StatelessWidget {
  final ScheduleController _con = Get.put(ScheduleController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.isLoading.value
          ? AppLoader()
          : Column(
              children: [
                Container(
                  height: Dsize.getSize(
                    80,
                  ),
                  width: Dsize.width,
                  color: AppColors.accentColor,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Schedule",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConfig.appFontFamily2,
                              fontSize: Dsize.getSize(35, diffSize: 5),
                              letterSpacing: 0.4,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        onTap: () => Get.toNamed(Routes.SCHEDULE_DETAILS_SCREEN,
                            arguments: _con
                                .scheduleOptionList[index].eventDivision.id),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _con.scheduleOptionList[index]?.eventDivision
                                      ?.name ??
                                  "",
                              style: TextStyle(
                                fontSize: Dsize.getSize(30, diffSize: 8),
                                fontFamily: AppConfig.appFontFamily2,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textBlackColor,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: AppColors.textBlackColor,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        height: 2,
                        color: Colors.grey[300],
                      );
                    },
                    itemCount: _con.scheduleOptionList.length,
                  ),
                )
              ],
            ),
    );
  }
}
