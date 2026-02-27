import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'change_password_page_widget.dart' show ChangePasswordPageWidget;
import 'package:flutter/material.dart';

class ChangePasswordPageModel
    extends FlutterFlowModel<ChangePasswordPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfPassword widget.
  FocusNode? tfPasswordFocusNode1;
  TextEditingController? tfPasswordTextController1;
  late bool tfPasswordVisibility1;
  String? Function(BuildContext, String?)? tfPasswordTextController1Validator;
  // State field(s) for tfPassword widget.
  FocusNode? tfPasswordFocusNode2;
  TextEditingController? tfPasswordTextController2;
  late bool tfPasswordVisibility2;
  String? Function(BuildContext, String?)? tfPasswordTextController2Validator;
  // State field(s) for tfPassword2 widget.
  FocusNode? tfPassword2FocusNode;
  TextEditingController? tfPassword2TextController;
  late bool tfPassword2Visibility;
  String? Function(BuildContext, String?)? tfPassword2TextControllerValidator;

  @override
  void initState(BuildContext context) {
    tfPasswordVisibility1 = false;
    tfPasswordVisibility2 = false;
    tfPassword2Visibility = false;
  }

  @override
  void dispose() {
    tfPasswordFocusNode1?.dispose();
    tfPasswordTextController1?.dispose();

    tfPasswordFocusNode2?.dispose();
    tfPasswordTextController2?.dispose();

    tfPassword2FocusNode?.dispose();
    tfPassword2TextController?.dispose();
  }
}
