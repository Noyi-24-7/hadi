import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'comp_color_qty_row_widget.dart' show CompColorQtyRowWidget;
import 'package:flutter/material.dart';

class CompColorQtyRowModel extends FlutterFlowModel<CompColorQtyRowWidget> {
  ///  Local state fields for this component.

  String? selectedSizeLabel;

  String? selectedQtyStr;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ddColorSize widget.
  String? ddColorSizeValue;
  FormFieldController<String>? ddColorSizeValueController;
  // State field(s) for ddColorQty widget.
  String? ddColorQtyValue;
  FormFieldController<String>? ddColorQtyValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
