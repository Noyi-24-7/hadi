import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'create_account_phone_model.dart';
export 'create_account_phone_model.dart';

/// The page the users get to when they want to create and account.
class CreateAccountPhoneWidget extends ConsumerStatefulWidget {
  const CreateAccountPhoneWidget({super.key});

  static String routeName = 'CreateAccount_Phone';
  static String routePath = '/createAccountPhone';

  @override
  ConsumerState<CreateAccountPhoneWidget> createState() =>
      _CreateAccountPhoneWidgetState();
}

class _CreateAccountPhoneWidgetState extends ConsumerState<CreateAccountPhoneWidget> {
  late CreateAccountPhoneModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccountPhoneModel());

    _model.tfPhoneTextController ??= TextEditingController();
    _model.tfPhoneFocusNode ??= FocusNode();
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
                      'Create Account - Enter Number',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Please provide your number for verification',
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

                          // Text Field for the Phone Number. Users would enter their phone number that they want to use to create their account, this information would be sent to supabase.
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.tfPhoneTextController,
                              focusNode: _model.tfPhoneFocusNode,
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
                                hintText: 'Enter phone number',
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
                              validator: _model.tfPhoneTextControllerValidator
                                  .asValidator(context),
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
                            'How did you here about us',
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

                          // Dropdown that shows options for them to select how they heard about the product.
                          FlutterFlowDropDown<String>(
                            controller: _model.ddHeardAboutValueController ??=
                                FormFieldController<String>(
                              _model.ddHeardAboutValue ??= '',
                            ),
                            options: List<String>.from([
                              'facebook',
                              'twitter',
                              'whatsapp',
                              'from a friend'
                            ]),
                            optionLabels: [
                              'Facebook',
                              'Twitter',
                              'Whatsapp',
                              'From a Friend'
                            ],
                            onChanged: (val) => safeSetState(
                                () => _model.ddHeardAboutValue = val),
                            width: double.infinity,
                            height: 53.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  letterSpacing: 0.0,
                                  lineHeight: 1.5,
                                ),
                            hintText: 'Select...',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF645E82),
                              size: 24.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 2.0,
                            borderColor: Color(0xFFE1DFEC),
                            borderWidth: 1.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
              ),

              // Button used to submit the users details to supabase. Then would navigate them to the Verify_Channel page.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    // Refactored to use Riverpod OnboardingNotifier
                    final notifier = ref.read(onboardingNotifierProvider.notifier);
                    notifier.setPhone(_model.tfPhoneTextController.text);
                    if (_model.ddHeardAboutValue != null) {
                      notifier.setHeardAbout(_model.ddHeardAboutValue!);
                    }
                    
                    // FFAppState usage removed. State is now managed by OnboardingNotifier.
                    // FFAppState().tmpphone = _model.tfPhoneTextController.text;
                    // FFAppState().tmpheardabout = _model.ddHeardAboutValue!;

                    context.pushNamed(VerifyChannelWidget.routeName);
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
