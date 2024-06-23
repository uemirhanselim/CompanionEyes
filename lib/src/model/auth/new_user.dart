class NewUser {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final String language;
  final String fcmToken;
  final UserStatusEnum status;
  final bool isVolunteer;

  NewUser({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.language,
    required this.fcmToken,
    required this.status,
    required this.isVolunteer,
  });
}

enum UserStatusEnum { oncall, available, offline, busy }
