import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/locator.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/service/auth/auth_service.dart';
import 'package:companioneyes/src/service/error/auth_exception_handler.dart';
import 'package:companioneyes/src/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = locator.get<AuthService>();
  LoginViewModel() {
// Add your initialization code here
  }

// Setters
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;

// Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  bool get isLoading => _isLoading;

// Other methods
  bool get isNextButtonActive =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setIsLoading = true;
    await _authService
        .login(email: _emailController.text, password: _passwordController.text)
        .then((status) {
      if (status == AuthStatus.successful) {
        context.router.push(const HomeRoute());
      } else {
        final error = AuthExceptionHandler.generateErrorMessage(status);
        CustomSnackBar.showErrorSnackBar(
          context,
          message: error,
        );
      }
    });
  }
}
