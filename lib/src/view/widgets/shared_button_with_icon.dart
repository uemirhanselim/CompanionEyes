import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SharedButtonWithIcon extends StatelessWidget {
  const SharedButtonWithIcon({
    super.key,
    required this.title,
    required this.isSettings,
    required this.onPressed,
  });
  final String title;
  final bool isSettings;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UIHelper.getDynamicHeight(context, 0.06),
      width: UIHelper.getDynamicWidth(context, 1),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor:
                isSettings ? UIHelper.plaster : UIHelper.saltwaterDenim,
            elevation: 10,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: UIHelper.getDynamicFontSize(
                          context,
                          UIHelper.fontSize14,
                        ),
                        color: isSettings ? UIHelper.black : UIHelper.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: UIHelper.white),
            ],
          )),
    );
  }
}
