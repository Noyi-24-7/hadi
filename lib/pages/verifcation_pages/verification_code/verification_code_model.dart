import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'verification_code_widget.dart' show VerificationCodeWidget;
import 'package:flutter/material.dart';

class VerificationCodeModel extends FlutterFlowModel<VerificationCodeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for tfOtp widget.
  TextEditingController? tfOtp;
  FocusNode? tfOtpFocusNode;
  String? Function(BuildContext, String?)? tfOtpValidator;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 240000;
  int timerMilliseconds = 240000;
  String timerValue = StopWatchTimer.getDisplayTime(
    240000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Backend Call - API (otpSend)] action in Text widget.
  ApiCallResponse? otpSendSMS2;
  // Stores action output result for [Backend Call - API (otpSend)] action in Text widget.
  ApiCallResponse? otpSendWhatsapp2;
  // Stores action output result for [Backend Call - API (otpCheck)] action in Button widget.
  ApiCallResponse? otpCheck;

  @override
  void initState(BuildContext context) {
    tfOtp = TextEditingController();
  }

  @override
  void dispose() {
    tfOtpFocusNode?.dispose();
    tfOtp?.dispose();

    timerController.dispose();
  }
}
