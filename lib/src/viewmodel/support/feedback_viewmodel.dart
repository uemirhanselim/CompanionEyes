import 'package:flutter/material.dart';

class FeedbackViewModel extends ChangeNotifier {
  FeedbackViewModel() {
// Add your initialization code here
  }
// Setters
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _issueFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
// Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get issueController => _issueController;
  TextEditingController get descriptionController => _descriptionController;
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get issueFocusNode => _issueFocusNode;
  FocusNode get descriptionFocusNode => _descriptionFocusNode;
// Other methods
}
