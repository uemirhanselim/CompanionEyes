import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SharedTextFormField extends StatefulWidget {
  const SharedTextFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.focusNode,
  });
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<SharedTextFormField> createState() => _SharedTextFormFieldState();
}

class _SharedTextFormFieldState extends State<SharedTextFormField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
            color: UIHelper.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        widget.title.contains("Password")
            ? Text(
                "Min. 8 characters",
                style: TextStyle(
                  fontSize:
                      UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
                  color: UIHelper.formalGrey,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox.shrink(),
        UIHelper.emptySpaceHeight(context, 0.005),
        SizedBox(
          width: UIHelper.getDynamicWidth(
              context,
              widget.title == "First Name" || widget.title == "Last Name"
                  ? 0.44
                  : 1.0),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.title.contains("Password") ? _isObscure : false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              hintText: "Enter ${widget.title}",
              hintStyle: TextStyle(
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
                color: UIHelper.formalGrey,
                fontWeight: FontWeight.w600,
              ),
              suffixIcon: widget.title == "Password"
                  ? IconButton(
                      icon: Icon(
                        !_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off_sharp,
                        color: UIHelper.saltwaterDenim,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
              fillColor: UIHelper.plaster,
              contentPadding:
                  EdgeInsets.all(UIHelper.getDynamicHeight(context, 0.016)),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
