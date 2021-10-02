import 'dart:ui';

import 'package:colgate/controllers/auth/register_spectator_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_text_field.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/config/app_colors.dart';
import '../../utils/config/app_images.dart';
import '../../utils/config/device_size.dart';
import '../../utils/config/globals.dart';

class RegisterSpectatorScreen extends StatelessWidget {
  final RegisterSpactatorController _con =
      Get.put(RegisterSpactatorController());

  @override
  Widget build(BuildContext context) {
    print(window.viewInsets.bottom);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.appColor,
          appBar: appbar(),
          bottomSheet: window.viewInsets.bottom == 0.0
              ? Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  color: AppColors.appColor,
                  child: button(
                    text: "Continue",
                    color: AppColors.textwhiteColor,
                    textColor: AppColors.appColor,
                    onPressed: () => _con.onTapOnContiueBtn(context),
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: Dsize.height * 0.1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    "Signup",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: AppColors.textwhiteColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConfig.appFontFamily2,
                          letterSpacing: 0.25,
                          fontSize: Dsize.getSize(32, diffSize: 2),
                        ),
                  ),
                  width: double.infinity,
                ),
                Container(
                  color: AppColors.appRedWhiteColor,
                  height: Dsize.getSize(Dsize.height * 0.3,
                      diffSize: -Dsize.height * 0.05),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socilButton(
                        text: " Continue with google",
                        onPressed: () {},
                        prefixSvgPath: AppImage.googleLogosvg,
                      ),
                      const SizedBox(height: 15),
                      socilButton(
                        text: " Continue with Facebook",
                        onPressed: () {},
                        prefixSvgPath: AppImage.fbLogosvg,
                      ),
                      const SizedBox(height: 15),
                      socilButton(
                        text: " Continue with Apple",
                        onPressed: () {},
                        prefixSvgPath: AppImage.appleLogosvg,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 30,
                  ),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: AppColors.textwhiteColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: _con.firstFormError.isNotEmpty ? 30 : 0,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: Dsize.getSize(30, diffSize: 5),
                      right: Dsize.getSize(30, diffSize: 5),
                      top: _con.firstFormError.isNotEmpty ? 20 : 0,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      _con.firstFormError.value,
                      style: TextStyle(
                        fontSize: Dsize.getSize(16, diffSize: 2),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: AppColors.appColor,
                      ),
                    ),
                  ),
                ),
                firstStepOfContactDetails(context),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
        Obx(
          () => _con.year18Plus.value == 0
              ? Container(
                  color: Colors.black.withOpacity(0.8),
                  height: Dsize.height,
                  width: Dsize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Are you under\n18 years old?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: Dsize.getSize(32, diffSize: 2),
                              letterSpacing: 0.25,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dsize.getSize(80, diffSize: 30),
                        ),
                        child: button(
                          text: "Yes",
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          onPressed: () {
                            _con.year18Plus.value = 1;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dsize.getSize(80, diffSize: 30),
                        ),
                        child: button(
                          text: "No",
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          onPressed: () {
                            _con.year18Plus.value = 2;
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        )
      ],
    );
  }

  firstStepOfContactDetails(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_con.year18Plus.value == 1)
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Text(
                "Your details",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppColors.textwhiteColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConfig.appFontFamily2,
                      fontSize: 20,
                    ),
              ),
            ),
          SizedBox(height: _con.year18Plus.value == 1 ? 20 : 30),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dsize.getSize(30, diffSize: 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (Dsize.width - 75) * 0.5,
                  child: AppTextField(
                    value: "1",
                    cursorColor: Colors.white,
                    ishalf: true,
                    hintText: "First name",
                    initialValue: "",
                    onChanged: (val) => _con.firstName = RxString(val),
                  ),
                ),
                Container(
                  width: (Dsize.width - 75) * 0.5,
                  child: AppTextField(
                    value: "2",
                    ishalf: true,
                    cursorColor: Colors.white,
                    hintText: "Last name",
                    initialValue: "",
                    onChanged: (val) => _con.lastName = RxString(val),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            value: "3",
            cursorColor: Colors.white,
            isRoundRactangle: true,
            hintText: "Mobile Number",
            initialValue: "",
            keyboardType: TextInputType.phone,
            onChanged: (val) => _con.phoneNumber.value = val,
          ),
          const SizedBox(height: 20),
          AppTextField(
            value: "4",
            cursorColor: Colors.white,
            isRoundRactangle: true,
            hintText: "Email Address",
            initialValue: "",
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) => _con.email.value = val,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              if (window.viewInsets.bottom != 0) {
                FocusScope.of(context).unfocus();
              }
              schrollableDataPicker(
                context,
                onTap: (initalDate) {
                  if (_con.onChangeDatetime.value.isEmpty) {
                    _con.onChangeDatetime.value = initalDate.toString();
                  } else {
                    _con.dob.value = _con.onChangeDatetime.value;
                  }
                  Navigator.of(context).pop();
                },
                onChanged: (DateTime value) {
                  _con.onChangeDatetime.value = value.toString();
                },
              );
            },
            child: Container(
                height: Dsize.getSize(48, diffSize: 8),
                width: Dsize.width,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                    horizontal: Dsize.getSize(30, diffSize: 5)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  _con.dob.value != "Date of Birth"
                      ? _con.dob.value.substring(0, 10)
                      : _con.dob.value,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: AppColors.textwhiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConfig.appFontFamily2,
                        fontSize: Dsize.getSize(15, diffSize: 3),
                        letterSpacing: 0.25,
                      ),
                )),
          ),
          const SizedBox(height: 20),
          AppTextField(
            value: "6",
            cursorColor: Colors.white,
            isRoundRactangle: true,
            hintText: "Password",
            obsecureText: true,
            initialValue: "",
            onChanged: (val) => _con.password = RxString(val),
          ),
          if (_con.year18Plus.value == 1)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dsize.getSize(30, diffSize: 5)),
                  child: Text(
                    "Your parent's details",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: AppColors.textwhiteColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConfig.appFontFamily2,
                          fontSize: 20,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (Dsize.width - 75) * 0.5,
                        child: AppTextField(
                          cursorColor: Colors.white,
                          value: "5",
                          ishalf: true,
                          hintText: "First name",
                          initialValue: "",
                          onChanged: (val) => _con.pfirstName = RxString(val),
                        ),
                      ),
                      Container(
                        width: (Dsize.width - 75) * 0.5,
                        child: AppTextField(
                          ishalf: true,
                          value: "6",
                          cursorColor: Colors.white,
                          hintText: "Last name",
                          initialValue: "",
                          onChanged: (val) => _con.plastName = RxString(val),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  cursorColor: Colors.white,
                  value: "7",
                  hintText: "Mobile Number",
                  initialValue: "",
                  keyboardType: TextInputType.phone,
                  onChanged: (val) => _con.pphoneNumber.value = (val),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  value: "8",
                  cursorColor: Colors.white,
                  hintText: "Email Address",
                  initialValue: "",
                  onChanged: (val) => _con.pemail.value = (val),
                ),
              ],
            )
        ],
      ),
    );
  }
}
