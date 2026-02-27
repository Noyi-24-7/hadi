import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'update_business_info_page_widget.dart'
    show UpdateBusinessInfoPageWidget;
import 'package:flutter/material.dart';

class UpdateBusinessInfoPageModel
    extends FlutterFlowModel<UpdateBusinessInfoPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfBusinessName widget.
  FocusNode? tfBusinessNameFocusNode;
  TextEditingController? tfBusinessNameTextController;
  String? Function(BuildContext, String?)?
      tfBusinessNameTextControllerValidator;
  // State field(s) for ddRegistered widget.
  String? ddRegisteredValue;
  FormFieldController<String>? ddRegisteredValueController;
  // State field(s) for tfRCNumber widget.
  FocusNode? tfRCNumberFocusNode;
  TextEditingController? tfRCNumberTextController;
  String? Function(BuildContext, String?)? tfRCNumberTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<StoresRow>? updatedBusinessInfo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfBusinessNameFocusNode?.dispose();
    tfBusinessNameTextController?.dispose();

    tfRCNumberFocusNode?.dispose();
    tfRCNumberTextController?.dispose();
  }
}
