import 'package:isar/isar.dart';

part 'user_status.g.dart';

@collection
class UserStatus {
  Id id = Isar.autoIncrement;

  late bool isUserLoggedIn;

  late bool isVolunteer;
}
