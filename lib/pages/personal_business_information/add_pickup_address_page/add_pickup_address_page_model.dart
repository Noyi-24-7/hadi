import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_pickup_address_page_widget.dart' show AddPickupAddressPageWidget;
import 'package:flutter/material.dart';

class AddPickupAddressPageModel
    extends FlutterFlowModel<AddPickupAddressPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfcountry widget.
  final formKey = GlobalKey<FormState>();
  String? tfcountryValue;
  FormFieldController<String>? tfcountryValueController;
  // State field(s) for ddState widget.
  String? ddStateValue;
  FormFieldController<String>? ddStateValueController;
  // State field(s) for tfCity widget.
  FocusNode? tfCityFocusNode;
  TextEditingController? tfCityTextController;
  String? Function(BuildContext, String?)? tfCityTextControllerValidator;
  // State field(s) for tfAddress1 widget.
  FocusNode? tfAddress1FocusNode;
  TextEditingController? tfAddress1TextController;
  String? Function(BuildContext, String?)? tfAddress1TextControllerValidator;
  // State field(s) for tfAddress2 widget.
  FocusNode? tfAddress2FocusNode;
  TextEditingController? tfAddress2TextController;
  String? Function(BuildContext, String?)? tfAddress2TextControllerValidator;
  // State field(s) for tfZip widget.
  FocusNode? tfZipFocusNode;
  TextEditingController? tfZipTextController;
  String? Function(BuildContext, String?)? tfZipTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfCityFocusNode?.dispose();
    tfCityTextController?.dispose();

    tfAddress1FocusNode?.dispose();
    tfAddress1TextController?.dispose();

    tfAddress2FocusNode?.dispose();
    tfAddress2TextController?.dispose();

    tfZipFocusNode?.dispose();
    tfZipTextController?.dispose();
  }
}
