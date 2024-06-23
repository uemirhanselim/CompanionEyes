import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/locator.dart';
import 'package:companioneyes/src/model/auth/new_user.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/service/auth/auth_service.dart';
import 'package:companioneyes/src/service/error/auth_exception_handler.dart';
import 'package:companioneyes/src/service/notification/local_notification_service.dart';
import 'package:companioneyes/src/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = locator.get<AuthService>();
  final LocalNotificationService _localNotificationService =
      locator.get<LocalNotificationService>();
  RegisterViewModel({required bool isVolunteer}) {
    setIsVolunteer = isVolunteer;
  }
// Setters
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _languages = ["English", "Turkish"];
  String? _selectedGender;
  String? _selectedLanguage;
  bool _isLoading = false;
  late bool _isVolunteer;
  bool _isFirstNameEntered = false;
  bool _isLastNameEntered = false;
  bool _isEmailEntered = false;
  bool _isPasswordEntered = false;

// Getters
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  FocusNode get firstNameFocusNode => _firstNameFocusNode;
  FocusNode get lastNameFocusNode => _lastNameFocusNode;
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  List<String> get genders => _genders;
  List<String> get languages => _languages;
  String? get selectedGender => _selectedGender;
  String? get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;
  bool get isFirstNameEntered => _isFirstNameEntered;
  bool get isLastNameEntered => _isLastNameEntered;
  bool get isEmailEntered => _isEmailEntered;
  bool get isPasswordEntered => _isPasswordEntered;

// Other methods

  set setSelectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  set setSelectedLanguage(String? value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setIsVolunteer(bool value) {
    _isVolunteer = value;
    notifyListeners();
  }

  set setIsFirstNameEntered(bool value) {
    _isFirstNameEntered = value;
    notifyListeners();
  }

  set setIsLastNameEntered(bool value) {
    _isLastNameEntered = value;
    notifyListeners();
  }

  set setIsEmailEntered(bool value) {
    _isEmailEntered = value;
    notifyListeners();
  }

  set setIsPasswordEntered(bool value) {
    _isPasswordEntered = value;
    notifyListeners();
  }

  void unFocusFields() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _firstNameFocusNode.unfocus();
    _lastNameFocusNode.unfocus();
  }

  bool get isNextButtonActive =>
      _isFirstNameEntered &&
      _isLastNameEntered &&
      _isEmailEntered &&
      _isPasswordEntered &&
      _selectedGender != null &&
      _selectedLanguage != null;

  Future<void> createAccount(BuildContext context) async {
    setIsLoading = true;
    String? fmcToken = await _localNotificationService.getFcmToken() ?? "";
    final NewUser newUser = NewUser(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _selectedGender ?? "",
      language: _selectedLanguage ?? "",
      isVolunteer: _isVolunteer,
      fcmToken: fmcToken,
      status: UserStatusEnum.available,
    );
    print("1. numara");
    await _authService.createAccount(newUser: newUser).then((status) {
      if (status == AuthStatus.successful) {
        setIsLoading = false;
        context.router.push(const PrivacyAndTermsRoute());
      } else {
        setIsLoading = false;
        final error = AuthExceptionHandler.generateErrorMessage(status);
        CustomSnackBar.showErrorSnackBar(context, message: error);
      }
    });
  }
}
