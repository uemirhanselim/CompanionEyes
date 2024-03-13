import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
// Getters
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;
  FocusNode get newPasswordFocusNode => _newPasswordFocusNode;
  FocusNode get confirmPasswordFocusNode => _confirmPasswordFocusNode;
// Other methods

set setPhoneNumber(String phoneNumber) {
    _phoneNumberController.text = phoneNumber;
    notifyListeners();
  }

  bool get isNextButtonActive =>
      _phoneNumberController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;
}
