import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.router.pop(),
      child: AppBar(
        title: Text(
          "Back",
          style: GoogleFonts.montserrat(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize20),
            color: UIHelper.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        leadingWidth: 18,
        leading: const Icon(Icons.chevron_left),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(39);
}
