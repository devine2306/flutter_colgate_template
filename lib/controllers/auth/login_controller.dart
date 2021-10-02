import 'dart:convert';
import 'package:colgate/repository/auth/login_repo.dart';
import 'package:colgate/utils/config/overlay_loading.dart';
import 'package:colgate/utils/navigation/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:colgate/utils/config/globals.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  GoogleSignInAccount googleUser;
  RxString email = "".obs;
  RxString emailError = "".obs;
  RxString password = "".obs;
  RxString passwordError = "".obs;
  RxString error = "".obs;
  bool flag = true;

  Future<void> handleGoogleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void googleLogIn() async {
    try {
      handleGoogleSignIn();
      if (flag) {
        googleSignIn.onCurrentUserChanged.listen((account) {
          googleUser = account;
          if (googleUser != null) {
            print(googleUser);
            // firstName = _currentUser.displayName;
            // var names = firstName.split(' ');
            // firstName = names[0];
            // lastName = names[1];
            // email = _currentUser.email;
            // socialId = _currentUser.id;
            // _socialLogin('google', context);
          }
          flag = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void facebookLogIn() async {
    final result = await facebookSignIn.logIn(["email"]);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}'));
        var decoded = json.decode(graphResponse.body);
        print(decoded);
        // _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        toast("Cancelled");
        break;
      case FacebookLoginStatus.error:
        toast("Failed");
        break;
    }
  }

  void appleLogIn() async {
    try {
      if (await SignInWithApple.isAvailable()) {
        final email = await FlutterSecureStorage().read(key: "email");
        final socialId = await FlutterSecureStorage().read(key: "socialId");
        final firstName = await FlutterSecureStorage().read(key: "firstName");
        final lastName = await FlutterSecureStorage().read(key: "lastName");
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        print(appleCredential.authorizationCode);
        print(appleCredential.identityToken);
        if (appleCredential.userIdentifier != null) {
          await FlutterSecureStorage()
              .write(key: "socialId", value: appleCredential.userIdentifier);
        }
        if (appleCredential.email != null) {
          await FlutterSecureStorage()
              .write(key: "email", value: appleCredential.email);
        }
        if (appleCredential.givenName != null) {
          await FlutterSecureStorage()
              .write(key: "firstName", value: appleCredential.givenName);
        }
        if (appleCredential.familyName != null) {
          await FlutterSecureStorage()
              .write(key: "lastName", value: appleCredential.familyName);
        }
        print("$email, $firstName, $lastName, $socialId");
      } else {
        toast("Failed!");
      }
    } catch (exception) {
      toast("Failed!");
      print(exception);
    }
  }

  bool valid() {
    RxBool isValid = true.obs;
    emailError.value = '';
    passwordError.value = '';
    if (email.value.isEmpty) {
      emailError.value = "*Please enter email";
      isValid.value = false;
    }
    if (password.value.isEmpty) {
      passwordError.value = "*Please enter Password";
      isValid.value = false;
    }
    return isValid.value;
  }

  login(context) async {
    LoadingOverlay.of(context).show();
    var res =
        await LoginRepo.loginAPI(email: email.value, password: password.value);
    LoadingOverlay.of(context).hide();
    if (res != null) {
      Get.toNamed(Routes.HOME_SCREEN);
    }
  }
}
