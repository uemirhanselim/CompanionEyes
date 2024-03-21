import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/global_variables.dart';
import 'package:companioneyes/src/view/auth/code_view.dart';
import 'package:companioneyes/src/view/auth/congrats_view.dart';
import 'package:companioneyes/src/view/auth/device_access_view.dart';
import 'package:companioneyes/src/view/auth/forgot_password_view.dart';
import 'package:companioneyes/src/view/auth/login_view.dart';
import 'package:companioneyes/src/view/auth/privacy_and_terms_view.dart';
import 'package:companioneyes/src/view/auth/register_view.dart';
import 'package:companioneyes/src/view/camera/camera_view.dart';
import 'package:companioneyes/src/view/dashboard/impaired_dashboard_view.dart';
import 'package:companioneyes/src/view/dashboard/volunteer_dashboard_view.dart';
import 'package:companioneyes/src/view/home/home_view.dart';
import 'package:companioneyes/src/view/opening/opening_view.dart';
import 'package:companioneyes/src/view/profile/change_password_view.dart';
import 'package:companioneyes/src/view/profile/edit_profile_view.dart';
import 'package:companioneyes/src/view/profile/language_edit_view.dart';
import 'package:companioneyes/src/view/settings/settings_view.dart';
import 'package:companioneyes/src/view/splash/splash_view.dart';
import 'package:companioneyes/src/view/support/faq_view.dart';
import 'package:companioneyes/src/view/support/feedback_view.dart';
import 'package:companioneyes/src/view/terms_and_privacy/terms_and_privacy_view.dart';
import 'package:companioneyes/src/view/test_call/test_call_view.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  final GlobalVariables _globalVariables = GlobalVariables();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: OpeningRoute.page, initial: false),
        AutoRoute(page: PrivacyAndTermsRoute.page),
        AutoRoute(page: RegisterRoute.page, path: "/register/:isVolunteer"),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: CodeRoute.page),
        AutoRoute(page: DeviceAccessRoute.page),
        AutoRoute(page: CongratsRoute.page),
        AutoRoute(page: CodeRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: LanguageEditRoute.page),
        AutoRoute(page: FaqRoute.page),
        AutoRoute(page: FeedbackRoute.page),
        AutoRoute(page: TermsAndPrivacyRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: "/home",
          children: _globalVariables.isVolunteer
              ? routesForVolunteer
              : routesForImpaired,
        ),
        AutoRoute(
          page: TestCallRoute.page,
          path: "/test-call",
        ),
      ];

  List<AutoRoute> get routesForImpaired => [
        AutoRoute(page: ImpairedDashboardRoute.page, initial: true),
        AutoRoute(page: CameraRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];

  List<AutoRoute> get routesForVolunteer => [
        AutoRoute(page: VolunteerDashboardRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ];
}
