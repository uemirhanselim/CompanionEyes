import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  ChangePasswordViewModel() {
// Add your initialization code here
  }
// Setters
final TextEditingController _currentPasswordController = TextEditingController();
final TextEditingController _newPasswordController = TextEditingController();
final FocusNode _currentPasswordFocusNode = FocusNode();
final FocusNode _newPasswordFocusNode = FocusNode();
// Getters
TextEditingController get currentPasswordController => _currentPasswordController;
TextEditingController get newPasswordController => _newPasswordController;
FocusNode get currentPasswordFocusNode => _currentPasswordFocusNode;
FocusNode get newPasswordFocusNode => _newPasswordFocusNode;
// Other methods
}
