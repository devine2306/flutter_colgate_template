import 'package:carousel_slider/carousel_slider.dart';
import 'package:colgate/common/shimmer_widget.dart';
import 'package:colgate/controllers/bottombar/feed/feed_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/helper.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/config/app_colors.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FeedController _con = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => _con.isLoading.value
            ? shimmer()
            : RefreshIndicator(
                color: AppColors.appColor,
                onRefresh: () async {
                  _con.getAllFeeds();
                },
                child: ListView.builder(
                  itemCount: _con.feedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _con.selectFeed(index);
                        if (_con.feedList[index].content[0].component ==
                            "feed.external-post") {
                          Get.toNamed(
                            Routes.FEED_POST_WEBVIEW_SCREEN,
                            arguments:
                                _con.feedList[index].content[0].externalUrl,
                          );
                        } else {
                          Get.toNamed(
                            Routes.FEED_POST_SCREEN,
                            arguments: _con.feedList[index].id,
                          );
                        }
                      },
                      child: index == 0
                          ? CarouselSlider.builder(
                              itemCount: _con.feedList[index].content.length,
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: Dsize.getSize(
                                  274,
                                  diffSize: 70,
                                ),
                                enableInfiniteScroll: false,
                              ),
                              itemBuilder:
                                  (BuildContext context, int i, int page) {
                                return firstPost(i);
                              },
                            )
                          : Obx(
                              () => Container(
                                width: Dsize.width,
                                color: _con.selectedFeed.contains(index)
                                    ? AppColors.appRedWhiteColor
                                    : null,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dsize.getSize(
                                    15,
                                    diffSize: 5,
                                  ),
                                  vertical: _con.selectedFeed.contains(index)
                                      ? Dsize.getSize(
                                          15,
                                          diffSize: 5,
                                        )
                                      : 0,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: _con.selectedFeed.isNotEmpty
                                            ? _con.selectedFeed
                                                        .contains(index) ||
                                                    index ==
                                                        (_con.selectedFeed[0] +
                                                            1)
                                                ? 0
                                                : Dsize.getSize(
                                                    15,
                                                    diffSize: 5,
                                                  )
                                            : Dsize.getSize(
                                                15,
                                                diffSize: 5,
                                              ),
                                      ),
                                      child: imagePreview(
                                        url:
                                            "${AppConfig.apiBaseUrl}${_con.feedList[index].heroImage.formats.thumbnail.url}",
                                        height: Dsize.getSize(
                                          112,
                                          diffSize: 20,
                                        ),
                                        width: Dsize.getSize(
                                          140,
                                          diffSize: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _con.feedList[index]?.title ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                    color: _con.selectedFeed
                                                            .contains(index)
                                                        ? Colors.white
                                                        : AppColors
                                                            .textThreeBlack,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: AppConfig
                                                        .appFontFamily2,
                                                    fontSize: Dsize.getSize(
                                                      16,
                                                      diffSize: 2,
                                                    ),
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "${_con.feedList[index]?.credit ?? ""}, ${Helper.appDateformate(_con.feedList[index].date)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                    color: _con.selectedFeed
                                                            .contains(index)
                                                        ? Colors.white
                                                        : AppColors
                                                            .textThreeBlack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: Dsize.getSize(
                                                      16,
                                                      diffSize: 2,
                                                    ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  firstPost(int index) => Stack(
        children: [
          imagePreview(
            url:
                "${AppConfig.apiBaseUrl}${_con.feedList[index].heroImage.formats.thumbnail.url}",
            height: Dsize.getSize(
              274,
              diffSize: 70,
            ),
            width: Dsize.width,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "${_con.feedList[index]?.title ?? ""}",
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${_con.feedList[index]?.credit ?? ""}, ${Helper.appDateformate(_con.feedList[index].date)}",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ),
        ],
      );
}
