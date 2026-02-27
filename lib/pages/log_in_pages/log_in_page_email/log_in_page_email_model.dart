import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'log_in_page_email_widget.dart' show LogInPageEmailWidget;
import 'package:flutter/material.dart';

class LogInPageEmailModel extends FlutterFlowModel<LogInPageEmailWidget> {
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

  @override
  void initState(BuildContext context) {
    tfPasswordVisibility = false;
  }

  @override
  void dispose() {
    tfEmailFocusNode?.dispose();
    tfEmailTextController?.dispose();

    tfPasswordFocusNode?.dispose();
    tfPasswordTextController?.dispose();
  }
}
