import 'package:colgate/pages/auth/account_created_screen.dart';
import 'package:colgate/pages/auth/login_screen.dart';
import 'package:colgate/pages/auth/resend_otp_screen.dart';
import 'package:colgate/pages/auth/register_competitor_screen.dart';
import 'package:colgate/pages/auth/register_options_screen.dart';
import 'package:colgate/pages/auth/register_spectator_screen.dart';
import 'package:colgate/pages/auth/reset_password_screen.dart';
import 'package:colgate/pages/auth/verify_email_screen.dart';
import 'package:colgate/pages/drawer/app_drawer.dart';
import 'package:colgate/pages/competitor/competitor_profile_screen.dart';
import 'package:colgate/pages/drawer/contact_screen.dart';
import 'package:colgate/pages/competitor/edit_competitor_profile_screen.dart';
import 'package:colgate/pages/spectator/edit_spectator_profile_screen.dart';
import 'package:colgate/pages/drawer/faqs_screen.dart';
import 'package:colgate/pages/drawer/notification_preference_screen.dart';
import 'package:colgate/pages/bottombar/results/result_competitor_profile_screen.dart';
import 'package:colgate/pages/bottombar/feed/feed_post_web_view.dart';
import 'package:colgate/pages/drawer/rules_and_regulations_screen.dart';
import 'package:colgate/pages/bottombar/schedule/schedule_details_screen.dart';
import 'package:colgate/pages/auth/verify_phone_screen.dart';
import 'package:colgate/pages/bottombar/feed/feed_post_screen.dart';
import 'package:colgate/pages/bottombar/feed/feed_screen.dart';
import 'package:colgate/pages/bottombar/home_screen.dart';
import 'package:colgate/pages/bottombar/results/result_details_screen.dart';
import 'package:colgate/pages/drawer/special_award_screen.dart';
import 'package:colgate/pages/spectator/spectator_profile_screen.dart';
import 'package:colgate/pages/splash_screen.dart';
import 'package:colgate/pages/drawer/ticket_screen.dart';

import 'package:get/get.dart';
import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => LoginScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.REGISTER_TYPE_SCREEN,
      page: () => RegisterOptionsScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.REGISTER_COMPETITOR_SCREEN,
      page: () => RegisterCompetitorScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.REGISTER_SPECTATOR_SCREEN,
      page: () => RegisterSpectatorScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.RESEND_CODE_SCREEN,
      page: () => ResendCodeScreen(),
    ),
    GetPage(
      name: Routes.VERIFY_PHONE_SCREEN,
      page: () => VerifyPhoneScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.ACCOUNT_CREATED_SCREEN,
      page: () => AccountCreatedScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.FEED_SCREEN,
      page: () => FeedScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.FEED_POST_SCREEN,
      page: () => FeedPostScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.SCHEDULE_DETAILS_SCREEN,
      page: () => ScheduleDetailsScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.RESULT_DETAILS_SCREEN,
      page: () => ResultDetailsScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.COMPETITOR_PROFILE_SCREEN,
      page: () => CompetitorProfileScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.EDIT_COMPETITOR_PROFILE_SCREEN,
      page: () => EditCompetitorProfileScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.RESULT_COMPETITOR_PROFILE_SCREEN,
      page: () => ResultCompetitorProfileScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.VERIFY_EMAIL_SCREEN,
      page: () => VerifyEmailScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.FEED_POST_WEBVIEW_SCREEN,
      page: () => FeedPostWebView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.SPECIAL_AWARD_SCREEN,
      page: () => SpecialAwardScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.APP_DRAWER,
      page: () => AppDrawer(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.EDIT_SPECTATOR_PROFILE_SCREEN,
      page: () => EditSpectatorProfileScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.SPECTATOR_PROFILE_SCREEN,
      page: () => SpectatorProfileScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.TiCKET_SCREEN,
      page: () => TicketScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.CONTACT_SCREEN,
      page: () => ContactScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.FAQS_SCREEN,
      page: () => FAQScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.RULES_AND_REGULATIONS_SCREEN,
      page: () => RulesAndRegulationsScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.NOTIFICATION_PREFERENCE_SCREEN,
      page: () => NotitficationPreferenceScreeen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.RESET_PASSWORD_SCREEN,
      page: () => ResetPasswordScreen(),
      transition: Transition.downToUp,
    ),
  ];
}
