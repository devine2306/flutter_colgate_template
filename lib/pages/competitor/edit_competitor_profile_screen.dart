import 'package:colgate/controllers/competitor/edit_competitor_profile_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditCompetitorProfileScreen extends StatelessWidget {
  EditCompetitorProfileScreen({Key key}) : super(key: key);

  final EditCompetitorProfileController _con =
      Get.put(EditCompetitorProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(back: true),
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      saveChangesButton(),
                      const SizedBox(
                        height: 15,
                      ),
                      imageCircle(context),
                      const SizedBox(
                        height: 10,
                      ),
                      container(
                        AppColors.accentColor,
                        "competitor",
                        Dsize.width * 0.3,
                        Dsize.getSize(3, diffSize: 1),
                      ),
                      heading(
                        "Contact details",
                      ),
                      textInputField(
                        context,
                        headTitle: "First Name",
                        valueText: _con.firstname.value,
                        textController: _con.firstNameController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.firstNameFocus,
                        hintText: "Jane",
                      ),
                      textInputField(
                        context,
                        headTitle: "Last Name",
                        valueText: _con.lastname.value,
                        textController: _con.lastNameController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.lastNameFocus,
                        hintText: "Lauries",
                      ),
                      textInputField(
                        context,
                        headTitle: "Phone number",
                        valueText: _con.phoneNumber.value,
                        textController: _con.phoneNumberControlller,
                        inputType: TextInputType.phone,
                        ot: OperationType.edit,
                        fnode: _con.phoneNumberFocus,
                        hintText: "+01 1234567890",
                      ),
                      heading(
                        "Social",
                      ),
                      textInputField(
                        context,
                        headTitle: "Instagram",
                        valueText: _con.instagram.value,
                        textController: _con.instagramController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.instagramFoccus,
                        hintText: "Add username",
                      ),
                      textInputField(
                        context,
                        headTitle: "Facebook",
                        valueText: _con.facebook.value,
                        textController: _con.facebookController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.facebookFocus,
                        hintText: "Add username",
                      ),
                      textInputField(
                        context,
                        headTitle: "Tiktok",
                        valueText: _con.tiktok.value,
                        textController: _con.tiktokController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.tiktokFocus,
                        hintText: "Add username",
                      ),
                      heading("Address"),
                      textInputField(
                        context,
                        headTitle: "Street address",
                        valueText: _con.address.value,
                        textController: _con.addressController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.addressFocus,
                        hintText: '1234 test',
                      ),
                      textInputField(
                        context,
                        headTitle: "City",
                        valueText: _con.city.value,
                        textController: _con.cityController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.cityFocus,
                        hintText: "Bronx",
                      ),
                      textInputField(
                        context,
                        headTitle: "State",
                        valueText: _con.statename.value,
                        textController: _con.stateController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.stateFocus,
                        hintText: 'NY',
                      ),
                      textInputField(
                        context,
                        headTitle: "Zipcode",
                        valueText: _con.zipCode.value,
                        textController: _con.zipCodeController,
                        inputType: TextInputType.number,
                        ot: OperationType.edit,
                        fnode: _con.zipcodeFocus,
                        hintText: "123456",
                      ),
                      heading("Divison"),
                      textInputField(
                        context,
                        headTitle: "School Name",
                        valueText: _con.schoolName.value,
                        textController: _con.schoolNameController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.schoolNameFocus,
                        hintText: "Icanhn Charter School 7",
                      ),
                      textInputField(
                        context,
                        headTitle: "City",
                        valueText: _con.schoolCity.value,
                        textController: _con.schoolCityController,
                        inputType: TextInputType.name,
                        ot: OperationType.edit,
                        fnode: _con.schoolCityFocus,
                        hintText: "Bronx",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      gradeButton(),
                      SizedBox(
                        height: 10,
                      ),
                      textInputField(
                        context,
                        headTitle: "Division",
                        edit: false,
                        valueText: _con.divisionController.text,
                        textController: _con.divisionController,
                        inputType: TextInputType.name,
                        ot: OperationType.no,
                        fnode: _con.divisionFocus,
                        hintText: "Bronx",
                      ),
                      heading("Events entered"),
                      enteredEvent()
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  gradeButton() => ElevatedButton(
        onPressed: () => showGradePicker(
          context: Get.context,
          eventGradeList: _con.eventGradeList,
          initialValue: _con.initialIndex.value,
          onChanged: (String value, int index) {
            _con.selectedGrade.value = value;
            _con.initialIndex.value = index;
          },
          ontap: _con.selectEventGrade,
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.appColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
              side: BorderSide(
                color: AppColors.appColor,
                width: 2,
              ),
            ),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            constraints: BoxConstraints(
                maxWidth: Dsize.width,
                minHeight: Dsize.getSize(48, diffSize: 8)),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppImage.chevronDownIconsvg,
                  fit: BoxFit.scaleDown,
                  color: Colors.transparent,
                ),
                Text(
                  _con?.selectedGrade?.value ?? "",
                  style: TextStyle(
                    color: AppColors.appColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConfig.appFontFamily2,
                    fontSize: Dsize.getSize(15, diffSize: 3),
                    letterSpacing: 0.25,
                  ),
                ),
                SvgPicture.asset(
                  AppImage.chevronDownIconsvg,
                  fit: BoxFit.scaleDown,
                  color: AppColors.appColor,
                )
              ],
            ),
          ),
        ),
      );

  enteredEvent() => GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _con.eventTypeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: Get.context.isTablet ? 10 : 6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _con.ontap(_con.eventTypeList[index].id),
            child: Obx(
              () => AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:
                      _con.selectedEvent.contains(_con.eventTypeList[index].id)
                          ? AppColors.accentColor
                          : Color(0xffE3E7EB),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_con.selectedEvent
                        .contains(_con.eventTypeList[index].id))
                      SvgPicture.asset(
                        AppImage.checkIconsvg,
                        color: Colors.white,
                        height: 14,
                      ),
                    Expanded(
                      child: Align(
                        alignment: _con.selectedEvent
                                .contains(_con.eventTypeList[index].id)
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: Text(
                          _con.eventTypeList[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _con.selectedEvent
                                    .contains(_con.eventTypeList[index].id)
                                ? Colors.white
                                : Colors.black,
                            fontFamily: AppConfig.appFontFamily2,
                            fontSize: Dsize.getSize(14, diffSize: 2),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: _con.selectedEvent
                              .contains(_con.eventTypeList[index].id)
                          ? Colors.white
                          : Colors.black,
                      radius: 6,
                      child: Icon(
                        Icons.close,
                        color: _con.selectedEvent
                                .contains(_con.eventTypeList[index].id)
                            ? AppColors.accentColor
                            : Colors.white,
                        size: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

  imageCircle(context) => GestureDetector(
        onTap: () {
          _con.pickProfileFile(context);
        },
        child: _con?.userModel != null &&
                _con?.userModel?.profileImage?.formats?.thumbnail?.url != null
            ? _con?.profileImage?.value?.path?.isEmpty ?? true
                ? CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: Colors.grey[200],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: imagePreview(
                        url:
                            "${AppConfig.apiBaseUrl}${_con?.userModel?.profileImage?.formats?.thumbnail?.url}",
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_con.profileImage.value),
                  )
            : _con?.profileImage?.value?.path?.isEmpty ?? true
                ? Image.asset(
                    AppImage.profileCircle,
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_con.profileImage.value),
                  ),
      );

  heading(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textBlackColor,
            fontFamily: AppConfig.appFontFamily2,
            fontSize: Dsize.getSize(25, diffSize: 5),
          ),
        ),
      );

  container(Color color, String title, double size, double verticalpadding) =>
      Container(
        width: size,
        padding: EdgeInsets.symmetric(vertical: verticalpadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textwhiteColor,
            fontSize: Dsize.getSize(14, diffSize: 2),
            letterSpacing: 0.25,
          ),
        ),
      );

  saveChangesButton() => Center(
        child: ElevatedButton(
          onPressed: () => _con.updateProfileDetails(),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all<Color>(
              AppColors.appColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
                side: BorderSide(
                  color: AppColors.appColor,
                  width: 2,
                ),
              ),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                maxWidth: Dsize.width,
                minHeight: Dsize.getSize(48, diffSize: 8),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.check,
                    color: AppColors.appColor,
                  ),
                  Text(
                    "Save changes",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.appColor,
                      fontSize: Dsize.getSize(15, diffSize: 3),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.25,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
