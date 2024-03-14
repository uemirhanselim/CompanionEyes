import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  bool _isResetButtonActive = false;

  bool get isResetButtonActive => _isResetButtonActive;

  void setIsResetButtonActive(bool value) {
    _isResetButtonActive = value;
    notifyListeners();
  }

  void init() {
    emailController.addListener(_updateResetButtonState);
  }

  void dispose() {
    emailController.removeListener(_updateResetButtonState);
    emailController.dispose();
    emailFocusNode.dispose();
  }

  void _updateResetButtonState() {
    setIsResetButtonActive(emailController.text.isNotEmpty);
  }
}