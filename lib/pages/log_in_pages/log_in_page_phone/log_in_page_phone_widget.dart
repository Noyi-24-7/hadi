import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import '/auth/supabase_auth/auth_util.dart';
import 'package:flutter/material.dart';
import 'log_in_page_phone_model.dart';
export 'log_in_page_phone_model.dart';

/// This is the page for logging in with the user's phone number.
class LogInPagePhoneWidget extends StatefulWidget {
  const LogInPagePhoneWidget({super.key});

  static String routeName = 'Log_in_Page_Phone';
  static String routePath = '/logInPagePhone';

  @override
  State<LogInPagePhoneWidget> createState() => _LogInPagePhoneWidgetState();
}

class _LogInPagePhoneWidgetState extends State<LogInPagePhoneWidget> {
  late LogInPagePhoneModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogInPagePhoneModel());

    _model.tfPhoneTextController ??= TextEditingController();
    _model.tfPhoneFocusNode ??= FocusNode();

    _model.tfPasswordTextController ??= TextEditingController();
    _model.tfPasswordFocusNode ??= FocusNode();
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
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log in',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Welcome back to Hadi',
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

              // If the user clicks this they'll navigate to the "Log_in_Page_Email" page.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(LogInPageEmailWidget.routeName);
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
                                        Icons.mail_outlined,
                                        color: Color(0xFF0C1D1F),
                                        size: 16.0,
                                      ),
                                      Text(
                                        'Login with email address',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF0C1D1F),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone number',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF645E82),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.5,
                                ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Color(0xFFE1DFEC),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 85.0,
                                    height: 54.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '🇳🇬+234',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF1B1A23),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Text Field for the Phone Number. Users would enter their phone number that they used to create their account, this information would be gotten from supabase.
                                  Expanded(
                                    child: Container(
                                      width: 200.0,
                                      child: TextFormField(
                                        controller:
                                            _model.tfPhoneTextController,
                                        focusNode: _model.tfPhoneFocusNode,
                                        autofocus: false,
                                        enabled: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    letterSpacing: 0.0,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFFD6D6D6),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 20.0, 16.0, 20.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF1B1A23),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.5,
                                            ),
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        enableInteractiveSelection: true,
                                        validator: _model
                                            .tfPhoneTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF645E82),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.5,
                                ),
                          ),

                          // Text Field for the Password. Users would enter their password that they used to create their account, this information would be gotten from supabase.
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.tfPasswordTextController,
                              focusNode: _model.tfPasswordFocusNode,
                              autofocus: false,
                              enabled: true,
                              obscureText: !_model.tfPasswordVisibility,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'General Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter password',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'General Sans',
                                      color: Color(0xFFD6D6D6),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.5,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE1DFEC),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 20.0, 16.0, 20.0),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    safeSetState(() =>
                                        _model.tfPasswordVisibility =
                                            !_model.tfPasswordVisibility);
                                  },
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.tfPasswordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Color(0x93B9AA94),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF1B1A23),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.5,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model
                                  .tfPasswordTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
              ),

              // Login Button, that would log the users in if they have created an account.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final phone = _model.tfPhoneTextController.text;
                    final password = _model.tfPasswordTextController.text;
                    if (phone.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                          content: Text('Phone and password are required'),
                        ),
                      );
                      return;
                    }
                    
                    // Add country code if missing
                    final formattedPhone = phone.startsWith('+') ? phone : '+234$phone'; // Assuming default NG based on UI

                    final user = await authManager.signInWithPhone(
                      context,
                      formattedPhone,
                      password,
                    );
                    
                    if (user != null) {
                       context.goNamed(HomeIncompleteInfoWidget.routeName);
                    }
                  },
                  text: 'Log in',
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

              // When the user clicks this they would navigate to the "Forgot_Password" Page.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 60.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I forgot my password',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFFA55954),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            lineHeight: 1.5,
                          ),
                    ),
                  ],
                ),
              ),

              // When the user clicks this they would navigate to the "CreateAccount_Phone" Page.
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'General Sans',
                          color: Color(0xFF434343),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          lineHeight: 1.5,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(CreateAccountPhoneWidget.routeName);
                    },
                    child: Text(
                      'Create Account',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFFA55954),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1.5,
                          ),
                    ),
                  ),
                ].divide(SizedBox(width: 4.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
