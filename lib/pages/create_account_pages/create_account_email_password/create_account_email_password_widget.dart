import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import '/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'create_account_email_password_model.dart';
export 'create_account_email_password_model.dart';

/// Page to enter the user's email and password so they can log in next time.
class CreateAccountEmailPasswordWidget extends ConsumerStatefulWidget {
  const CreateAccountEmailPasswordWidget({super.key});

  static String routeName = 'CreateAccount_EmailPassword';
  static String routePath = '/createAccountEmailPassword';

  @override
  ConsumerState<CreateAccountEmailPasswordWidget> createState() =>
      _CreateAccountEmailPasswordWidgetState();
}

class _CreateAccountEmailPasswordWidgetState
    extends ConsumerState<CreateAccountEmailPasswordWidget> {
  late CreateAccountEmailPasswordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccountEmailPasswordModel());

    _model.tfEmailTextController ??= TextEditingController();
    _model.tfEmailFocusNode ??= FocusNode();

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
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Almost done 🎉',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Create a secure password for your account',
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email address',
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

                          // Text Field for the Email. Users would enter their email that they want to use to login to their account, this information would be sent to supabase.
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.tfEmailTextController,
                              focusNode: _model.tfEmailFocusNode,
                              autofocus: false,
                              enabled: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'General Sans',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter email',
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
                              validator: _model.tfEmailTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'CREATE PASSWORD',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF47425F),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.5,
                                ),
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

                              // Text Field where users would enter their password that they want to use to login next time.
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.tfPasswordTextController,
                                  focusNode: _model.tfPasswordFocusNode,
                                  onChanged: (_) => safeSetState(() {
                                    _model.validatePassword(
                                      _model.tfPasswordTextController.text,
                                      _model.tfPassword2TextController.text,
                                    );
                                  }),
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

                              // Text Field where users would confirm their password matches the 1st one in tf passowrd1 that they want to use to login next time.
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.tfPassword2TextController,
                                  focusNode: _model.tfPassword2FocusNode,
                                  onChanged: (_) => safeSetState(() {
                                    _model.validatePassword(
                                      _model.tfPasswordTextController.text,
                                      _model.tfPassword2TextController.text,
                                    );
                                  }),
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
                                  // Password Match Chip
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: _model.passwordMatches
                                          ? Color(0xFF8BA19D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: _model.passwordMatches
                                            ? Color(0xFF8BA19D)
                                            : Color(0xFFE0E3E7),
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
                                            color: _model.passwordMatches
                                                ? Colors.white
                                                : Color(0xFFE0E3E7),
                                            size: 10.0,
                                          ),
                                          Text(
                                            'Passwords Match',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: _model.passwordMatches
                                                      ? Colors.white
                                                      : Color(0xFFE0E3E7),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),

                                  // A Number Chip
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: _model.hasNumber
                                          ? Color(0xFF8BA19D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: _model.hasNumber
                                            ? Color(0xFF8BA19D)
                                            : Color(0xFFE0E3E7),
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
                                            color: _model.hasNumber
                                                ? Colors.white
                                                : Color(0xFFE0E3E7),
                                            size: 10.0,
                                          ),
                                          Text(
                                            'A Number',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: _model.hasNumber
                                                      ? Colors.white
                                                      : Color(0xFFE0E3E7),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),

                                  // Uppercase Chip
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: _model.hasUppercase
                                          ? Color(0xFF8BA19D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: _model.hasUppercase
                                            ? Color(0xFF8BA19D)
                                            : Color(0xFFE0E3E7),
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
                                            color: _model.hasUppercase
                                                ? Colors.white
                                                : Color(0xFFE0E3E7),
                                            size: 10.0,
                                          ),
                                          Text(
                                            'Uppercase Letter',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: _model.hasUppercase
                                                      ? Colors.white
                                                      : Color(0xFFE0E3E7),
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
                                  // Lowercaase Chip
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: _model.hasLowercase
                                          ? Color(0xFF8BA19D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: _model.hasLowercase
                                            ? Color(0xFF8BA19D)
                                            : Color(0xFFE0E3E7),
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
                                            color: _model.hasLowercase
                                                ? Colors.white
                                                : Color(0xFFE0E3E7),
                                            size: 10.0,
                                          ),
                                          Text(
                                            'Lowercase Letter',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: _model.hasLowercase
                                                      ? Colors.white
                                                      : Color(0xFFE0E3E7),
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 3.0)),
                                      ),
                                    ),
                                  ),

                                  // At least 8 Characters Chip
                                  Container(
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: _model.hasMinLength
                                          ? Color(0xFF8BA19D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14.5),
                                      border: Border.all(
                                        color: _model.hasMinLength
                                            ? Color(0xFF8BA19D)
                                            : Color(0xFFE0E3E7),
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
                                            color: _model.hasMinLength
                                                ? Colors.white
                                                : Color(0xFFE0E3E7),
                                            size: 10.0,
                                          ),
                                          Text(
                                            'At least 8 characters',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: _model.hasMinLength
                                                      ? Colors.white
                                                      : Color(0xFFE0E3E7),
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

              // Submit button meant to save all these information so they user can returns to log in they can.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (_model.tfPasswordTextController.text !=
                        _model.tfPassword2TextController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Passwords don’t match',
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
                      GoRouter.of(context).prepareAuthEvent();
                      if (_model.tfPasswordTextController.text !=
                          _model.tfPassword2TextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Passwords don\'t match!',
                            ),
                          ),
                        );
                        return;
                      }

                      final notifier = ref.read(onboardingNotifierProvider.notifier);
                      
                      notifier.setEmail(_model.tfEmailTextController.text);
                      notifier.setPassword(_model.tfPasswordTextController.text);

                      await notifier.createAccount();
                      
                      final currentState = ref.read(onboardingNotifierProvider);

                      if (currentState.error != null) {
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error: ${currentState.error}',
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

                      context.pushNamedAuth(
                          HomeIncompleteInfoWidget.routeName, context.mounted);
                    }
                  },
                  text: 'Submit & create account',
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'By registering on Hadi, you agree to our Terms & Conditions and Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'General Sans',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              lineHeight: 1.6,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
