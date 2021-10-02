import 'dart:ui';

import 'package:colgate/controllers/auth/reset_password_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_text_field.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key key}) : super(key: key);

  final ResetPasswordController _con = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: appbar(),
      body: SingleChildScrollView(
        child: Container(
          height: Dsize.height -
              AppBar().preferredSize.height -
              (window.viewPadding.bottom == 0
                  ? window.viewPadding.top
                  : window.viewPadding.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "Reset Password",
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
              SizedBox(
                height: Get.height * 0.08,
              ),
              Center(
                child: Text(
                  "Please add the email address of the\naccount would like too recover.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: AppColors.textwhiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConfig.appFontFamily2,
                        fontSize: 16,
                        letterSpacing: 0.4,
                      ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
              AppTextField(
                cursorColor: Colors.white,
                isRoundRactangle: true,
                hintText: "Email Address",
                initialValue: "",
                onChanged: (val) => _con.emailAddress = RxString(val),
              ),
              Obx(
                () => _con.emailError.isNotEmpty
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dsize.getSize(30, diffSize: 5),
                                vertical: 5),
                            child: Text(
                              _con.emailError.value,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
              Spacer(),
              button(
                text: "Send",
                color: AppColors.textwhiteColor,
                textColor: AppColors.appColor,
                onPressed: () => _con.onSend(),
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
