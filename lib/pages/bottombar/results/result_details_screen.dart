import 'package:colgate/controllers/bottombar/results/result_details_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultDetailsScreen extends StatelessWidget {
  final ResultDetailsController _con = Get.put(ResultDetailsController());
  @override
  Widget build(BuildContext context) {
    print(_con.listOfYear.length);
    return Scaffold(
      appBar: appbar(
        menu: true,
        back: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => _con.isLoading.value ||
                _con.selectedGrade.isEmpty ||
                _con.selectedStage.isEmpty ||
                _con.selectedType.isEmpty
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
                              250,
                              diffSize: 30,
                            ),
                            width: Dsize.width,
                            color: AppColors.appColor,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Results",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontFamily:
                                                AppConfig.appFontFamily2,
                                            fontSize: Dsize.getSize(
                                              35,
                                              diffSize: 5,
                                            ),
                                            letterSpacing: 0.4,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.all(AppColors.appColor),
                              columnSpacing: Dsize.getSize(20, diffSize: 20),
                              dataRowHeight: 120,
                              dataTextStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    "Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Performance',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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
                                        'PTS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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
                                        'Place',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(_con.resultList.length,
                                  (index) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Container(
                                        width: Dsize.getSize(100, diffSize: 30),
                                        height: 120,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _con?.resultList[index]?.competitor
                                                        ?.profileImage?.url !=
                                                    null
                                                ? CircleAvatar(
                                                    maxRadius: 25,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: imagePreview(
                                                        url:
                                                            "${AppConfig.apiBaseUrl}${_con.resultList[index].competitor.profileImage.url}",
                                                      ),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    maxRadius: 25,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                  ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              _con.resultList[index]?.competitor
                                                      ?.fullName ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              _con.resultList[index]?.competitor
                                                      ?.schoolName ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            alignment: Alignment.center,
                                            child: Text(
                                              _con.resultList[index]
                                                      ?.performance ??
                                                  "0",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dsize.getSize(
                                                  22,
                                                  diffSize: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        width: 50,
                                        alignment: Alignment.center,
                                        child: FittedBox(
                                          child: Text(
                                            _con.resultList[index]?.points
                                                    ?.toString() ??
                                                "0",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dsize.getSize(
                                                22,
                                                diffSize: 3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        alignment: Alignment.center,
                                        child: FittedBox(
                                          child: Text(
                                            _con.resultList[index]?.place
                                                    ?.toString() ??
                                                "0",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dsize.getSize(
                                                22,
                                                diffSize: 3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          if (_con.resultList.isEmpty)
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                "No Results available",
                                style: TextStyle(
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //EVENT YEAR
                          customDropDown(
                            expanded: _con.expandYear,
                            isHalf: true,
                            selectedValue: _con.selectedYear,
                            list: _con.listOfYear,
                            outLine: true,
                            dropDownColor: AppColors.accentColor,
                            buttonColor: AppColors.appColor,
                            textColor: Colors.white,
                            onTap: () => _con.onTapYear(),
                            topHeight: Dsize.getSize(
                              75,
                              diffSize: 15,
                            ),
                            onSelectedTab: (index) {
                              _con.selectedYear.value =
                                  _con.listOfYear[index].name;
                              _con.expandYear.value = !_con.expandYear.value;
                              _con.isPageLoading.value = true;
                              _con.getAllResults();
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          //EVENT STAGE
                          customDropDown(
                            expanded: _con.expandStage,
                            isHalf: true,
                            selectedValue: _con.selectedStage,
                            list: _con.eventStageList,
                            outLine: true,
                            dropDownColor: AppColors.accentColor,
                            buttonColor: AppColors.appColor,
                            textColor: Colors.white,
                            onTap: () => _con.onTapStage(),
                            topHeight: Dsize.getSize(
                              75,
                              diffSize: 15,
                            ),
                            onSelectedTab: (index) {
                              _con.selectedStage.value =
                                  _con.eventStageList[index].name;
                              _con.selectedStageId.value =
                                  _con.eventStageList[index].id;
                              _con.expandStage.value = !_con.expandStage.value;
                              _con.isPageLoading.value = true;
                              _con.getAllResults();
                            },
                          ),
                        ],
                      ),
                      //EVENT GRADES
                      customDropDown(
                        expanded: _con.expandGrade,
                        selectedValue: _con.selectedGrade,
                        list: _con.gradeList,
                        dropDownColor: AppColors.accentColor,
                        buttonColor: AppColors.appColor,
                        textColor: Colors.white,
                        onTap: () => _con.onTapGrade(),
                        topHeight: Dsize.getSize(
                          133,
                          diffSize: 20,
                        ),
                        onSelectedTab: (index) {
                          _con.selectedGrade.value = _con.gradeList[index].name;
                          _con.selectedGradeId.value = _con.gradeList[index].id;
                          _con.expandGrade.value = !_con.expandGrade.value;
                          _con.isPageLoading.value = true;
                          _con.getAllResults();
                        },
                      ),
                      //EVENT TYPE
                      customDropDown(
                        expanded: _con.expandType,
                        selectedValue: _con.selectedType,
                        list: _con.eventTypeList,
                        dropDownColor: AppColors.accentColor,
                        buttonColor: Colors.white,
                        textColor: AppColors.appColor,
                        onTap: () => _con.onTaptype(),
                        topHeight: Dsize.getSize(
                          75,
                          diffSize: 15,
                        ),
                        onSelectedTab: (index) {
                          _con.selectedType.value =
                              _con.eventTypeList[index].name;
                          _con.selectedTypeId.value =
                              _con.eventTypeList[index].id;
                          _con.expandType.value = !_con.expandType.value;
                          _con.isPageLoading.value = true;
                          _con.getAllResults();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
