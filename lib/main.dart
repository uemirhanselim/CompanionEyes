import 'package:companioneyes/locator.dart';
import 'package:companioneyes/src/local/local_storage.dart';
import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/service/notification/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<ScaffoldMessengerState> navigatorKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Shared Prefs Local storage initialization
  await LocalStorageService().onInitialize();

  // Local database initialization
  await UserStatusDatabase.initialize();

  //TODO: permission ları gerekli yere taşı
  await LocalNotificationService().requestPermission();

  await LocalNotificationService().initialize();
  await [Permission.camera, Permission.microphone].request();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    print(
        "homeviewmodel onmessageopenedapp message received: ${event.data['room_id']}");
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Companion Eyes',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: navigatorKey,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
