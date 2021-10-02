import 'package:colgate/controllers/bottombar/schedule/schedule_details_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final ScheduleDetailsController _con = Get.put(ScheduleDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
        menu: true,
        back: true,
      ),
      body: Obx(
        () => _con.isLoading.value ||
                _con.filterEventGradeList.isEmpty ||
                _con.selectedEventGrade.isEmpty ||
                _con.selectedGrade.isEmpty ||
                _con.selectedStage.isEmpty
            ? AppLoader()
            : SafeArea(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Dsize.getSize(
                              330,
                              diffSize: 50,
                            ),
                            width: Dsize.width,
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Schedule",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppConfig.appFontFamily2,
                                          fontSize:
                                              Dsize.getSize(35, diffSize: 10),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Dec 16,2021 ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(
                                                color: AppColors.textwhiteColor,
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppConfig.appFontFamily2,
                                                fontSize: Dsize.getSize(
                                                  18,
                                                  diffSize: 2,
                                                ),
                                              ),
                                        ),
                                        TextSpan(
                                          text: "Start from 9AM",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(
                                                color: AppColors.textwhiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    AppConfig.appFontFamily2,
                                                fontSize: Dsize.getSize(18,
                                                    diffSize: 2),
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.all(AppColors.appColor),
                              dataTextStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Order',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Event',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Location',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(_con.scheduleList.length,
                                  (index) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Align(
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.accentColor,
                                        radius: 12,
                                        child: Text(
                                          "${_con?.scheduleList[index]?.id ?? ""}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                                    DataCell(
                                      Align(
                                        child: Text(
                                          "${_con?.scheduleList[index]?.eventType ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Dsize.getSize(15, diffSize: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        child: Text(
                                          "Zone ${_con?.scheduleList[index]?.location ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Dsize.getSize(15, diffSize: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                          if (_con.scheduleList.isEmpty)
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                "No schedule available",
                                style: TextStyle(
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      customDropDown(
                        expanded: _con.expandStage,
                        selectedValue: _con.selectedStage,
                        list: _con.eventStageList,
                        dropDownColor: Colors.white,
                        buttonColor: AppColors.accentColor,
                        dropDownTextColor: AppColors.accentColor,
                        textColor: Colors.white,
                        onTap: () => _con.onTapEventStage(),
                        topHeight: Dsize.getSize(
                          211,
                          diffSize: 40,
                        ),
                        onSelectedTab: (index) {
                          _con.selectedStage.value =
                              _con.eventStageList[index].name;
                          _con.selectedStageId.value =
                              _con.eventStageList[index].id;
                          _con.expandStage.value = !_con.expandStage.value;
                          _con.isPageLoading.value = true;
                          _con.getSchedule();
                        },
                      ),
                      customDropDown(
                        expanded: _con.expandEventGrade,
                        selectedValue: _con.selectedEventGrade,
                        list: _con.filterEventGradeList,
                        dropDownColor: Colors.white,
                        buttonColor: AppColors.accentColor,
                        dropDownTextColor: AppColors.accentColor,
                        textColor: Colors.white,
                        onTap: () => _con.onTapEventGrade(),
                        topHeight: Dsize.getSize(
                          145,
                          diffSize: 30,
                        ),
                        onSelectedTab: (index) {
                          _con.selectedEventGrade.value =
                              _con.filterEventGradeList[index].name;
                          _con.selectedEventGradeId.value =
                              _con.filterEventGradeList[index].id;
                          _con.expandEventGrade.value =
                              !_con.expandEventGrade.value;
                          _con.isPageLoading.value = true;
                          _con.getSchedule();
                        },
                      ),
                      customDropDown(
                        expanded: _con.expandGrade,
                        selectedValue: _con.selectedGrade,
                        list: _con.gradeList,
                        dropDownColor: AppColors.appColor,
                        buttonColor: Colors.white,
                        textColor: AppColors.accentColor,
                        onTap: () => _con.onTapGrade(),
                        topHeight: Dsize.getSize(
                          85,
                          diffSize: 20,
                        ),
                        onSelectedTab: (index) {
                          _con.selectedGrade.value = _con.gradeList[index].name;
                          _con.selectedGradeId.value = _con.gradeList[index].id;
                          _con.expandGrade.value = !_con.expandGrade.value;
                          _con.setEventGrade();
                          _con.isPageLoading.value = true;
                          _con.getSchedule();
                        },
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
