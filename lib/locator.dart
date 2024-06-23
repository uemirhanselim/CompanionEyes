import 'package:companioneyes/src/service/auth/auth_service.dart';
import 'package:companioneyes/src/service/notification/local_notification_service.dart';
import 'package:companioneyes/src/service/notification/push_notification_service.dart';
import 'package:companioneyes/src/service/user/user_service.dart';
import 'package:companioneyes/src/service/video_call/video_call_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  // ----------------- Example Usage -----------------
  // locator.registerLazySingleton(() => AuthService());

  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => VideoCallService());
  locator.registerLazySingleton(() => LocalNotificationService());
  locator.registerLazySingleton(() => PushNotificationsService());
  locator.registerLazySingleton(() => UserService());
}
