import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:companioneyes/src/view/auth/code_view.dart';
import 'package:companioneyes/src/view/auth/congrats_view.dart';
import 'package:companioneyes/src/view/auth/device_access_view.dart';
import 'package:companioneyes/src/view/auth/forgot_password_view.dart';
import 'package:companioneyes/src/view/auth/login_view.dart';
import 'package:companioneyes/src/view/auth/privacy_and_terms_view.dart';
import 'package:companioneyes/src/view/auth/register_view.dart';
import 'package:companioneyes/src/view/home/home_view.dart';
import 'package:companioneyes/src/view/opening/opening_view.dart';
import 'package:companioneyes/src/view/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Local database initialization
  await UserStatusDatabase.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Companion Eyes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: const HomeView(),
    );
  }
}
