import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

customDropDown({
  double topHeight,
  RxBool expanded,
  RxString selectedValue,
  Function onTap,
  @required Function onSelectedTab,
  bool isHalf = false,
  List list,
  bool outLine = true,
  Color buttonColor,
  Color textColor,
  Color dropDownColor,
  Color dropDownTextColor = Colors.white,
}) =>
    Padding(
      padding: isHalf
          ? EdgeInsets.symmetric(
              vertical: Dsize.getSize(
                191,
                diffSize: 20,
              ),
            )
          : EdgeInsets.only(left: 30, right: 30, top: topHeight),
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: expanded.value
              ? double.parse(
                        (list.length * Dsize.getSize(50, diffSize: 5))
                            .toString(),
                      ) >
                      350
                  ? 350
                  : double.parse(
                      (list.length * Dsize.getSize(50, diffSize: 5)).toString(),
                    )
              : 50,
          width: isHalf ? Dsize.width * 0.5 - 40 : Dsize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: expanded.value ? dropDownColor : Colors.transparent,
            boxShadow: expanded.value
                ? [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.black54,
                      offset: Offset(0, 3),
                    )
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onTap,
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    constraints: BoxConstraints(
                      maxWidth: Get.width,
                      minHeight: Dsize.getSize(48, diffSize: 8),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImage.chevronDownIconsvg,
                            fit: BoxFit.scaleDown, color: Colors.transparent),
                        Expanded(
                          child: Text(
                            selectedValue.value,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: textColor,
                              fontSize: Dsize.getSize(15, diffSize: 3),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          AppImage.chevronDownIconsvg,
                          fit: BoxFit.scaleDown,
                          color: textColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onSelectedTab(index),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          list[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: dropDownTextColor,
                            fontSize: Dsize.getSize(15, diffSize: 3),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: list.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
