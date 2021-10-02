import 'package:colgate/controllers/appdrawer/ticket_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({Key key}) : super(key: key);
  final TicketController _con = Get.put(TicketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Your tickets",
                style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: Dsize.getSize(35, diffSize: 10),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: Dsize.getSize(Dsize.height * 0.04,
                  diffSize: -Dsize.height * 0.01),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _con.weeks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _con.ontap(index),
                      child: Obx(
                        () => AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.only(
                            left: index == 0
                                ? Dsize.getSize(30, diffSize: 5)
                                : 10,
                            right: index + 1 == _con.weeks.length ? 30 : 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _con.selectedWeek.contains(index)
                                ? AppColors.accentColor
                                : Color(0xffE3E7EB),
                          ),
                          child: Row(
                            children: [
                              if (_con.selectedWeek.contains(index))
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    AppImage.checkAccountCreatedIconsvg,
                                    color: Colors.white,
                                    height: Dsize.getSize(14, diffSize: 2),
                                  ),
                                ),
                              Text(
                                _con.weeks[index],
                                style: TextStyle(
                                  fontSize: Dsize.getSize(14, diffSize: 2),
                                  color: _con.selectedWeek.contains(index)
                                      ? Colors.white
                                      : Colors.black,
                                  letterSpacing: 0.25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImage.qrcode,
                      fit: BoxFit.fill,
                      height: Dsize.height * 0.2,
                      width: Dsize.height * 0.2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textInputField(
                    context,
                    headTitle: "Event",
                    valueText: _con.event.value,
                    textController: _con.eventController,
                    inputType: TextInputType.name,
                    ot: OperationType.no,
                    fnode: _con.eventFocus,
                    hintText: "Prelimiry Week 1",
                  ),
                  textInputField(
                    context,
                    headTitle: "Date/Time",
                    valueText: _con.dateTime.value,
                    textController: _con.dateTimeController,
                    inputType: TextInputType.name,
                    ot: OperationType.no,
                    fnode: _con.dateTimeFocus,
                    hintText: "Nov 6, 2021 | 8AM - 2PM",
                  ),
                  textInputField(
                    context,
                    headTitle: "Venue",
                    valueText: _con.venue.value,
                    textController: _con.venueController,
                    inputType: TextInputType.name,
                    ot: OperationType.no,
                    fnode: _con.venueFocus,
                    hintText: "Pratt Institue Athletic Recreation Center",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
