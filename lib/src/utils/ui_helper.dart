import 'package:flutter/material.dart';

// --------------------- HEIGHT / WIDTH ---------------------

class UIHelper {
  static const String appLogoIcon = "assets/icons/app_logo.png";
  static const String cameraIcon = "assets/icons/camera.png";
  static const String lockIcon = "assets/icons/lock.png";
  static const String questionMarkIcon = "assets/icons/question_mark.png";
  static const String shieldIcon = "assets/icons/shield.png";
  static const String walkingManIcon = "assets/icons/walking_man.png";
  static const String warningDialogIcon = "assets/icons/warning_dialog.png";
  static const String deviceAccessImage = "assets/images/device_access.png";
  static const String openImage = "assets/images/open_image.png";
  static const String successfulSvg = "assets/images/successful.svg";

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const Color saltwaterDenim = Color(0xff195F7A);
  static const Color blackOut = Color(0xff222222);
  static const Color formalGrey = Color(0xff97979A);
  static const Color plaster = Color(0xffEAE9EA);
  static const Color aluminumSilver = Color(0xff8E8D92);
  static const Color tomatoFrog = Color(0xFFF94545);

  static const double fontSize12 = 0.0149;
  static const double fontSize14 = 0.0174;
  static const double fontSize16 = 0.0199;
  static const double fontSize20 = 0.0248;
  static const double fontSize22 = 0.0273;
  static const double fontSize28 = 0.0357;
  static const double fontSize32 = 0.0398;

  static EdgeInsets pagePadding(BuildContext context) => EdgeInsets.symmetric(
        horizontal: getDynamicWidth(context, 0.04),
      );

  static double getDynamicHeight(BuildContext context, double value) =>
      MediaQuery.sizeOf(context).height * value;

  static double getDynamicWidth(BuildContext context, double value) =>
      MediaQuery.sizeOf(context).width * value;

  static double getDynamicFontSize(BuildContext context, double value) =>
      MediaQuery.sizeOf(context).height * value;

  static SizedBox emptySpaceHeight(BuildContext context, double value) =>
      SizedBox(height: MediaQuery.sizeOf(context).height * value);

  static SizedBox emptySpaceWidth(BuildContext context, double value) =>
      SizedBox(
        width: MediaQuery.sizeOf(context).width * value,
      );
}
