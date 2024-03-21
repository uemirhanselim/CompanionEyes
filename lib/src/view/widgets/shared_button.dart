import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SharedButton extends StatelessWidget {
  const SharedButton({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.isLoading = false,
  });
  final String title;
  final Color color;
  final VoidCallback? onPressed;
  final bool isLoading;
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
            backgroundColor: color,
            elevation: 10,
          ),
          onPressed: onPressed,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(UIHelper.white),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                      fontSize: UIHelper.getDynamicFontSize(
                        context,
                        UIHelper.fontSize16,
                      ),
                      color: UIHelper.white,
                      fontWeight: FontWeight.w600),
                )),
    );
  }
}
