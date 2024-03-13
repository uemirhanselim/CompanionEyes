import 'package:auto_route/auto_route.dart';
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

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: OpeningRoute.page),
        AutoRoute(page: PrivacyAndTermsRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true, children: [
          AutoRoute(
            page: ForgotPasswordRoute.page,
            children: [
              AutoRoute(
                page: CodeRoute.page,
                children: [
                  AutoRoute(
                    page: CongratsRoute.page,
                  ),
                ],
              ),
            ],
          ),
        ]),
        AutoRoute(page: CodeRoute.page),
        AutoRoute(page: DeviceAccessRoute.page),
        AutoRoute(page: CongratsRoute.page),
        AutoRoute(page: CodeRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          initial: false,
          children: [
            AutoRoute(page: ImpairedDashboardRoute.page),
            AutoRoute(page: CameraRoute.page),
            AutoRoute(
              page: SettingsRoute.page,
              children: [
                AutoRoute(
                  page: ChangePasswordRoute.page,
                  children: [
                    AutoRoute(
                      page: CodeRoute.page,
                      children: [
                        AutoRoute(
                          page: CongratsRoute.page,
                        ),
                      ],
                    ),
                  ],
                ),
                AutoRoute(page: EditProfileRoute.page),
                AutoRoute(page: LanguageEditRoute.page),
                AutoRoute(page: FaqRoute.page),
                AutoRoute(page: FeedbackRoute.page),
                AutoRoute(page: TermsAndPrivacyRoute.page),
              ],
            ),
            AutoRoute(
              page: VolunteerDashboardRoute.page,
              children: [
                AutoRoute(page: TestCallRoute.page),
              ],
            ),
          ],
        ),
      ];
}
