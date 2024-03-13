import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
// Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
// Other methods

bool get isNextButtonActive =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;
}
