import 'dart:ui';

import 'package:colgate/controllers/auth/resend_otp_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_text_field.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/config/app_colors.dart';
import '../../utils/config/globals.dart';

class ResendCodeScreen extends StatelessWidget {
  final ResendCodeController _con = Get.put(ResendCodeController());

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
                height: Dsize.height * 0.12,
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
              SizedBox(
                height: Dsize.height * 0.07,
              ),
              Text(
                "Please edit your mobile number",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: AppColors.textwhiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: Dsize.getSize(15, diffSize: 3)),
              ),
              SizedBox(height: Dsize.height * 0.045),
              AppTextField(
                cursorColor: Colors.white,
                hintText: "Mobile Number",
                keyboardType: TextInputType.number,
                initialValue: "",
                onChanged: (val) {
                  _con.phoneNumber.value = val;
                },
              ),
              Obx(
                () => _con.phoneNumberError.isEmpty
                    ? const SizedBox(height: 20)
                    : Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dsize.getSize(30, diffSize: 5)),
                            child: Text(
                              "${_con.phoneNumberError.value}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 50),
                height: Dsize.height * 0.33,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.appRedWhiteColor,
                ),
                child: button(
                  textColor: AppColors.appColor,
                  color: AppColors.textwhiteColor,
                  onPressed: () => _con.onResendCode(),
                  text: "Resend Code",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
