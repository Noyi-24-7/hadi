import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dart:async';
import 'edit_profile_page_widget.dart' show EditProfilePageWidget;
import 'package:flutter/material.dart';

class EditProfilePageModel extends FlutterFlowModel<EditProfilePageWidget> {
  ///  Local state fields for this page.

  String? profile;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_changedProfile = false;
  FFUploadedFile uploadedLocalFile_changedProfile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_changedProfile = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Container widget.
  List<ProfilesRow>? supabaseChangeProfileImageRow;
  Completer<List<StoresRow>>? requestCompleter;
  bool isDataUploading_uploadedProfile = false;
  FFUploadedFile uploadedLocalFile_uploadedProfile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadedProfile = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Container widget.
  List<ProfilesRow>? supabaseUpdateProfileImageRow;
  // State field(s) for tfFirstName widget.
  FocusNode? tfFirstNameFocusNode;
  TextEditingController? tfFirstNameTextController;
  String? Function(BuildContext, String?)? tfFirstNameTextControllerValidator;
  // State field(s) for tfLastName widget.
  FocusNode? tfLastNameFocusNode;
  TextEditingController? tfLastNameTextController;
  String? Function(BuildContext, String?)? tfLastNameTextControllerValidator;
  // State field(s) for tfBusinessName widget.
  FocusNode? tfBusinessNameFocusNode;
  TextEditingController? tfBusinessNameTextController;
  String? Function(BuildContext, String?)?
      tfBusinessNameTextControllerValidator;
  // State field(s) for ddRegistered widget.
  String? ddRegisteredValue;
  FormFieldController<String>? ddRegisteredValueController;
  // State field(s) for tfRCNumber widget.
  FocusNode? tfRCNumberFocusNode;
  TextEditingController? tfRCNumberTextController;
  String? Function(BuildContext, String?)? tfRCNumberTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<StoresRow>? businessInfo;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<ProfilesRow>? names;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfFirstNameFocusNode?.dispose();
    tfFirstNameTextController?.dispose();

    tfLastNameFocusNode?.dispose();
    tfLastNameTextController?.dispose();

    tfBusinessNameFocusNode?.dispose();
    tfBusinessNameTextController?.dispose();

    tfRCNumberFocusNode?.dispose();
    tfRCNumberTextController?.dispose();
  }

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
