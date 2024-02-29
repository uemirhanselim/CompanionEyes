import 'package:companioneyes/src/utils/constants.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/viewmodel/opening/opening_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OpeningView extends StatelessWidget {
  const OpeningView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OpeningViewModel(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _headerTexts(context),
              _image(context),
              UIHelper.emptySpaceHeight(context, 0.025),
              _button(context, false),
              UIHelper.emptySpaceHeight(context, 0.025),
              _button(context, true),
            ],
          ),
        ),
      ),
    );
  }

  Align _headerTexts(BuildContext context) => Align(
        child: Column(
          children: [
            UIHelper.emptySpaceHeight(context, 0.06),
            Text(
              Constants.appName,
              style: GoogleFonts.montserrat(
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
              ),
            ),
            UIHelper.emptySpaceHeight(context, 0.01),
            Text("Light for Sight,\nStrenght in Unity!",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize:
                      UIHelper.getDynamicFontSize(context, UIHelper.fontSize28),
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      );

  Widget _image(BuildContext context) => SizedBox(
        child: Image.asset(
          fit: BoxFit.fill,
          UIHelper.openImage,
          height: UIHelper.getDynamicHeight(context, 0.5),
          width: UIHelper.getDynamicWidth(context, 1),
        ),
      );

  Widget _button(BuildContext context, bool isVolunteer) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: UIHelper.getDynamicWidth(context, 0.05)),
        child: SizedBox(
          height: UIHelper.getDynamicHeight(context, 0.11),
          width: UIHelper.getDynamicWidth(context, 1),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isVolunteer ? UIHelper.saltwaterDenim : UIHelper.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    isVolunteer
                        ? "I'd like to volunteer"
                        : "I need visual assistance",
                    style: GoogleFonts.montserrat(
                      fontSize: UIHelper.getDynamicFontSize(
                          context, UIHelper.fontSize22),
                      color: UIHelper.white,
                      fontWeight: FontWeight.w600,
                    )),
                Text(isVolunteer ? "Share your eyesight" : "Call a volunteer",
                    style: GoogleFonts.montserrat(
                      fontSize: UIHelper.getDynamicFontSize(
                          context, UIHelper.fontSize14),
                      color: UIHelper.white,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ),
      );
}
