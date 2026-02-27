import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'remove_product_widget.dart' show RemoveProductWidget;
import 'package:flutter/material.dart';

class RemoveProductModel extends FlutterFlowModel<RemoveProductWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Delete Row(s)] action in Container widget.
  List<ProductMediaDbRow>? productMediaDeleted;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Container widget.
  List<ProductsRow>? productDeleted;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
