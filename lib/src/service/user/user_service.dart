import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companioneyes/src/local/local_storage.dart';
import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:companioneyes/src/model/auth/new_user.dart';
import 'package:companioneyes/src/model/user_status/user_status.dart';
import 'package:companioneyes/src/utils/local_storage_keys.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserType() async {
    UserStatus user = await UserStatusDatabase().getUserStatus();
    print("uesr is voluntter: ${user.isVolunteer}");
    return user.isVolunteer ? "volunteer" : "visuallyImpaired";
  }

  String getUserId() {
    return LocalStorageService.instance
        .getString(LocalStorageKeys.userCredential);
  }

  Future<NewUser> getCurrentUser() async {
    String userType = await getUserType();
    print("user type: $userType" "user id: ${getUserId()}");
    final response =
        await _firestore.collection(userType).doc(getUserId()).get();
    NewUser newUser = NewUser(
      email: response['email'],
      password: "unknown",
      firstName: response['firstName'],
      lastName: response['lastName'],
      gender: response['gender'],
      language: response['language'],
      fcmToken: response['fcmToken'],
      status: response['status'] == "oncall"
          ? UserStatusEnum.oncall
          : response['status'] == "available"
              ? UserStatusEnum.available
              : response['status'] == "offline"
                  ? UserStatusEnum.offline
                  : UserStatusEnum.busy,
      isVolunteer: false,
    );
    return newUser;
  }
}
