import '/flutter_flow/flutter_flow_util.dart';
import 'password_rest_page_widget.dart' show PasswordRestPageWidget;
import 'package:flutter/material.dart';

class PasswordRestPageModel extends FlutterFlowModel<PasswordRestPageWidget> {
  ///  State fields for stateful widgets in this page.

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

  @override
  void initState(BuildContext context) {
    tfPasswordVisibility = false;
    tfPassword2Visibility = false;
  }

  @override
  void dispose() {
    tfPasswordFocusNode?.dispose();
    tfPasswordTextController?.dispose();

    tfPassword2FocusNode?.dispose();
    tfPassword2TextController?.dispose();
  }
}
