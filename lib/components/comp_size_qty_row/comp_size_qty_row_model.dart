import '/flutter_flow/flutter_flow_util.dart';
import 'comp_size_qty_row_widget.dart' show CompSizeQtyRowWidget;
import 'package:flutter/material.dart';

class CompSizeQtyRowModel extends FlutterFlowModel<CompSizeQtyRowWidget> {
  ///  Local state fields for this component.

  double? priceLocal;

  int? qtyLocal;

  ///  State fields for stateful widgets in this component.

  // State field(s) for tfCompPrice widget.
  FocusNode? tfCompPriceFocusNode;
  TextEditingController? tfCompPriceTextController;
  String? Function(BuildContext, String?)? tfCompPriceTextControllerValidator;
  // State field(s) for tfCompQuantity widget.
  FocusNode? tfCompQuantityFocusNode;
  TextEditingController? tfCompQuantityTextController;
  String? Function(BuildContext, String?)?
      tfCompQuantityTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfCompPriceFocusNode?.dispose();
    tfCompPriceTextController?.dispose();

    tfCompQuantityFocusNode?.dispose();
    tfCompQuantityTextController?.dispose();
  }
}
