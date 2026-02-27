import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'verified_model.dart';
export 'verified_model.dart';

/// Page that shows when a user's OTP verified.
class VerifiedWidget extends StatefulWidget {
  const VerifiedWidget({super.key});

  static String routeName = 'Verified';
  static String routePath = '/verified';

  @override
  State<VerifiedWidget> createState() => _VerifiedWidgetState();
}

class _VerifiedWidgetState extends State<VerifiedWidget> {
  late VerifiedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifiedModel());
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Container(
                      width: 200.0,
                      height: 150.0,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/success-018@1x_1.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Verified!',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Phone number verified succesfully',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'General Sans',
                            color: FlutterFlowTheme.of(context).primary,
                            letterSpacing: 0.0,
                            lineHeight: 1.71,
                          ),
                    ),
                  ],
                ),
              ),

              // Button would Navigate to the "CreateAccount_EmailPassword" page, so they can their complete their sign up process.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 120.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context
                        .pushNamed(HomeIncompleteInfoWidget.routeName);
                  },
                  text: 'Finish account setup',
                  options: FFButtonOptions(
                    height: 72.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 24.0, 32.0, 24.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'General Sans',
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
