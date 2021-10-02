import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/config/app_colors.dart';

Widget shimmer() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[200],
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return index == 0 ? firstPost() : shimmerListTile(context);
        },
      ),
    ),
  );
}

shimmerListTile(BuildContext context) => Container(
      width: Dsize.width,
      padding: EdgeInsets.only(
        left: Dsize.getSize(
          15,
          diffSize: 5,
        ),
        right: Dsize.getSize(
          15,
          diffSize: 5,
        ),
        top: Dsize.getSize(
          10,
          diffSize: 5,
        ),
      ),
      height: Dsize.getSize(
        112,
        diffSize: 20,
      ),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 90,
            color: Colors.red,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.5,
                    height: 12,
                    color: Colors.red,
                    child: Text(
                      " ",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: AppColors.textThreeBlack,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConfig.appFontFamily2,
                            fontSize: Dsize.getSize(
                              16,
                              diffSize: 2,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: Get.width * 0.4,
                    height: 12,
                    color: Colors.red,
                    child: Text(
                      " ",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: AppColors.textThreeBlack,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConfig.appFontFamily2,
                            fontSize: Dsize.getSize(
                              16,
                              diffSize: 2,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: Get.width * 0.3,
                    height: 12,
                    color: Colors.red,
                    child: Text(
                      " ",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: AppColors.textThreeBlack,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConfig.appFontFamily2,
                            fontSize: Dsize.getSize(
                              16,
                              diffSize: 2,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

firstPost() => Container(
      padding: EdgeInsets.all(15),
      height: Dsize.getSize(
        274,
        diffSize: 70,
      ),
      alignment: Alignment.topLeft,
      width: Dsize.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Text(
                " ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConfig.appFontFamily2,
                  fontSize: Dsize.getSize(
                    20,
                    diffSize: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            " ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
