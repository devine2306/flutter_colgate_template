import 'package:colgate/controllers/appdrawer/faq_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQScreen extends StatelessWidget {
  final FAQController _con = Get.put(FAQController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "FAQs",
                        style: TextStyle(
                          color: AppColors.appColor,
                          fontSize: Dsize.getSize(30, diffSize: 5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 2,
                            color: Colors.grey[300],
                          );
                        },
                        itemCount: _con.faqList.length,
                        padding: EdgeInsets.symmetric(horizontal: 21),
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            iconColor: AppColors.textBlackColor,
                            collapsedIconColor: AppColors.textBlackColor,
                            childrenPadding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              bottom: 10,
                            ),
                            title: Text(
                              _con.faqList[index].question,
                              style: new TextStyle(
                                fontSize: Dsize.getSize(18, diffSize: 3),
                                fontWeight: FontWeight.w700,
                                color: AppColors.textBlackColor,
                                fontFamily: AppConfig.appFontFamily2,
                              ),
                            ),
                            children: <Widget>[
                              new Column(
                                children: [
                                  Text(
                                    _con.faqList[index].anwser,
                                  ),
                                ],
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),
      ),
    );
  }
}
