import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/locator.dart';
import 'package:companioneyes/src/service/auth/auth_service.dart';
import 'package:companioneyes/src/service/error/auth_exception_handler.dart';
import 'package:companioneyes/src/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  // Dependencies
  final AuthService _authService = locator.get<AuthService>();

  // Setters
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _isResetButtonActive = false;

  //Getters
  TextEditingController get emailController => _emailController;
  FocusNode get emailFocusNode => _emailFocusNode;
  bool get isResetButtonActive => _isResetButtonActive;

  // Functions
  set setIsResetButtonActive(bool value) {
    _isResetButtonActive = value;
    notifyListeners();
  }

  Future<void> passwordResetEmailSend(BuildContext context) async {
    setIsResetButtonActive = false;
    await _authService
        .passwordResetEmailSend(email: _emailController.text.trim())
        .then(
      (status) async {
        if (status == AuthStatus.successful) {
          CustomSnackBar.showSuccessSnackBar(
            context,
            message: "Password reset email sent successfully",
          );
          await context.router.pop();
        } else {
          final error = AuthExceptionHandler.generateErrorMessage(status);
          CustomSnackBar.showErrorSnackBar(
            context,
            message: error,
          );
        }
      },
    );
    setIsResetButtonActive = true;
  }
}
