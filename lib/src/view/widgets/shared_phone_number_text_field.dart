import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SharedPhoneNumberTextField extends StatelessWidget {
  const SharedPhoneNumberTextField({
    super.key,
    required this.focusNode,
    required this.onInputChanged,
  });
  final FocusNode focusNode;
  final Function(PhoneNumber) onInputChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
            color: UIHelper.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: UIHelper.getDynamicWidth(context, 0.015)),
          child: InternationalPhoneNumberInput(
            spaceBetweenSelectorAndTextField: 0,
            focusNode: focusNode,
            onInputChanged: onInputChanged,
            searchBoxDecoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: UIHelper.plaster,
              contentPadding:
                  EdgeInsets.all(UIHelper.getDynamicHeight(context, 0.018)),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            inputDecoration: InputDecoration(
              filled: true,
              hintText: "Enter Phone Number",
              hintStyle: TextStyle(
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
                color: UIHelper.formalGrey,
                fontWeight: FontWeight.w600,
              ),
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
