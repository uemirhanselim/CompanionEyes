import 'package:companioneyes/src/service/auth/auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  // ----------------- Example Usage -----------------
  // locator.registerLazySingleton(() => AuthService());

  locator.registerLazySingleton(() => AuthService());
}
