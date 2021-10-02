import 'package:colgate/controllers/auth/verify_email_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  final VerifyEmailController _con = Get.put(VerifyEmailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: AppColors.appColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: Dsize.height,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            fontSize: Dsize.getSize(
                              32,
                              diffSize: 2,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: AppColors.textwhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: Dsize.getSize(
                              14,
                              diffSize: 2,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Your parents's details",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: AppColors.textwhiteColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConfig.appFontFamily2,
                                fontSize: 20,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  textField(
                      image: AppImage.user,
                      title: "Name",
                      textInputType: TextInputType.name,
                      initialValue: _con.name.value,
                      onchange: (val) {
                        _con.name.value = val;
                      }),
                  _con.nameError.isNotEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 5, bottom: 8),
                              child: Text(
                                _con.nameError.value,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: Dsize.getSize(
                            20,
                            diffSize: 5,
                          ),
                        ),
                  textField(
                      image: AppImage.mail,
                      title: "Email",
                      textInputType: TextInputType.emailAddress,
                      initialValue: _con.emailAddress.value,
                      onchange: (val) {
                        _con.emailAddress.value = val;
                      }),
                  _con.emailError.isNotEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 5, bottom: 8),
                              child: Text(
                                _con.emailError.value,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: Dsize.getSize(
                            20,
                            diffSize: 5,
                          ),
                        ),
                  textField(
                      image: AppImage.phone,
                      title: "Phone Number",
                      initialValue: _con.number.value,
                      textInputType: TextInputType.number,
                      onchange: (val) {
                        _con.number.value = val;
                      }),
                  _con.numberError.isNotEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 5, bottom: 8),
                              child: Text(
                                _con.numberError.value,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: Dsize.getSize(
                            20,
                            diffSize: 5,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => SizedBox(
                            width: 10,
                            height: 20,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: Checkbox(
                                value: _con.tAndc.value,
                                activeColor: AppColors.textwhiteColor,
                                checkColor: AppColors.appColor,
                                onChanged: (val) {
                                  _con.tAndc.value = !_con.tAndc.value;
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _con.tAndc.value = !_con.tAndc.value;
                            },
                            child: Text(
                              "I acknowlege and confirm that all infomation suppied is correct to best of my knowledge. ",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: AppColors.textwhiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConfig.appFontFamily2,
                                    fontSize: Dsize.getSize(
                                      14,
                                      diffSize: 2,
                                    ),
                                    letterSpacing: 1,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  _con.tAndcError.isNotEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 5, bottom: 8),
                              child: Text(
                                _con.tAndcError.value,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: Dsize.getSize(
                            20,
                            diffSize: 5,
                          ),
                        ),
                  button(
                    text: "Verify & Proceed",
                    color: AppColors.textwhiteColor,
                    textColor: AppColors.appColor,
                    fontWeight: FontWeight.w700,
                    onPressed: () => _con.onVerifyAndProceed(),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
