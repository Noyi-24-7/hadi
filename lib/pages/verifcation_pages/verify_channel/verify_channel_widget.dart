import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/app_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'verify_channel_model.dart';
export 'verify_channel_model.dart';

/// The page the user gets to after they try to create their account, so they
/// can select the option they want to use to verify their phone number.
class VerifyChannelWidget extends ConsumerStatefulWidget {
  const VerifyChannelWidget({super.key});

  static String routeName = 'Verify_Channel';
  static String routePath = '/verifyChannel';

  @override
  ConsumerState<VerifyChannelWidget> createState() => _VerifyChannelWidgetState();
}

class _VerifyChannelWidgetState extends ConsumerState<VerifyChannelWidget> {
  late VerifyChannelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifyChannelModel());

    // Mock Mode: Initialize phone if empty
    if (AppConfig.isMockMode && FFAppState().tmpphone.isEmpty) {
      FFAppState().tmpphone = '+2348000000000';
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<FFAppState>(); // Removed FFAppState watch

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
                      'Verification Options',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'How would you like to receive your verification code?',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'General Sans',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            lineHeight: 1.71,
                          ),
                    ),
                  ],
                ),
              ),

              // When the user clicks it, it would Navigate to the "Verification_Code" page. But would trigger the OTP code sending for verification via SMS using Tremi.
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  final notifier = ref.read(onboardingNotifierProvider.notifier);
                  notifier.setChannel('sms');
                  
                  // Use phone from notifier state if needed, or assume it's already set 
                  // from previous screen.
                  // For safety, we check current state.
                  final currentState = ref.read(onboardingNotifierProvider);
                  
                  if (currentState.phoneNumber.isEmpty) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Phone number not found. Please go back.',
                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'General Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    );
                    return;
                  }

                  await notifier.sendOtp();
                  
                  final updatedState = ref.read(onboardingNotifierProvider);
                  if (updatedState.error == null) {
                    context.pushNamed(VerificationCodeWidget.routeName);
                  } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          updatedState.error ?? 'Error sending OTP',
                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'General Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 72.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.message_outlined,
                                      color: Color(0xFF0C1D1F),
                                      size: 24.0,
                                    ),
                                    Text(
                                      'Text Message',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF0C1D1F),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.6,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ),
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Color(0x93B9AA94),
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ],
                  ),
                ),
              ),

              // When the user clicks it, it would Navigate to the "Verification_Code" page. But would trigger the OTP code sending for verification via Whatsapp using Tremi.
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  final notifier = ref.read(onboardingNotifierProvider.notifier);
                  notifier.setChannel('whatsapp');
                  
                  final currentState = ref.read(onboardingNotifierProvider);
                  
                  if (currentState.phoneNumber.isEmpty) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Phone number not found. Please go back.',
                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'General Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    );
                    return;
                  }

                  await notifier.sendOtp();
                  
                  final updatedState = ref.read(onboardingNotifierProvider);
                  if (updatedState.error == null) {
                    context.pushNamed(VerificationCodeWidget.routeName);
                  } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          updatedState.error ?? 'Error sending OTP',
                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'General Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    );
                  }
                },

                child: Container(
                  width: double.infinity,
                  height: 72.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Color(0xFF0C1D1F),
                                      size: 24.0,
                                    ),
                                    Text(
                                      'Whatsapp Message',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF0C1D1F),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.6,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ),
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Color(0x93B9AA94),
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ],
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
