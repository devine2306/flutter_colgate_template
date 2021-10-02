import 'package:colgate/controllers/bottombar/feed/feed_post_controller.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class FeedPostScreen extends StatelessWidget {
  final FeedpostController _con = Get.put(FeedpostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        menu: true,
        back: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader()
            : SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imagePreview(
                      url:
                          "${AppConfig.apiBaseUrl}${_con.feedPost.heroImage.url}",
                      height: Dsize.getSize(
                        265,
                        diffSize: 70,
                      ),
                      width: Dsize.width,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dsize.getSize(30, diffSize: 5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            _con.feedPost?.title ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConfig.appFontFamily2,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${_con.feedPost?.credit ?? ""}, ${Helper.appDateformate(_con.feedPost.date)}",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Markdown(
                            data: _con.feedPost?.content[0].text ?? "",
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: appButton(
                        text: "Share Story",
                        isOutLined: true,
                        dropDown: true,
                        width: Dsize.width * 0.45,
                        onTap: () {
                          // Get.toNamed(Routes.HOME_SCREEN);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
