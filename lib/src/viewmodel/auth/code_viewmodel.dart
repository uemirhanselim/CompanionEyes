import 'package:flutter/material.dart';

class CodeViewModel extends ChangeNotifier {
  CodeViewModel() {
// Add your initialization code here
  }
// Setters
final TextEditingController _otpController = TextEditingController();
final FocusNode _otpFocusNode = FocusNode();
bool _hasError = false;
bool _isButtonDisabled = true;
// Getters
TextEditingController get otpController => _otpController;
FocusNode get otpFocusNode => _otpFocusNode;
bool get hasError => _hasError;
bool get isButtonDisabled => _isButtonDisabled;
// Other methods

set setHasError(bool value) {
  _hasError = value;
  notifyListeners();
}

set setIsButtonDisabled(bool value) {
  _isButtonDisabled = value;
  notifyListeners();
}
}
