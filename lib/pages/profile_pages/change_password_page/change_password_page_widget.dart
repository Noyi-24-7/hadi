import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'change_password_page_model.dart';
export 'change_password_page_model.dart';

// Provider for fetching current user's store
final _currentUserStoresRowProvider = FutureProvider<StoresRow>((ref) async {
  final userId = currentUserUid;
  if (userId.isEmpty) {
    throw Exception('User not authenticated');
  }

  final response = await StoresTable().querySingleRow(
    queryFn: (q) => q.eq('owner_id', userId),
  );

  if (response.isEmpty) {
    throw Exception('Store not found');
  }

  return response.first;
});

/// Page users would navigate to to change their password.
class ChangePasswordPageWidget extends ConsumerStatefulWidget {
  const ChangePasswordPageWidget({super.key});

  static String routeName = 'Change_Password_Page';
  static String routePath = '/changePasswordPage';

  @override
  ConsumerState<ChangePasswordPageWidget> createState() =>
      _ChangePasswordPageWidgetState();
}

class _ChangePasswordPageWidgetState
    extends ConsumerState<ChangePasswordPageWidget> {
  late ChangePasswordPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePasswordPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().onboardingcomplete == true) {
        context.pushNamed(HomeMainWidget.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Finish setup tasks first',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'General Sans',
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          ),
        );
      }
    });

    _model.tfPasswordTextController1 ??= TextEditingController();
    _model.tfPasswordFocusNode1 ??= FocusNode();
    _model.tfPasswordTextController2 ??= TextEditingController();
    _model.tfPasswordFocusNode2 ??= FocusNode();
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
    context.watch<FFAppState>();

    final storeAsync = ref.watch(_currentUserStoresRowProvider);

    return storeAsync.when(
      data: (store) => _buildContent(context, store),
      loading: () => _buildLoading(context),
      error: (error, stack) => _buildError(context, error),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Center(
        child: SizedBox(
          width: 50.0,
          height: 50.0,
          child: SpinKitWanderingCubes(
            color: FlutterFlowTheme.of(context).primary,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Error loading store information'),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, StoresRow store) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildHeader(context),
                _buildPasswordForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => context.safePop(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.chevronLeft, color: FlutterFlowTheme.of(context).primaryText, size: 14.0),
                          Text(
                            'Back',
                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                  fontFamily: 'General Sans',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Change Password',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'General Sans',
                        letterSpacing: 0.0,
                      ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        ],
      ),
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Password',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'General Sans',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            'Enter your current password and create a new password',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: Color(0xFF2A2525),
                  letterSpacing: 0.0,
                ),
          ),
          SizedBox(height: 20),
          _buildPasswordField(
            context,
            label: 'Current password',
            controller: _model.tfPasswordTextController1,
            focusNode: _model.tfPasswordFocusNode1,
            obscureText: !_model.tfPasswordVisibility1,
            onVisibilityToggle: () {
              safeSetState(() => _model.tfPasswordVisibility1 = !_model.tfPasswordVisibility1);
            },
            validator: _model.tfPasswordTextController1Validator,
          ),
          SizedBox(height: 20),
          Text(
            'CREATE PASSWORD',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'General Sans',
                  color: Color(0xFF47425F),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 12),
          _buildPasswordField(
            context,
            label: 'New password',
            controller: _model.tfPasswordTextController2,
            focusNode: _model.tfPasswordFocusNode2,
            obscureText: !_model.tfPasswordVisibility2,
            onVisibilityToggle: () {
              safeSetState(() => _model.tfPasswordVisibility2 = !_model.tfPasswordVisibility2);
            },
            validator: _model.tfPasswordTextController2Validator,
          ),
          SizedBox(height: 12),
          _buildPasswordField(
            context,
            label: 'Confirm password',
            controller: _model.tfPassword2TextController,
            focusNode: _model.tfPassword2FocusNode,
            obscureText: !_model.tfPassword2Visibility,
            onVisibilityToggle: () {
              safeSetState(() => _model.tfPassword2Visibility = !_model.tfPassword2Visibility);
            },
            validator: _model.tfPassword2TextControllerValidator,
          ),
          SizedBox(height: 30),
          FFButtonWidget(
            onPressed: () {
              // TODO: Implement password change logic
            },
            text: 'Change Password',
            options: FFButtonOptions(
              width: double.infinity,
              height: 48.0,
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'General Sans',
                    color: Colors.white,
                    letterSpacing: 0.0,
                  ),
              elevation: 0.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    BuildContext context, {
    required String label,
    required TextEditingController? controller,
    required FocusNode? focusNode,
    required bool obscureText,
    required VoidCallback onVisibilityToggle,
    String? Function(BuildContext, String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'General Sans',
                color: Color(0xFF645E82),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Enter password',
            hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'General Sans',
                  color: Color(0xFFD6D6D6),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE1DFEC), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
            suffixIcon: InkWell(
              onTap: onVisibilityToggle,
              child: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Color(0x93B9AA94),
                size: 22,
              ),
            ),
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'General Sans',
                color: Color(0xFF1B1A23),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
          validator: validator != null ? (val) => validator(context, val) : null,
        ),
      ],
    );
  }
}
