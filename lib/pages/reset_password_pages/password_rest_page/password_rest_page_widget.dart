import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'password_rest_page_model.dart';
export 'password_rest_page_model.dart';

/// This page is meant to be on the web, where the user would get to after
/// they click the link to rest their password.
class PasswordRestPageWidget extends StatefulWidget {
  const PasswordRestPageWidget({super.key});

  static String routeName = 'Password_Rest_Page';
  static String routePath = '/passwordRestPage';

  @override
  State<PasswordRestPageWidget> createState() => _PasswordRestPageWidgetState();
}

class _PasswordRestPageWidgetState extends State<PasswordRestPageWidget> {
  late PasswordRestPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PasswordRestPageModel());

    _model.tfPasswordTextController ??= TextEditingController();
    _model.tfPasswordFocusNode ??= FocusNode();

    _model.tfPassword2TextController ??= TextEditingController();
    _model.tfPassword2FocusNode ??= FocusNode();
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
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Reset 🔐',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Enter a new password',
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New password',
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

                              // User enters new password.
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Confirm password',
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

                              // User confirms new password.
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.tfPassword2TextController,
                                  focusNode: _model.tfPassword2FocusNode,
                                  autofocus: false,
                                  enabled: true,
                                  obscureText: !_model.tfPassword2Visibility,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 20.0, 16.0, 20.0),
                                    suffixIcon: InkWell(
                                      onTap: () async {
                                        safeSetState(() =>
                                            _model.tfPassword2Visibility =
                                                !_model.tfPassword2Visibility);
                                      },
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.tfPassword2Visibility
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
                                      .tfPassword2TextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                        ),

                        // Column containing 2 rows for the chips that would show if the password entered between the 2 Text Fields fit into certain criteria.
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 5.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // A row of chips that would be appearing dynamiclly to show if the user is typing the right and accepted password.
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Password Match Chip - active if the passwords match.
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: Color(0xFF8BA19D),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          Text(
                                            'Passwords Match',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF8BA19D),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),

                                  // A Number Chip - active if there's a number included in the password.
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: Color(0xFF8BA19D),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          Text(
                                            'A Number',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF8BA19D),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),

                                  // Uppercase Chip - active if there's an Uppercase letter included in the password.
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: Color(0xFF8BA19D),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          Text(
                                            'Uppercase Letter',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF8BA19D),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),

                              // A row of chips that would be appearing dynamiclly to show if the user is typing the right and accepted password.
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Lowercaase Chip - active if there's an Lowercase letter included in the password.
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: Color(0xFF8BA19D),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          Text(
                                            'Lowercase Letter',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF8BA19D),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),

                                  // At least 8 Characters Chip - active if there's at least 8 characters included in the password.
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: Color(0xFF8BA19D),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          Text(
                                            'At least 8 characters',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF8BA19D),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ].divide(SizedBox(height: 30.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Save and submit\n',
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
