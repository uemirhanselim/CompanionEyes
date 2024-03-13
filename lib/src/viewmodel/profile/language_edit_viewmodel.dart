import 'package:flutter/material.dart';

class LanguageEditViewModel extends ChangeNotifier {
  LanguageEditViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _languageController = TextEditingController();
  final FocusNode _languageFocusNode = FocusNode();
  final List<String> _languages = ["English", "Turkish"];
  List<String> _filteredLanguages = [];
  bool _isTyping = false;
// Getters
  TextEditingController get languageController => _languageController;
  FocusNode get languageFocusNode => _languageFocusNode;
  List<String> get languages => _languages;
  List<String> get filteredLanguages => _filteredLanguages;
  bool get isTyping => _isTyping;
// Other methods

  set setFilteredList(List<String> list) {
    _filteredLanguages = list;
    notifyListeners();
  }

  set setIsTyping(bool value) {
    _isTyping = value;
    notifyListeners();
  }

  void searchLanguage(String value) {
    setIsTyping = true;
    String searchLower = _languageController.text.toLowerCase();
    List<String> filteredList = _languages.where((language) {
      String languageLower = language.toLowerCase();
      return languageLower.contains(searchLower);
    }).toList();

    setFilteredList = filteredList;
  }

  Future<void> setLanguage(String language) async {
    // Add your setLanguage code here
  }

    void clearSearchText() {
    _languageController.clear();
    setIsTyping = false;
    _languageFocusNode.unfocus();
    notifyListeners();
  }
}
