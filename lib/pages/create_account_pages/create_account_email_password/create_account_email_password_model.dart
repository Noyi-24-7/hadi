import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_account_email_password_widget.dart'
    show CreateAccountEmailPasswordWidget;
import 'package:flutter/material.dart';

class CreateAccountEmailPasswordModel
    extends FlutterFlowModel<CreateAccountEmailPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfEmail widget.
  FocusNode? tfEmailFocusNode;
  TextEditingController? tfEmailTextController;
  String? Function(BuildContext, String?)? tfEmailTextControllerValidator;
  // State field(s) for tfPassword widget.
  FocusNode? tfPasswordFocusNode;
  TextEditingController? tfPasswordTextController;
  late bool tfPasswordVisibility;
  String? Function(BuildContext, String?)? tfPasswordTextControllerValidator;
  // State field(s) for tfPassword2 widget.
  FocusNode? tfPassword2FocusNode;
  TextEditingController? tfPassword2TextController;
  late bool tfPassword2Visibility;
  String? Function(BuildContext, String?)? tfPassword2TextControllerValidator;

  // Password Validation State
  bool passwordMatches = false;
  bool hasNumber = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasMinLength = false;

  void validatePassword(String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      hasNumber = false;
      hasUppercase = false;
      hasLowercase = false;
      hasMinLength = false;
      passwordMatches = false;
      return;
    }

    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasLowercase = password.contains(RegExp(r'[a-z]'));
    hasMinLength = password.length >= 8;
    
    passwordMatches = confirmPassword != null && 
                      confirmPassword.isNotEmpty && 
                      password == confirmPassword;
  }

  @override
  void initState(BuildContext context) {
    tfPasswordVisibility = false;
    tfPassword2Visibility = false;
  }

  @override
  void dispose() {
    tfEmailFocusNode?.dispose();
    tfEmailTextController?.dispose();

    tfPasswordFocusNode?.dispose();
    tfPasswordTextController?.dispose();

    tfPassword2FocusNode?.dispose();
    tfPassword2TextController?.dispose();
  }
}
