import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:companioneyes/src/utils/global_variables.dart';
import 'package:flutter/material.dart';

class OpeningViewModel extends ChangeNotifier {
  OpeningViewModel() {
// Add your initialization code here
  }
// Setters
// Getters
// Other methods

  Future<void> updateUserStatus(bool isVolunteer) async {
    final GlobalVariables globalVariables = GlobalVariables();
    await UserStatusDatabase()
        .updateUserStatus(isUserLoggedIn: false, isVolunteer: isVolunteer)
        .then((value) {
      globalVariables.setIsVolunteer = isVolunteer;
      print("Global User status is: ${globalVariables.isVolunteer}");
    });
  }
}
