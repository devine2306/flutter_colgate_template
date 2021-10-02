import 'package:colgate/controllers/bottombar/feed/feed_post_web_view_controller.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedPostWebView extends StatelessWidget {
  FeedPostWebView({Key key}) : super(key: key);
  final FeedPostWebViewController _con = Get.put(FeedPostWebViewController());

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
      appBar: appbar(back: true, menu: true),
      body: Obx(
        () => Stack(
          children: [
            WebView(
              initialUrl: Get.arguments,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (url) => _con.isLoading.value = false,
            ),
            _con.isLoading.value ? AppLoader() : Container()
          ],
        ),
      ),
    );
  }
}
