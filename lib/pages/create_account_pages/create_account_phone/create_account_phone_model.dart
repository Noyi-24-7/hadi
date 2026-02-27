import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_account_phone_widget.dart' show CreateAccountPhoneWidget;
import 'package:flutter/material.dart';

class CreateAccountPhoneModel
    extends FlutterFlowModel<CreateAccountPhoneWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfPhone widget.
  FocusNode? tfPhoneFocusNode;
  TextEditingController? tfPhoneTextController;
  String? Function(BuildContext, String?)? tfPhoneTextControllerValidator;
  // State field(s) for ddHeardAbout widget.
  String? ddHeardAboutValue;
  FormFieldController<String>? ddHeardAboutValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfPhoneFocusNode?.dispose();
    tfPhoneTextController?.dispose();
  }
}
