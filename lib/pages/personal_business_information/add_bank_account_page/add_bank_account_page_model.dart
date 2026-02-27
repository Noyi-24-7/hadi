import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_bank_account_page_widget.dart' show AddBankAccountPageWidget;
import 'package:flutter/material.dart';

class AddBankAccountPageModel
    extends FlutterFlowModel<AddBankAccountPageWidget> {
  ///  Local state fields for this page.

  String? selectedBankName;

  String? selectedBankCode;

  String? resolvedAccountName;

  String? bankVerifyStatus;

  String? bankVerifyError;

  ///  State fields for stateful widgets in this page.

  // State field(s) for tfAccountNumber widget.
  FocusNode? tfAccountNumberFocusNode;
  TextEditingController? tfAccountNumberTextController;
  String? Function(BuildContext, String?)?
      tfAccountNumberTextControllerValidator;
  // State field(s) for ddBank widget.
  String? ddBankValue;
  FormFieldController<String>? ddBankValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfAccountNumberFocusNode?.dispose();
    tfAccountNumberTextController?.dispose();
  }
}
