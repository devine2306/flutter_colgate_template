import 'package:colgate/controllers/spectator/edit_spectator_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditSpectatorProfileScreen extends StatelessWidget {
  EditSpectatorProfileScreen({Key key}) : super(key: key);
  final EditSpectatorProfileController _con =
      Get.put(EditSpectatorProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      saveChangesButton(context),
                      const SizedBox(
                        height: 15,
                      ),
                      imageCircle(context),
                      const SizedBox(
                        height: 10,
                      ),
                      container(
                        AppColors.accentColor,
                        _con?.userType?.value ?? "",
                        Dsize.width * 0.3,
                        3,
                      ),
                      heading("Contact details"),
                      textInputField(
                        context,
                        headTitle: "First Name",
                        valueText: _con.firstname.value,
                        textController: _con.firstNameController,
                        inputType: TextInputType.name,
                        ot: _con.firstNameController.text.isEmpty
                            ? OperationType.add
                            : OperationType.edit,
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }

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
            fontSize: 14,
            letterSpacing: 0.25,
          ),
        ),
      );

  saveChangesButton(context) => Center(
        child: ElevatedButton(
          onPressed: () => _con.updateProfileDetails(context),
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

  imageCircle(context) => GestureDetector(
        onTap: () {
          _con.pickProfileFile(context);
        },
        child: _con?.userModel?.profileImage?.formats?.thumbnail?.url != null
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
}
