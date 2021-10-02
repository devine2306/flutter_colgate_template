import 'package:colgate/controllers/spectator/spectator_profile_controller.dart';
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

class SpectatorProfileScreen extends StatelessWidget {
  final SpectatorProfileScreenController _con =
      Get.put(SpectatorProfileScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.isLoading.value || _con?.userModel == null
          ? AppLoader()
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: profileDetails(context),
                  ),
                  tabbar(),
                  Obx(
                    () => _con.tabIndex.value == 0
                        ? ticket(context)
                        : map(context),
                  ),
                ],
              ),
            ),
    );
  }

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

  profileDetails(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: _con?.userModel?.userType[0]?.fullName ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.appColor,
                    fontSize: 22,
                  ),
                ),
                TextSpan(
                  text: " Edit Profile",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(
                          Routes.EDIT_SPECTATOR_PROFILE_SCREEN,
                        ),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          imageCircle(context),
          const SizedBox(
            height: 10,
          ),
          container(
            AppColors.accentColor,
            "${_con.userModel.userType[0]?.userType}",
            Dsize.width * 0.3,
            Dsize.getSize(3, diffSize: 1),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );

  map(BuildContext context) => Column(
        children: [
          Stack(
            children: [
              Container(
                height: Dsize.height * 0.65,
                width: Dsize.width,
                child: Image.asset(
                  AppImage.mapViewImagejpg,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                color: AppColors.appColor.withOpacity(0.7),
                height: Dsize.height * 0.65,
                width: Dsize.width,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "Pratt Institute Athletic\nRecreation Center",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "200 Willloughby Avenue,\nBrooklyn, NY",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              appButton(
                text: "Open In Maps",
                removeSpace: true,
                isOutLined: true,
                width: Dsize.width * 0.45,
                onTap: () {},
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      );

  ticket(BuildContext context) => _con.reserveTicket.value
      ? Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(AppImage.qrcode),
              ),
              const SizedBox(
                height: 10,
              ),
              textInputField(
                context,
                headTitle: "Event",
                valueText: _con.event.value,
                textController: _con.eventController,
                inputType: TextInputType.name,
                edit: false,
                ot: OperationType.no,
                fnode: _con.eventFocus,
                hintText: "Prelimiry Week 1",
              ),
              textInputField(
                context,
                headTitle: "Date/Time",
                valueText: _con.dateTime.value,
                textController: _con.dateTimeController,
                inputType: TextInputType.name,
                ot: OperationType.no,
                edit: false,
                fnode: _con.dateTimeFocus,
                hintText: "Nov 6, 2021 | 8AM - 2PM",
              ),
              textInputField(
                context,
                headTitle: "Venue",
                valueText: _con.venue.value,
                textController: _con.venueController,
                inputType: TextInputType.name,
                edit: false,
                ot: OperationType.no,
                fnode: _con.venueFocus,
                hintText: "Pratt Institue Athletic Recreation Center",
              ),
            ],
          ),
        )
      : Container(
          height: Dsize.height * 0.5,
          padding: EdgeInsets.symmetric(
            horizontal: Dsize.getSize(30, diffSize: 5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have a ticket?",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: AppColors.appColor,
                      fontWeight: FontWeight.w500,
                      fontSize: Dsize.getSize(25, diffSize: 5),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: Dsize.getSize(45, diffSize: 5),
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(
                    Routes.FEED_POST_WEBVIEW_SCREEN,
                    arguments: _con.ticketURL.value,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    primary: AppColors.appColor,
                    elevation: 0,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImage.file,
                        color: Colors.white,
                      ),
                      Text(
                        " Reserve a ticket ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConfig.appFontFamily2,
                          fontSize: Dsize.getSize(16, diffSize: 3),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
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
            letterSpacing: 0.25,
          ),
          onTap: (index) => _con.ontab(index),
          tabs: [
            Tab(
              text: "Ticket",
            ),
            Tab(
              text: "Directions",
            ),
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
