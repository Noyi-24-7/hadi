import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_pickup_address_bottom_sheet_widget.dart'
    show AddPickupAddressBottomSheetWidget;
import 'package:flutter/material.dart';

class AddPickupAddressBottomSheetModel
    extends FlutterFlowModel<AddPickupAddressBottomSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for tfcountry widget.
  FocusNode? tfcountryFocusNode;
  TextEditingController? tfcountryTextController;
  String? Function(BuildContext, String?)? tfcountryTextControllerValidator;
  // State field(s) for tfstate widget.
  FocusNode? tfstateFocusNode;
  TextEditingController? tfstateTextController;
  String? Function(BuildContext, String?)? tfstateTextControllerValidator;
  // State field(s) for tfLGA widget.
  FocusNode? tfLGAFocusNode;
  TextEditingController? tfLGATextController;
  String? Function(BuildContext, String?)? tfLGATextControllerValidator;
  // State field(s) for tfAddressLine1 widget.
  FocusNode? tfAddressLine1FocusNode;
  TextEditingController? tfAddressLine1TextController;
  String? Function(BuildContext, String?)?
      tfAddressLine1TextControllerValidator;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PickupAddressesRow? addPickupAddress;

  final formKey = GlobalKey<FormState>();

  @override
  void initState(BuildContext context) {
    tfcountryTextControllerValidator = _tfcountryTextControllerValidator;
    tfstateTextControllerValidator = _tfstateTextControllerValidator;
    tfLGATextControllerValidator = _tfLGATextControllerValidator;
    tfAddressLine1TextControllerValidator =
        _tfAddressLine1TextControllerValidator;
  }

  @override
  void dispose() {
    tfcountryFocusNode?.dispose();
    tfcountryTextController?.dispose();

    tfstateFocusNode?.dispose();
    tfstateTextController?.dispose();

    tfLGAFocusNode?.dispose();
    tfLGATextController?.dispose();

    tfAddressLine1FocusNode?.dispose();
    tfAddressLine1TextController?.dispose();
  }

  String? _tfcountryTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Country is required';
    }
    return null;
  }

  String? _tfstateTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  String? _tfLGATextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'City/LGA is required';
    }
    return null;
  }

  String? _tfAddressLine1TextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Address is required';
    }
    return null;
  }
}
