import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'log_in_page_phone_widget.dart' show LogInPagePhoneWidget;
import 'package:flutter/material.dart';

class LogInPagePhoneModel extends FlutterFlowModel<LogInPagePhoneWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfPhone widget.
  FocusNode? tfPhoneFocusNode;
  TextEditingController? tfPhoneTextController;
  String? Function(BuildContext, String?)? tfPhoneTextControllerValidator;
  // State field(s) for tfPassword widget.
  FocusNode? tfPasswordFocusNode;
  TextEditingController? tfPasswordTextController;
  late bool tfPasswordVisibility;
  String? Function(BuildContext, String?)? tfPasswordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    tfPasswordVisibility = false;
  }

  @override
  void dispose() {
    tfPhoneFocusNode?.dispose();
    tfPhoneTextController?.dispose();

    tfPasswordFocusNode?.dispose();
    tfPasswordTextController?.dispose();
  }
}
