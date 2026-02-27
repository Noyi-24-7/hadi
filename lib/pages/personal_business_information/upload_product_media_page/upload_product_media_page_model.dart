import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'upload_product_media_page_widget.dart'
    show UploadProductMediaPageWidget;
import 'package:flutter/material.dart';

class UploadProductMediaPageModel
    extends FlutterFlowModel<UploadProductMediaPageWidget> {
  ///  Local state fields for this page.

  List<ProductMediaDbRow> mediaList = [];
  void addToMediaList(ProductMediaDbRow item) => mediaList.add(item);
  void removeFromMediaList(ProductMediaDbRow item) => mediaList.remove(item);
  void removeAtIndexFromMediaList(int index) => mediaList.removeAt(index);
  void insertAtIndexInMediaList(int index, ProductMediaDbRow item) =>
      mediaList.insert(index, item);
  void updateMediaListAtIndex(int index, Function(ProductMediaDbRow) updateFn) =>
      mediaList[index] = updateFn(mediaList[index]);

  bool isUploading = false;

  int? mediaCountOverride;

  List<ProductMediaEntryStructStruct> pendingMedia = [];
  void addToPendingMedia(ProductMediaEntryStructStruct item) =>
      pendingMedia.add(item);
  void removeFromPendingMedia(ProductMediaEntryStructStruct item) =>
      pendingMedia.remove(item);
  void removeAtIndexFromPendingMedia(int index) => pendingMedia.removeAt(index);
  void insertAtIndexInPendingMedia(
          int index, ProductMediaEntryStructStruct item) =>
      pendingMedia.insert(index, item);
  void updatePendingMediaAtIndex(
          int index, Function(ProductMediaEntryStructStruct) updateFn) =>
      pendingMedia[index] = updateFn(pendingMedia[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Upload_Product_Media_Page widget.
  List<ProductMediaDbRow>? qMedia;
  bool isDataUploading_pickedMedia = false;
  FFUploadedFile uploadedLocalFile_pickedMedia =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_pickedMedia = '';

  // Stores action output result for [Custom Action - getRemoteFileSizeBytes] action in Button widget.
  int? getSize;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
