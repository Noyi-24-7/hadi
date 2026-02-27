import '/flutter_flow/flutter_flow_util.dart';
import 'product_details_page_widget.dart' show ProductDetailsPageWidget;
import 'package:flutter/material.dart';

class ProductDetailsPageModel
    extends FlutterFlowModel<ProductDetailsPageWidget> {
  ///  Local state fields for this page.

  int activeMediaIndex = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Current_Active_Image_Pageview widget.
  PageController? currentActiveImagePageviewController;

  int get currentActiveImagePageviewCurrentIndex =>
      currentActiveImagePageviewController != null &&
              currentActiveImagePageviewController!.hasClients &&
              currentActiveImagePageviewController!.page != null
          ? currentActiveImagePageviewController!.page!.round()
          : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
