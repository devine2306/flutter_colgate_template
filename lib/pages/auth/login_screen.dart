import 'package:colgate/controllers/auth/login_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_text_field.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/config/app_colors.dart';
import '../../utils/config/globals.dart';

class LoginScreen extends StatelessWidget {
  final bool drawer;
  LoginScreen({this.drawer});
  final LoginController _con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: drawer ?? false ? null : appbar(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                Container(
                  height: Dsize.height * 0.15,
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to the 47th\nseason of Colgate\nWomen's Games",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppConfig.appFontFamily2,
                      fontWeight: FontWeight.w400,
                      fontSize: Dsize.getSize(24, diffSize: 7),
                      color: AppColors.appColor,
                    ),
                  ),
                ),
                Container(
                  color: AppColors.appColor,
                  width: Dsize.width,
                  padding: EdgeInsets.symmetric(
                    vertical: Dsize.getSize(
                      30,
                      diffSize: 10,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: AppColors.textwhiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConfig.appFontFamily2,
                              fontSize: Dsize.getSize(32, diffSize: 2),
                            ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account?  ",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: AppColors.textwhiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dsize.getSize(15),
                                    ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Get.offNamed(Routes.REGISTER_TYPE_SCREEN),
                            child: Text(
                              "Register",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: AppColors.textwhiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dsize.getSize(15),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      socilButton(
                        text: " Continue with google",
                        onPressed: () => {},
                        // onPressed: () => _con.googleLogIn(),
                        prefixSvgPath: AppImage.googleLogosvg,
                      ),
                      const SizedBox(height: 18),
                      socilButton(
                        text: " Continue with Facebook",
                        onPressed: () => {},
                        // onPressed: () => _con.facebookLogIn(),
                        prefixSvgPath: AppImage.fbLogosvg,
                      ),
                      const SizedBox(height: 18),
                      socilButton(
                        text: " Continue with Apple",
                        // onPressed: () => _con.appleLogIn(),
                        onPressed: () => {},
                        prefixSvgPath: AppImage.appleLogosvg,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: Dsize.getSize(40, diffSize: 10)),
                AppTextField(
                  isRoundRactangle: true,
                  textColor: AppColors.appColor,
                  hintText: "Email",
                  makewhiteBorder: false,
                  initialValue: "",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) => _con.email.value = val,
                  errorText: _con.emailError.value,
                ),
                _con.emailError.isNotEmpty
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dsize.getSize(
                                  30,
                                  diffSize: 10,
                                ),
                                bottom: 8),
                            child: Text(
                              _con.emailError.value,
                              style: TextStyle(color: AppColors.appColor),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: Dsize.getSize(
                          20,
                          diffSize: 10,
                        ),
                      ),
                AppTextField(
                  textColor: AppColors.appColor,
                  isRoundRactangle: true,
                  hintText: "Password",
                  obsecureText: true,
                  makewhiteBorder: false,
                  initialValue: "",
                  onChanged: (val) => _con.password.value = val,
                  errorText: _con.passwordError.value,
                ),
                _con.passwordError.isNotEmpty
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dsize.getSize(
                                  30,
                                  diffSize: 10,
                                ),
                                bottom: 8),
                            child: Text(
                              _con.passwordError.value,
                              style: TextStyle(color: AppColors.appColor),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: Dsize.getSize(
                          20,
                          diffSize: 10,
                        ),
                      ),
                button(
                    color: AppColors.appColor,
                    textColor: AppColors.textwhiteColor,
                    text: "Continue",
                    onPressed: () {
                      if (_con.valid()) {
                        _con.login(context);
                      }
                    }),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: appButton(
                    text: "Reset Password",
                    removeSpace: true,
                    isOutLined: true,
                    width: Dsize.width,
                    onTap: () => Get.toNamed(Routes.RESET_PASSWORD_SCREEN),
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
