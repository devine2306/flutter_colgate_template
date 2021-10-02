import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';

class RulesAndRegulationsScreen extends StatelessWidget {
  const RulesAndRegulationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        back: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "Rules & Regulations",
              style: TextStyle(
                color: AppColors.appColor,
                fontSize: Dsize.getSize(35, diffSize: 5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Coming soon ...",
            style: TextStyle(
              color: AppColors.textBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      // body: Obx(
      //   () => Stack(
      //     children: [
      //       WebView(
      //         initialUrl: Get.arguments,
      //         javascriptMode: JavascriptMode.unrestricted,
      //         onPageFinished: (url) => {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
