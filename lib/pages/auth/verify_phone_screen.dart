import 'dart:ui';

import 'package:colgate/controllers/auth/verify_phone_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/packages/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/config/app_colors.dart';
import '../../utils/config/globals.dart';

class VerifyPhoneScreen extends StatelessWidget {
  final VerifyPhoneController _con = Get.put(VerifyPhoneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: AppColors.appColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: Dsize.height -
              AppBar().preferredSize.height -
              (window.viewPadding.bottom == 0
                  ? window.viewPadding.top
                  : window.viewPadding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: Dsize.height * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: AppColors.textwhiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConfig.appFontFamily2,
                        fontSize: Dsize.getSize(32, diffSize: 2),
                      ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Please enter the 6 digit code sent to:",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: AppColors.textwhiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: Dsize.getSize(15, diffSize: 2),
                        ),
                  ),
                  SizedBox(
                    height: Dsize.getSize(15, diffSize: 5),
                  ),
                  Obx(
                    () => Text(
                      "${_con.phoneNumber.value}",
                      style: TextStyle(
                        fontSize: Dsize.getSize(14, diffSize: 2),
                        color: AppColors.textwhiteColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: OTPTextField(
                        fieldStyle: FieldStyle.underline,
                        onChanged: (val) => {},
                        onCompleted: (val) {
                          _con.otp.value = val;
                          _con.onVerifyAndProceed(context);
                        },
                        width: Dsize.width,
                        length: 6,
                        fieldWidth: Dsize.width * 0.12,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textwhiteColor,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    if (_con.otpError.value.isNotEmpty)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 10,
                            ),
                            child: Text(
                              _con.otpError.value,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              button(
                text: "Verify & Proceed",
                color: AppColors.textwhiteColor,
                textColor: AppColors.appColor,
                onPressed: () => _con.onVerifyAndProceed(context),
                fontWeight: FontWeight.w700,
              ),
              Obx(
                () => _con.timeLimit.value > 0
                    ? Text(
                        "Resend code ${_con.timeLimit.value}",
                        style: TextStyle(
                          fontSize: Dsize.getSize(14, diffSize: 2),
                          color: AppColors.textwhiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : SizedBox(),
              ),
              Container(
                alignment: Alignment.center,
                height: Dsize.height * 0.33,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.appRedWhiteColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    Text(
                      "Didn't receive the code?",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: AppColors.textwhiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Dsize.getSize(15, diffSize: 2),
                          ),
                    ),
                    button(
                      text: "Resend",
                      color: AppColors.textwhiteColor,
                      textColor: AppColors.appRedWhiteColor,
                      onPressed: _con.timeLimit.value > 0
                          ? () {}
                          : () => _con.onResend(),
                      fontWeight: FontWeight.w700,
                    ),
                    button(
                      text: "Send to Another Number",
                      color: AppColors.textwhiteColor,
                      textColor: AppColors.appRedWhiteColor,
                      onPressed: () => _con.onSendToAnotherNumber(),
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
