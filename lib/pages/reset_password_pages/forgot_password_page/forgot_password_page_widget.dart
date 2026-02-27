import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'forgot_password_page_model.dart';
export 'forgot_password_page_model.dart';

/// Page where the usesr would select what they want to use to reset their
/// password.
class ForgotPasswordPageWidget extends StatefulWidget {
  const ForgotPasswordPageWidget({super.key});

  static String routeName = 'Forgot_Password_Page';
  static String routePath = '/forgotPasswordPage';

  @override
  State<ForgotPasswordPageWidget> createState() =>
      _ForgotPasswordPageWidgetState();
}

class _ForgotPasswordPageWidgetState extends State<ForgotPasswordPageWidget> {
  late ForgotPasswordPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForgotPasswordPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Forgot password?',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'We can help you with that, please select a way to reset your password',
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

              // After it's clicked it would send the reset link to the user's number, then navigate to the "Rest_Link_Sent_Page".
              InkWell(
                onTap: () async {
                  // Phone OTP reset — navigates to confirmation page.
                  // TODO: call Supabase auth.signInWithOtp(phone: ...) here when phone capture is available.
                  context.pushNamed(RestLinkSentPageWidget.routeName);
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/telephone.png',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Reset with phone number',
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

              // After it's clicked it would send the reset link to the user's email, then navigate to the "Rest_Link_Sent_Page".
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                child: InkWell(
                  onTap: () async {
                    // Email reset — navigates to confirmation page.
                    // TODO: call Supabase auth.resetPasswordForEmail(email: ...) when email capture is available.
                    context.pushNamed(RestLinkSentPageWidget.routeName);
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/mail-01.png',
                                          width: 24.0,
                                          height: 24.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Reset with email',
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0x26C6C6C6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Text(
                            'We will send a password reset link to the phone number or email you used to register with us.',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF343434),
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
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
