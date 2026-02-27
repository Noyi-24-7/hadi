import '/backend/supabase/supabase.dart';
import '/components/side_menu/side_menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_incomplete_info_widget.dart' show HomeIncompleteInfoWidget;
import 'package:flutter/material.dart';

class HomeIncompleteInfoModel
    extends FlutterFlowModel<HomeIncompleteInfoWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Home_IncompleteInfo widget.
  List<StoresRow>? qryMyStore;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // State field(s) for Checkbox widget.
  bool? checkboxValue4;
  // Model for Side_Menu component.
  late SideMenuModel sideMenuModel;

  @override
  void initState(BuildContext context) {
    sideMenuModel = createModel(context, () => SideMenuModel());
  }

  @override
  void dispose() {
    sideMenuModel.dispose();
  }
}
