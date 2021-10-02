import 'package:colgate/controllers/appdrawer/notification_preference_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotitficationPreferenceScreeen extends StatelessWidget {
  NotitficationPreferenceScreeen({Key key}) : super(key: key);
  final NotificationPreferenceController _con =
      Get.put(NotificationPreferenceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                Get.context.isTablet
                    ? "Notification Preference"
                    : "Notification\nPreference",
                style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: Dsize.getSize(35, diffSize: 5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Row(
                children: [
                  Switch(
                    activeColor: AppColors.accentColor,
                    activeTrackColor: Colors.grey[300],
                    inactiveThumbColor: AppColors.textBlackColor,
                    inactiveTrackColor: Colors.grey[300],
                    value: _con.upcomingEvents.value,
                    onChanged: (value) {
                      _con.upcomingEvents.value = !_con.upcomingEvents.value;
                    },
                  ),
                  GestureDetector(
                    onTap: () =>
                        _con.upcomingEvents.value = !_con.upcomingEvents.value,
                    child: Text(
                      "Upcoming events",
                      style: TextStyle(
                        color: _con.upcomingEvents.value
                            ? AppColors.accentColor
                            : AppColors.textBlackColor,
                        fontSize: Dsize.getSize(25, diffSize: 5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Row(
                children: [
                  Switch(
                    activeColor: AppColors.accentColor,
                    activeTrackColor: Colors.grey[300],
                    inactiveThumbColor: AppColors.textBlackColor,
                    inactiveTrackColor: Colors.grey[300],
                    value: _con.newResults.value,
                    onChanged: (value) {
                      _con.newResults.value = !_con.newResults.value;
                    },
                  ),
                  GestureDetector(
                    onTap: () => _con.newResults.value = !_con.newResults.value,
                    child: Text(
                      "New results",
                      style: TextStyle(
                        color: _con.newResults.value
                            ? AppColors.accentColor
                            : AppColors.textBlackColor,
                        fontSize: Dsize.getSize(25, diffSize: 5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
