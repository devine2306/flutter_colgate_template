import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {this.onChanged,
      this.onTap,
      this.hintText = "",
      this.initialValue: "",
      this.errorText: "",
      this.isSmallDevice: false,
      this.isRoundRactangle: true,
      this.obsecureText: false,
      this.hasShadow: true,
      this.maxLines: 1,
      this.keyboardType: TextInputType.text,
      this.makewhiteBorder = true,
      this.lightRed = false,
      this.cursorColor = AppColors.appColor,
      this.textColor = Colors.white,
      this.value,
      this.ishalf = false});
  final Function onChanged;
  final Function onTap;
  final String hintText;
  final String initialValue;
  final bool isSmallDevice;
  final bool isRoundRactangle;
  final String errorText;
  final bool obsecureText;
  final bool hasShadow;
  final int maxLines;
  final TextInputType keyboardType;
  final bool makewhiteBorder;
  final lightRed;
  final Color cursorColor;
  final Color textColor;
  final bool ishalf;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(value),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: isRoundRactangle ? Dsize.getSize(48, diffSize: 8) : null,
          margin: EdgeInsets.symmetric(
            horizontal: ishalf ? 0 : Dsize.getSize(30, diffSize: 5),
          ),
          padding: EdgeInsets.only(
            left: 5,
          ),
          decoration: BoxDecoration(
            color: makewhiteBorder
                ? lightRed
                    ? AppColors.appRedWhiteColor
                    : AppColors.appColor
                : Colors.white,
            borderRadius: BorderRadius.circular(isRoundRactangle ? 50 : 15),
            border: Border.all(
              color: makewhiteBorder
                  ? AppColors.textwhiteColor
                  : AppColors.appColor,
              width: 2,
            ),
          ),
          child: TextFormField(
            initialValue: initialValue,
            cursorColor: cursorColor,
            onTap: onTap,
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: obsecureText,
            maxLines: maxLines,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: AppConfig.appFontFamily2,
              fontSize: Dsize.getSize(15, diffSize: 3),
              letterSpacing: 0.25,
              color: textColor,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: makewhiteBorder
                        ? AppColors.textwhiteColor
                        : AppColors.appColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: Dsize.getSize(15, diffSize: 3),
                    letterSpacing: 0.25,
                  ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: Dsize.getSize(14, diffSize: 0.5),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
