import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
// Getters
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get passwordController => _passwordController;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
// Other methods
}
