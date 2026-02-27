import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'rest_successful_page_model.dart';
export 'rest_successful_page_model.dart';

/// Button that would navigate back to the app to the "Log_in_Page_Email" or
/// "Log_in_Page_Phone" pages depending on what they selected on the.
class RestSuccessfulPageWidget extends StatefulWidget {
  const RestSuccessfulPageWidget({super.key});

  static String routeName = 'Rest_Successful_Page';
  static String routePath = '/restSuccessfulPage';

  @override
  State<RestSuccessfulPageWidget> createState() =>
      _RestSuccessfulPageWidgetState();
}

class _RestSuccessfulPageWidgetState extends State<RestSuccessfulPageWidget> {
  late RestSuccessfulPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestSuccessfulPageModel());
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
                      'Password reset successful',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Log in to access your account',
                      textAlign: TextAlign.center,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 120.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context
                        .pushNamed(LogInPageEmailWidget.routeName);
                  },
                  text: 'Return to login',
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
