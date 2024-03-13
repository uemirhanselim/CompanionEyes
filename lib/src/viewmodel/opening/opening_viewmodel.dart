import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:flutter/material.dart';
class OpeningViewModel extends ChangeNotifier {
  
OpeningViewModel() {
// Add your initialization code here
}
// Setters
// Getters
// Other methods

  Future<void> updateUserStatus(bool isVolunteer) async {
    await UserStatusDatabase().updateUserStatus(isUserLoggedIn: false, isVolunteer: isVolunteer);
  }
}