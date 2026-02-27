import '/flutter_flow/flutter_flow_util.dart';
import 'preorders_page_widget.dart' show PreordersPageWidget;
import 'package:flutter/material.dart';

class PreordersPageModel extends FlutterFlowModel<PreordersPageWidget> {
  ///  Local state fields for this page.

  bool isPreOrders = true;

  bool isEmpty = false;

  bool isPreOrderItems = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
