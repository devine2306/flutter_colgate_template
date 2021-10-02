import 'package:colgate/controllers/appdrawer/contact_controller.dart';
import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:colgate/utils/config/app_images.dart';
import 'package:colgate/utils/config/app_loader.dart';
import 'package:colgate/utils/config/app_text_field.dart';
import 'package:colgate/utils/config/device_size.dart';
import 'package:colgate/utils/config/globals.dart';
import 'package:colgate/utils/config/local_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key key}) : super(key: key);
  final ContactController _con = Get.put(ContactController());
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
                        "Contact",
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
                    LocalStorage.token == null || LocalStorage.token.isEmpty
                        ? withoutLogin()
                        : withLogin(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          isRoundRactangle: false,
                          textColor: AppColors.appColor,
                          hintText: "Type your message here",
                          makewhiteBorder: false,
                          initialValue: "",
                          keyboardType: TextInputType.phone,
                          maxLines: 8,
                          onChanged: (val) => _con.message.value = val,
                          errorText: "",
                        ),
                        if (_con.messageError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dsize.getSize(30, diffSize: 5),
                            ),
                            child: Text(
                              _con.messageError.value,
                              style: TextStyle(color: AppColors.appColor),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: appButton(
                        text: "Send",
                        width: Dsize.width,
                        onTap: () => _con.send(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  withLogin(context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dsize.getSize(30, diffSize: 5),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageCircle(context),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _con?.userModel?.userType[0].fullName ?? "",
                  style: TextStyle(
                    color: AppColors.appColor,
                    fontSize: Dsize.getSize(25, diffSize: 4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (LocalStorage.userType != "spectator")
                  Text(
                    _con?.userModel?.userType[0]?.school?.schoolName ?? "",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: AppConfig.appFontFamily2,
                          fontSize: Dsize.getSize(
                            14,
                            diffSize: 2,
                          ),
                        ),
                  ),
                if (LocalStorage.userType != "spectator")
                  const SizedBox(
                    height: 3,
                  ),
                if (LocalStorage.userType != "spectator")
                  Text(
                    "${_con?.userModel?.userType[0]?.eventDivision?.name ?? ""}\n${_con?.userModel?.userType[0]?.school?.schoolName ?? ""}, ${_con?.userModel?.userType[0]?.school?.schoolState ?? ""}",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: AppConfig.appFontFamily2,
                          fontSize: Dsize.getSize(
                            14,
                            diffSize: 2,
                          ),
                        ),
                  ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      );

  withoutLogin() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dsize.getSize(30, diffSize: 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: (Dsize.width - 75) * 0.5,
                      child: AppTextField(
                        textColor: AppColors.appColor,
                        hintText: "First Name",
                        makewhiteBorder: false,
                        ishalf: true,
                        initialValue: "",
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => _con.firstName.value = val,
                        errorText: "",
                      ),
                    ),
                    if (_con.firstNameError.isNotEmpty)
                      Text(
                        _con.firstNameError.value,
                        style: TextStyle(color: AppColors.appColor),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: (Dsize.width - 75) * 0.5,
                      child: AppTextField(
                        textColor: AppColors.appColor,
                        hintText: "Last Name",
                        makewhiteBorder: false,
                        ishalf: true,
                        initialValue: "",
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => _con.lastName.value = val,
                        errorText: "",
                      ),
                    ),
                    if (_con.lastNameError.isNotEmpty)
                      Text(
                        _con.lastNameError.value,
                        style: TextStyle(color: AppColors.appColor),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                textColor: AppColors.appColor,
                hintText: "Email",
                makewhiteBorder: false,
                initialValue: "",
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => _con.emailAddress.value = val,
                errorText: "",
              ),
              if (_con.emailAddressError.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dsize.getSize(30, diffSize: 5),
                  ),
                  child: Text(
                    _con.emailAddressError.value,
                    style: TextStyle(color: AppColors.appColor),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );

  imageCircle(context) =>
      _con?.userModel?.profileImage?.formats?.thumbnail?.url != null
          ? CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.appColor,
              backgroundImage: NetworkImage(
                "${AppConfig.apiBaseUrl}${_con?.userModel?.profileImage?.formats?.thumbnail?.url}",
              ),
            )
          : Image.asset(
              AppImage.profileCircle,
            );
}
