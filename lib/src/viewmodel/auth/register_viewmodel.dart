import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _languages = ["English", "Turkish"];
  String? _selectedGender;
  String? _selectedLanguage;

// Getters
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get passwordController => _passwordController;
  FocusNode get firstNameFocusNode => _firstNameFocusNode;
  FocusNode get lastNameFocusNode => _lastNameFocusNode;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  List<String> get genders => _genders;
  List<String> get languages => _languages;
  String? get selectedGender => _selectedGender;
  String? get selectedLanguage => _selectedLanguage;

// Other methods

  void setSelectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  void setSelectedLanguage(String? value) {
    _selectedLanguage = value;
    notifyListeners();
  }
}
