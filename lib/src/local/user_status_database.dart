import 'package:companioneyes/src/model/user_status/user_status.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class UserStatusDatabase {
  static late Isar isar;

  //Initialization
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([UserStatusSchema], directory: dir.path);
  }

  Future<void> updateUserStatus(
      {required bool isUserLoggedIn, required bool isVolunteer}) async {
    final userStatus = UserStatus()
      ..isUserLoggedIn = isUserLoggedIn
      ..isVolunteer = isVolunteer;

    await isar.writeTxn(() async {
      await isar.userStatus.put(userStatus);
    });
  }

  Future<void> deleteUserStatus() async {
    await isar.writeTxn(() async {
      await isar.userStatus.clear();
    });
  }

  Future<UserStatus> getUserStatus() async {
    final userStatus = await isar.userStatus.where().findFirst();
    return userStatus ?? UserStatus();
  }
}
