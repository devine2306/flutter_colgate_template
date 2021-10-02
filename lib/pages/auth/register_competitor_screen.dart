import 'dart:ui';

import 'package:colgate/controllers/auth/regsiter_competitor_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/app_text_field.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/config/app_colors.dart';
import '../../utils/config/app_images.dart';
import '../../utils/config/device_size.dart';
import '../../utils/config/globals.dart';

class RegisterCompetitorScreen extends StatelessWidget {
  final RegisterCompetitorController _con =
      Get.put(RegisterCompetitorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor:
                _con.isLoading.value ? Colors.white : AppColors.appColor,
            appBar: appbar(),
            bottomSheet: _con.isLoading.value
                ? AppLoader()
                : window.viewInsets.bottom == 0.0
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
            body: _con.isLoading.value
                ? AppLoader()
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: Dsize.height * 0.1,
                        child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: AppColors.textwhiteColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConfig.appFontFamily2,
                                letterSpacing: 0.25,
                                fontSize: Dsize.getSize(32, diffSize: 5),
                              ),
                        ),
                        width: double.infinity,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 2),
                            bottom: BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _con.currStep.value == 1
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.textwhiteColor,
                                        size: Dsize.getSize(20, diffSize: 2),
                                      ),
                                      onPressed: () {
                                        if (_con.currStep.value > 1)
                                          _con.currStep.value -= 1;
                                      },
                                    ),
                              Text(
                                _con.currStep.value == 1
                                    ? "1. Add Your Contact / 2. / 3. / 4."
                                    : _con.currStep.value == 2
                                        ? "1. / 2. Add Address / 3. / 4."
                                        : _con.currStep.value == 3
                                            ? "1. / 2. /3. Select Division / 4."
                                            : "1. / 2. / 3. / 4. Select Events",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                      color: AppColors.textwhiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dsize.getSize(16, diffSize: 2),
                                    ),
                              ),
                              _con.currStep.value == 1
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.textwhiteColor,
                                        size: Dsize.getSize(20, diffSize: 2),
                                      ),
                                      onPressed: () {
                                        if (_con.currStep.value < 4)
                                          _con.currStep.value += 1;
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx(() {
                                return _con.currStep.value == 1
                                    ? Container(
                                        color: AppColors.appRedWhiteColor,
                                        height: Dsize.getSize(
                                            Dsize.height * 0.3,
                                            diffSize: -Dsize.height * 0.05),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            socilButton(
                                              text: " Continue with google",
                                              onPressed: () {},
                                              prefixSvgPath:
                                                  AppImage.googleLogosvg,
                                            ),
                                            const SizedBox(height: 10),
                                            socilButton(
                                              text: " Continue with Facebook",
                                              onPressed: () {},
                                              prefixSvgPath: AppImage.fbLogosvg,
                                            ),
                                            const SizedBox(height: 10),
                                            socilButton(
                                              text: " Continue with Apple",
                                              onPressed: () {},
                                              prefixSvgPath:
                                                  AppImage.appleLogosvg,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              }),
                              Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 30,
                                    // bottom: _con.currStep.value != 1 ? 30 : 0,
                                  ),
                                  child: _con.currStep.value == 1
                                      ? Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                color: AppColors.textwhiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                letterSpacing: 0.4,
                                              ),
                                        )
                                      : Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                color: AppColors.textwhiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                        ),
                                ),
                              ),
                              errorMessage(),
                              Obx(
                                () => Column(
                                  children: [
                                    _con.currStep.value == 1
                                        ? firstStepOfContactDetails(context)
                                        : _con.currStep.value == 2
                                            ? secondStepOfAddress()
                                            : _con.currStep.value == 3
                                                ? thirdStepOfDivision()
                                                : forthStepOfAddEvents(context),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          !_con.isLoading.value ? under18plus(context) : Container()
        ],
      ),
    );
  }

  errorMessage() => Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _con.currStep.value == 1
              ? _con.firstFormError.isNotEmpty
                  ? 30
                  : 0
              : _con.currStep.value == 2
                  ? _con.secondFormError.isNotEmpty
                      ? 30
                      : 0
                  : _con.currStep.value == 3
                      ? _con.thirdFormError.isNotEmpty
                          ? 30
                          : 0
                      : 0,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: Dsize.getSize(30, diffSize: 5),
            vertical: _con.currStep.value == 1
                ? _con.firstFormError.isNotEmpty
                    ? 20
                    : 10
                : _con.currStep.value == 2
                    ? _con.secondFormError.isNotEmpty
                        ? 20
                        : 10
                    : _con.currStep.value == 3
                        ? _con.thirdFormError.isNotEmpty
                            ? 20
                            : 10
                        : 10,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            _con.currStep.value == 1
                ? _con.firstFormError.value
                : _con.currStep.value == 2
                    ? _con.secondFormError.value
                    : _con.currStep.value == 3
                        ? _con.thirdFormError.value
                        : '',
            style: TextStyle(
              fontSize: Dsize.getSize(16, diffSize: 2),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: AppColors.appColor,
            ),
          ),
        ),
      );

  under18plus(context) => Obx(
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
                            fontSize: Dsize.getSize(32, diffSize: 5),
                            letterSpacing: 0.25,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dsize.getSize(80, diffSize: 20),
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
                        horizontal: Dsize.getSize(80, diffSize: 20),
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
      );

  forthStepOfAddEvents(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 30),
      itemCount: _con.eventTypeList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (_con.selectedDivision.value == "Elementary A" &&
            [0, 2, 3, 4, 6].contains(index)) {
          return eventTile(context, index);
        } else if (_con.selectedDivision.value == "Elementary B" &&
            [0, 1, 2, 3, 4, 6].contains(index)) {
          return eventTile(context, index);
        } else if (_con.selectedDivision.value == "30's Plus" &&
            [2, 6].contains(index)) {
          return eventTile(context, index);
        } else if (["Middle School", "High School", "College", "Open"]
            .contains(_con.selectedDivision.value)) {
          return eventTile(context, index);
        } else {
          return Container();
        }
      },
    );
  }

  eventTile(context, index) => Obx(
        () => GestureDetector(
          onTap: () => _con.onSelectEvent(index),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: Dsize.getSize(48, diffSize: 8),
            alignment: Alignment.center,
            width: Dsize.width,
            margin: EdgeInsets.only(
              bottom: index + 1 == _con.eventTypeList.length
                  ? Dsize.getSize(15, diffSize: 7)
                  : Dsize.getSize(30, diffSize: 10),
              left: Dsize.getSize(30, diffSize: 5),
              right: Dsize.getSize(30, diffSize: 5),
            ),
            padding: EdgeInsets.only(left: 5, right: 15),
            decoration: BoxDecoration(
              color: _con.selectedEventIdsList.contains(index)
                  ? AppColors.textwhiteColor
                  : AppColors.appColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: AppColors.textwhiteColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_con.selectedEventIdsList.contains(index))
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset(
                      AppImage.checkAccountCreatedIconsvg,
                      color: AppColors.appColor,
                      height: 20,
                    ),
                  ),
                Text(
                  _con.eventTypeList[index].name,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: _con.selectedEventIdsList.contains(index)
                            ? AppColors.appColor
                            : AppColors.textwhiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 0.15,
                      ),
                ),
              ],
            ),
          ),
        ),
      );

  thirdStepOfDivision() {
    return Column(
      children: [
        AppTextField(
          value: "x",
          cursorColor: Colors.white,
          isRoundRactangle: true,
          makewhiteBorder: true,
          hintText: "School name",
          onChanged: (val) => _con.schoolName = RxString(val),
        ),
        const SizedBox(height: 20),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dsize.getSize(30, diffSize: 5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppTextField(
                  value: "y",
                  cursorColor: Colors.white,
                  makewhiteBorder: true,
                  ishalf: true,
                  hintText: "City",
                  onChanged: (val) => _con.schoolCity.value = val,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: AppTextField(
                  value: "z",
                  cursorColor: Colors.white,
                  ishalf: true,
                  makewhiteBorder: true,
                  hintText: "State",
                  obsecureText: false,
                  onChanged: (val) => _con.schoolState.value = val,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        grade(),
        const SizedBox(height: 20),
        divison(),
        const SizedBox(height: 10),
      ],
    );
  }

  divison() => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dsize.getSize(30, diffSize: 5)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Division",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppConfig.appFontFamily2,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => Text(
                    _con?.selectedDivision?.value ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppConfig.appFontFamily2,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 2,
                  width: Get.width - 60,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      );
  grade() => GestureDetector(
        onTap: () => showGradePicker(
          context: Get.context,
          eventGradeList: _con.eventGradeList,
          initialValue: _con.initialIndex.value,
          onChanged: (String value, int index) {
            _con.selectedGrade.value = value;
            _con.initialIndex.value = index;
          },
          ontap: _con.selectEventGrade,
        ),
        child: Container(
          height: Dsize.getSize(48, diffSize: 8),
          alignment: Alignment.centerLeft,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.symmetric(
            horizontal: Dsize.getSize(30, diffSize: 5),
          ),
          decoration: BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(200),
            border: Border.all(
              color: AppColors.textwhiteColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  _con?.selectedGrade?.value ?? "",
                  style: TextStyle(
                    color: AppColors.textwhiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: Dsize.getSize(15, diffSize: 3),
                    letterSpacing: 0.25,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 15,
              )
            ],
          ),
        ),
      );
  secondStepOfAddress() {
    return Column(
      children: [
        AppTextField(
          value: "a",
          cursorColor: Colors.white,
          isRoundRactangle: true,
          makewhiteBorder: true,
          hintText: "Street Address",
          onChanged: (val) => _con.streetAddress = RxString(val),
        ),
        const SizedBox(height: 20),
        AppTextField(
          value: "a",
          cursorColor: Colors.white,
          isRoundRactangle: true,
          makewhiteBorder: true,
          hintText: "Apartment",
          onChanged: (val) => _con.apartMent = RxString(val),
        ),
        const SizedBox(height: 20),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dsize.getSize(30, diffSize: 5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppTextField(
                  value: "b",
                  cursorColor: Colors.white,
                  makewhiteBorder: true,
                  ishalf: true,
                  hintText: "City",
                  onChanged: (val) => _con.cityName.value = val,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: AppTextField(
                  value: "c",
                  cursorColor: Colors.white,
                  ishalf: true,
                  makewhiteBorder: true,
                  hintText: "State",
                  obsecureText: false,
                  onChanged: (val) => _con.stateName.value = val,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AppTextField(
          value: "d",
          cursorColor: Colors.white,
          isRoundRactangle: true,
          makewhiteBorder: true,
          hintText: "Zip Code",
          obsecureText: false,
          onChanged: (val) => _con.zipcode.value = val,
        ),
      ],
    );
  }

  firstStepOfContactDetails(BuildContext context) {
    return Column(
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
        SizedBox(height: _con.year18Plus.value == 1 ? 20 : 0),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dsize.getSize(30, diffSize: 5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppTextField(
                  value: "1",
                  cursorColor: Colors.white,
                  ishalf: true,
                  hintText: "First name",
                  initialValue: "",
                  onChanged: (val) => _con.firstName = RxString(val),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
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
        if (_con.year18Plus.value == 2) const SizedBox(height: 30),
        if (_con.year18Plus.value == 1)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dsize.getSize(30, diffSize: 5),
                ),
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
                    Flexible(
                      child: AppTextField(
                        cursorColor: Colors.white,
                        value: "5",
                        ishalf: true,
                        hintText: "First name",
                        initialValue: "",
                        onChanged: (val) => _con.pfirstName = RxString(val),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
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
                isRoundRactangle: true,
                hintText: "Mobile Number",
                initialValue: "",
                keyboardType: TextInputType.phone,
                onChanged: (val) => _con.pphoneNumber.value = (val),
              ),
              const SizedBox(height: 20),
              AppTextField(
                value: "8",
                cursorColor: Colors.white,
                isRoundRactangle: true,
                hintText: "Email Address",
                initialValue: "",
                onChanged: (val) => _con.pemail.value = (val),
              ),
              const SizedBox(height: 30),
            ],
          )
      ],
    );
  }
}
