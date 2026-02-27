import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'checkout1_page_widget.dart' show Checkout1PageWidget;
import 'package:flutter/material.dart';

class Checkout1PageModel extends FlutterFlowModel<Checkout1PageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  final formKey = GlobalKey<FormState>();
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for tfBuyerName widget.
  FocusNode? tfBuyerNameFocusNode;
  TextEditingController? tfBuyerNameTextController;
  String? Function(BuildContext, String?)? tfBuyerNameTextControllerValidator;
  // State field(s) for tfBuyerNumber widget.
  FocusNode? tfBuyerNumberFocusNode;
  TextEditingController? tfBuyerNumberTextController;
  String? Function(BuildContext, String?)? tfBuyerNumberTextControllerValidator;
  // State field(s) for tfBuyerEmail widget.
  FocusNode? tfBuyerEmailFocusNode;
  TextEditingController? tfBuyerEmailTextController;
  String? Function(BuildContext, String?)? tfBuyerEmailTextControllerValidator;
  // State field(s) for ddcountry widget.
  String? ddcountryValue;
  FormFieldController<String>? ddcountryValueController;
  // State field(s) for ddstate widget.
  String? ddstateValue;
  FormFieldController<String>? ddstateValueController;
  // State field(s) for tflga widget.
  String? tflgaValue;
  FormFieldController<String>? tflgaValueController;
  // State field(s) for tfAddress widget.
  FocusNode? tfAddressFocusNode;
  TextEditingController? tfAddressTextController;
  String? Function(BuildContext, String?)? tfAddressTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfBuyerNameFocusNode?.dispose();
    tfBuyerNameTextController?.dispose();

    tfBuyerNumberFocusNode?.dispose();
    tfBuyerNumberTextController?.dispose();

    tfBuyerEmailFocusNode?.dispose();
    tfBuyerEmailTextController?.dispose();

    tfAddressFocusNode?.dispose();
    tfAddressTextController?.dispose();
  }
}
