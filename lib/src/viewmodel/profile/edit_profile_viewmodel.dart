import 'package:flutter/material.dart';

class EditProfileViewModel extends ChangeNotifier {
  EditProfileViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
// Getters
  TextEditingController get firstNameController =>
      _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  FocusNode get firstNameFocusNode => _firstNameFocusNode;
  FocusNode get lastNameFocusNode => _lastNameFocusNode;
// Other methods
}
