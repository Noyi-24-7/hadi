import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_delivery_ticket_page_widget.dart'
    show CreateDeliveryTicketPageWidget;
import 'package:flutter/material.dart';

class CreateDeliveryTicketPageModel
    extends FlutterFlowModel<CreateDeliveryTicketPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfProductName widget.
  FocusNode? tfProductNameFocusNode1;
  TextEditingController? tfProductNameTextController1;
  String? Function(BuildContext, String?)?
      tfProductNameTextController1Validator;
  // State field(s) for tfProductAmount widget.
  FocusNode? tfProductAmountFocusNode;
  TextEditingController? tfProductAmountTextController;
  String? Function(BuildContext, String?)?
      tfProductAmountTextControllerValidator;
  // State field(s) for tfQuantity widget.
  FocusNode? tfQuantityFocusNode;
  TextEditingController? tfQuantityTextController;
  String? Function(BuildContext, String?)? tfQuantityTextControllerValidator;
  // State field(s) for tfWeight widget.
  FocusNode? tfWeightFocusNode;
  TextEditingController? tfWeightTextController;
  String? Function(BuildContext, String?)? tfWeightTextControllerValidator;
  // State field(s) for tfProductName widget.
  FocusNode? tfProductNameFocusNode2;
  TextEditingController? tfProductNameTextController2;
  String? Function(BuildContext, String?)?
      tfProductNameTextController2Validator;
  // State field(s) for tfProductName widget.
  FocusNode? tfProductNameFocusNode3;
  TextEditingController? tfProductNameTextController3;
  String? Function(BuildContext, String?)?
      tfProductNameTextController3Validator;
  // State field(s) for tfProductName widget.
  FocusNode? tfProductNameFocusNode4;
  TextEditingController? tfProductNameTextController4;
  String? Function(BuildContext, String?)?
      tfProductNameTextController4Validator;
  // State field(s) for tfProductName widget.
  FocusNode? tfProductNameFocusNode5;
  TextEditingController? tfProductNameTextController5;
  String? Function(BuildContext, String?)?
      tfProductNameTextController5Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfProductNameFocusNode1?.dispose();
    tfProductNameTextController1?.dispose();

    tfProductAmountFocusNode?.dispose();
    tfProductAmountTextController?.dispose();

    tfQuantityFocusNode?.dispose();
    tfQuantityTextController?.dispose();

    tfWeightFocusNode?.dispose();
    tfWeightTextController?.dispose();

    tfProductNameFocusNode2?.dispose();
    tfProductNameTextController2?.dispose();

    tfProductNameFocusNode3?.dispose();
    tfProductNameTextController3?.dispose();

    tfProductNameFocusNode4?.dispose();
    tfProductNameTextController4?.dispose();

    tfProductNameFocusNode5?.dispose();
    tfProductNameTextController5?.dispose();
  }
}
