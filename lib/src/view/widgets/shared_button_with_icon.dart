import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SharedButtonWithIcon extends StatelessWidget {
  const SharedButtonWithIcon({
    super.key,
    required this.title,
    required this.isSettings,
    required this.onPressed,
    this.iconPath,
    this.isElevationOn = false,
  });
  final String title;
  final bool isSettings;
  final VoidCallback onPressed;
  final String? iconPath;
  final bool isElevationOn;
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
                !isElevationOn ? UIHelper.plaster : UIHelper.saltwaterDenim,
            elevation: isElevationOn ? 10 : 0,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  isSettings
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: UIHelper.getDynamicWidth(context, 0.02)),
                          child: Image.asset(
                            iconPath ?? "",
                            scale: 0.95,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: UIHelper.getDynamicFontSize(
                          context,
                          UIHelper.fontSize14,
                        ),
                        color: !isElevationOn ? UIHelper.black : UIHelper.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Icon(Icons.chevron_right,
                  color: isElevationOn ? UIHelper.white : UIHelper.black),
            ],
          )),
    );
  }
}
