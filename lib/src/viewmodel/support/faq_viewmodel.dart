import 'package:flutter/material.dart';

class FaqViewModel extends ChangeNotifier {
  FaqViewModel() {
// Add your initialization code here
  }
// Setters
  final List<bool> _expandedList = List.generate(5, (index) => false);
// Getters
  List<bool> get expandedList => _expandedList;
// Other methods

  void toggleExpandedList(int index) {
    _expandedList[index] = !_expandedList[index];
    notifyListeners();
  }
}
