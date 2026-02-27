import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'home_main_widget.dart' show HomeMainWidget;
import 'package:flutter/material.dart';

class HomeMainModel extends FlutterFlowModel<HomeMainWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadData4xq = false;
  FFUploadedFile uploadedLocalFile_uploadData4xq =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData4xq = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<StoresRow>? updateBanner;
  Completer<List<ProductsRow>>? requestCompleter;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
