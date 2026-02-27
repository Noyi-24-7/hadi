import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'verification_code_model.dart';
export 'verification_code_model.dart';

class VerificationCodeWidget extends ConsumerStatefulWidget {
  const VerificationCodeWidget({super.key});

  static String routeName = 'Verification_Code';
  static String routePath = '/verificationCode';

  @override
  ConsumerState<VerificationCodeWidget> createState() => _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState extends ConsumerState<VerificationCodeWidget> {
  late VerificationCodeModel _model;
  
  bool _isTimerActive = true; // Local state for timer visibility

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerificationCodeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
    });

    _model.tfOtpFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    // context.watch<FFAppState>(); // Removed FFAppState watch
    final onboardingState = ref.watch(onboardingNotifierProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 35.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: 32.0,
                        height: 22.0,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/Hadi_Logo.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification code',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Enter the code you received.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'General Sans',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            lineHeight: 1.71,
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // The user's phone number they provided to be used to send the SMS for verification.
                            Text(
                              valueOrDefault<String>(
                                onboardingState.phoneNumber,
                                '0817 294 8113',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF2A2525),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.5,
                                  ),
                            ),

                            // Button that would navigate back to the "CreateAccount_Phone" page. So users can change their number.
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                    CreateAccountPhoneWidget.routeName);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Change Number',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'General Sans',
                                          color: Color(0xFFA55954),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFFA55954),
                                    size: 16.0,
                                  ),
                                ].divide(SizedBox(width: 5.0)),
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 48.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // OTP PIN wiget used to capture the OTP pin the users type in after getting it as a message.
                    PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      length: 6,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyLarge.override(
                                fontFamily: 'General Sans',
                                fontSize: 24.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.33,
                              ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      enableActiveFill: true,
                      autoFocus: true,
                      focusNode: _model.tfOtpFocusNode,
                      enablePinAutofill: false,
                      errorTextSpace: 16.0,
                      showCursor: true,
                      cursorColor: FlutterFlowTheme.of(context).primary,
                      obscureText: false,
                      hintCharacter: '●',
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        fieldHeight: 56.0,
                        fieldWidth: 50.0,
                        borderWidth: 1.03,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.11),
                          bottomRight: Radius.circular(4.11),
                          topLeft: Radius.circular(4.11),
                          topRight: Radius.circular(4.11),
                        ),
                        shape: PinCodeFieldShape.box,
                        activeColor: FlutterFlowTheme.of(context).primaryText,
                        inactiveColor: Color(0xFFBFBEBA),
                        selectedColor: FlutterFlowTheme.of(context).primary,
                        activeFillColor: Color(0xFFFAFAFA),
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Color(0xFFFAFAFA),
                      ),
                      controller: _model.tfOtp,
                      onChanged: (_) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: _model.tfOtpValidator.asValidator(context),
                    ),

                    // Timer Row that would only be visible when the OTP is still valid, after the timer runs out and it is no longer valid it would be invisible and show the Resend Row,
                    if (_isTimerActive == true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Code valid for ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF3F3A57),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 2.3,
                                  ),
                            ),

                            // Timer for reset, they would be sent another OTP verification code.
                            FlutterFlowTimer(
                              initialTime: _model.timerInitialTimeMs,
                              getDisplayTime: (value) =>
                                  StopWatchTimer.getDisplayTime(
                                value,
                                hours: false,
                                milliSecond: false,
                              ),
                              controller: _model.timerController,
                              updateStateInterval: Duration(milliseconds: 1000),
                              onChanged: (value, displayTime, shouldUpdate) {
                                _model.timerMilliseconds = value;
                                _model.timerValue = displayTime;
                                if (shouldUpdate) safeSetState(() {});
                              },
                              onEnded: () async {
                                 setState(() {
                                  _isTimerActive = false;
                                });
                              },
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF3F3A57),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 2.3,
                                  ),
                            ),
                          ],
                        ),
                      ),

                    // Reset Row that would only be visible when the OTP is not valid, after the timer runs out and it is no longer valid it would be visible and show the Resend via text and Resend via whatsapp,
                    if (_isTimerActive == false)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                final notifier = ref.read(onboardingNotifierProvider.notifier);
                                notifier.setChannel('sms');
                                await notifier.sendOtp();
                                
                                final currentState = ref.read(onboardingNotifierProvider);

                                if (currentState.error == null) {
                                  setState(() {
                                    _isTimerActive = true;
                                  });
                                  _model.timerController.onResetTimer();
                                  _model.timerController.onStartTimer();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        currentState.error ?? 'Error sending OTP',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Resend Code Via Text',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'General Sans',
                                      color: Color(0xFFA55954),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 2.3,
                                    ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                final notifier = ref.read(onboardingNotifierProvider.notifier);
                                notifier.setChannel('whatsapp');
                                await notifier.sendOtp();
                                
                                final currentState = ref.read(onboardingNotifierProvider);

                                if (currentState.error == null) {
                                  setState(() {
                                    _isTimerActive = true;
                                  });
                                  _model.timerController.onResetTimer();
                                  _model.timerController.onStartTimer();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        currentState.error ?? 'Error sending OTP',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Resend Code Via Whatsapp',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'General Sans',
                                      color: Color(0xFF298D7B),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 2.3,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),

              // Button to submit and verify that the OTP entered is correct and valid.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (_model.tfOtp!.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Enter the code',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      );
                    } else {
                      final notifier = ref.read(onboardingNotifierProvider.notifier);
                      notifier.setOtpCode(_model.tfOtp!.text);
                      await notifier.verifyOtp();
                      
                      final currentState = ref.read(onboardingNotifierProvider);

                      if (currentState.isPhoneVerified) {
                        context.pushNamed(VerifiedWidget.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Invalid code, try again: ${currentState.error ?? ''}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        );
                      }
                    }
                  },
                  text: 'Submit',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 72.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 24.0, 32.0, 24.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'General Sans',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
