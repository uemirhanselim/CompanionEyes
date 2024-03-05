import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
// Add your initialization code here
    // getUserStatus();
    setIsVolunteer = true;
  }
// Setters
  late final bool _isVolunteer;
  bool _isPageLoading = false;
  int _pageIndex = 0;

// Getters
  bool get isVolunteer => _isVolunteer;
  bool get isPageLoading => _isPageLoading;
  int get pageIndex => _pageIndex;
// Other methods

  set setIsVolunteer(bool value) {
    _isVolunteer = value;
    notifyListeners();
  }

  set setIsPageLoading(bool value) {
    _isPageLoading = value;
    notifyListeners();
  }

  set setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  // Future<void> getUserStatus() async {
  //   await UserStatusDatabase()
  //       .getUserStatus()
  //       .then((value) => setIsVolunteer = value.isVolunteer);
  //   setIsPageLoading = false;
  // }
}
