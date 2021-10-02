import 'dart:developer';

import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:colgate/utils/packages/image_fade.dart';
import 'package:colgate/utils/widgets/scroll_date_picker.dart';
import 'package:colgate/utils/widgets/scroll_grade_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app_colors.dart';
import 'app_images.dart';

toast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black,
      fontSize: 16.0);
}

final facebookSignIn = FacebookLogin();
GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

appPrint(dynamic message) {
  log(message.toString());
}

Widget appButton({
  @required Function onTap,
  @required String text,
  @required double width,
  bool isOutLined: false,
  bool newRed: false,
  bool dropDown: false,
  bool isWhiteBorder: false,
  bool removeSpace = false,
}) =>
    ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
        backgroundColor: MaterialStateProperty.all<Color>(
          isOutLined ? Colors.white : AppColors.appColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
            side: BorderSide(
              color:
                  isWhiteBorder ? AppColors.textwhiteColor : AppColors.appColor,
              width: 2,
            ),
          ),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: isOutLined
              ? isWhiteBorder
                  ? newRed
                      ? Color(0xffD42027)
                      : AppColors.accentColor
                  : Colors.white
              : AppColors.appColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          constraints: BoxConstraints(
            maxWidth: width,
            minHeight: Dsize.getSize(48, diffSize: 8),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              removeSpace
                  ? Container()
                  : SvgPicture.asset(
                      AppImage.chevronDownIconsvg,
                      fit: BoxFit.scaleDown,
                      color: Colors.transparent,
                    ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: isOutLined
                        ? isWhiteBorder
                            ? AppColors.textwhiteColor
                            : AppColors.appColor
                        : Colors.white,
                    fontSize: Dsize.getSize(15, diffSize: 3),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
              dropDown
                  ? SvgPicture.asset(
                      AppImage.chevronDownIconsvg,
                      fit: BoxFit.scaleDown,
                      color: Colors.white,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );

enum OperationType { edit, save, add, no }

ElevatedButton outlinePrefixElevatedBtn(
    {String prefixSvgPath, String title, Size size, Function onTap}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
          side: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    ),
    child: Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width, minHeight: 47.0),
        alignment: Alignment.center,
        child: Row(
          children: [
            SizedBox(width: size.width * 0.055),
            SvgPicture.asset(prefixSvgPath),
            SizedBox(width: size.width * 0.05),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textBlackColor,
                fontSize: Dsize.getSize(14, diffSize: 4),
                letterSpacing: 1.25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container()
          ],
        ),
      ),
    ),
  );
}

Widget appbar({bool menu = false, bool back = false, bool appdawer = false}) =>
    AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      leading: !menu || back
          ? Container(
              margin: EdgeInsets.only(
                left: Dsize.getSize(30, diffSize: 5),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () => Get.back(),
                icon: appdawer
                    ? Icon(
                        Icons.close,
                        color: AppColors.appColor,
                      )
                    : SvgPicture.asset(
                        AppImage.arrowBack,
                        color: AppColors.appColor,
                      ),
              ),
            )
          : null,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: Dsize.size,
        child: Container(
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.appColor,
          ),
        ),
      ),
      title: Image.asset(AppImage.colgateLogoRedpng),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => Get.toNamed(Routes.APP_DRAWER),
                child: menu
                    ? SvgPicture.asset(
                        AppImage.menuIconsvg,
                        color: AppColors.appColor,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ],
    );

imagePreview({String url, double height, double width}) => ImageFade(
      image: NetworkImage(url),
      height: height,
      width: width,
      placeholder: Container(
        color: Colors.grey[200],
        child: Center(
          child: Icon(
            Icons.photo,
            color: Colors.white30,
            size: 128.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Widget child, dynamic exception) {
        return Container(
          color: Color(0xFF6F6D6A),
          child: Center(
            child: Icon(
              Icons.warning,
              color: Colors.black26,
              size: 128.0,
            ),
          ),
        );
      },
    );

Widget textInputField(
  BuildContext context, {
  @required String headTitle,
  @required String valueText,
  @required OperationType ot,
  @required String hintText,
  @required TextEditingController textController,
  TextInputType inputType = TextInputType.text,
  FocusNode fnode,
  bool edit = true,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headTitle,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: AppColors.textBlackColor,
                  fontFamily: AppConfig.appFontFamily2,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              enabled: edit,
              keyboardType: inputType,
              controller: textController,
              focusNode: fnode,
              style: TextStyle(
                color: (ot == OperationType.save)
                    ? Colors.grey[800]
                    : Colors.grey[500],
                fontFamily: AppConfig.appFontFamily2,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontFamily: AppConfig.appFontFamily2,
                ),
                suffix: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                  child: Text(
                    ot == OperationType.add
                        ? "Add"
                        : ot == OperationType.edit
                            ? "Edit"
                            : ot == OperationType.no
                                ? ""
                                : "Save",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

textField({
  String image,
  String title,
  TextInputType textInputType,
  String hintText,
  Function onchange,
  String initialValue,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              if (image != null) SvgPicture.asset(image),
              if (image != null)
                const SizedBox(
                  width: 5,
                ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConfig.appFontFamily2,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: Dsize.getSize(
              35,
              diffSize: 5,
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: AppConfig.appFontFamily2,
              ),
              keyboardType: textInputType,
              initialValue: initialValue,
              onChanged: onchange,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: AppConfig.appFontFamily2,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
button({
  String text,
  Function onPressed,
  Color color,
  Color textColor,
  FontWeight fontWeight = FontWeight.w700,
}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: Dsize.getSize(30, diffSize: 5)),
      width: Dsize.width,
      height: Dsize.getSize(45, diffSize: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          primary: color,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
            fontFamily: AppConfig.appFontFamily2,
            fontSize: Dsize.getSize(15, diffSize: 3),
            letterSpacing: 0.25,
          ),
        ),
      ),
    );

socilButton({String text, Function onPressed, String prefixSvgPath}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: Dsize.getSize(30, diffSize: 5)),
      width: Dsize.width,
      height: Dsize.getSize(45, diffSize: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          primary: AppColors.textwhiteColor,
          elevation: 0,
        ),
        child: Row(
          children: [
            SvgPicture.asset(prefixSvgPath),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: Dsize.getSize(15, diffSize: 3),
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
      ),
    );

showDialogAlert(BuildContext context, String message) {
  return showDialog(
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Colgate",
              style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Divider(),
          Container(
            child: Text("$message"),
            width: double.infinity,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
    context: context,
  );
}

showGradePicker(
    {BuildContext context,
    Function ontap,
    Function onChanged,
    int initialValue,
    List eventGradeList}) {
  Focus.of(context).unfocus();
  return showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        height: 250,
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: Dsize.getSize(20, diffSize: 18)),
        margin: EdgeInsets.all(Dsize.getSize(25, diffSize: 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Select your grade",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: AppColors.appColor,
                      fontFamily: AppConfig.appFontFamily2,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            ScrollGradePicker(
              itemExtent: 40.0,
              initialValue: initialValue,
              diameterRatio: 20,
              height: 120,
              eventGradeList: eventGradeList,
              selectedBoxDecoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 3),
                  bottom: BorderSide(color: Colors.black, width: 3),
                ),
              ),
              onChanged: onChanged,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: AppColors.appColor,
                          fontFamily: AppConfig.appFontFamily2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoButton(
                  child: Text(
                    "OK",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: AppColors.accentColor,
                          fontFamily: AppConfig.appFontFamily2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                  ),
                  onPressed: ontap,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

schrollableDataPicker(
  BuildContext context, {
  Function onTap,
  Function onChanged,
}) {
  DateTime nowDate = DateTime.now();
  DateTime miniDate = nowDate.subtract(Duration(days: 365 * 120));
  DateTime initalDate = DateTime.now().subtract(Duration(days: 365 * 30));

  return showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        height: 309,
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: Dsize.getSize(20, diffSize: 18)),
        margin: EdgeInsets.all(Dsize.getSize(25, diffSize: 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Set your date of birth",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: AppColors.appColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            ScrollDatePicker(
                itemExtent: 50.0,
                minimumYear: miniDate.year,
                maximumYear: nowDate.year,
                initialDateTime: initalDate,
                diameterRatio: 25,
                height: 125,
                isLoop: false,
                selectedBoxDecoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 3),
                    bottom: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                onChanged: onChanged),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Color(0xffE02B2B),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "OK",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  onPressed: () => onTap(initalDate),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
