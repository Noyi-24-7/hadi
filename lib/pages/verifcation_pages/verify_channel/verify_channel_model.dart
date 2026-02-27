import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'verify_channel_widget.dart' show VerifyChannelWidget;
import 'package:flutter/material.dart';

class VerifyChannelModel extends FlutterFlowModel<VerifyChannelWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (otpSend)] action in Verify_via_SMS_Btn widget.
  ApiCallResponse? otpSendSMS;
  // Stores action output result for [Backend Call - API (otpSend)] action in Verify_via_Whatsapp_Btn widget.
  ApiCallResponse? otpSendWhatsapp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
