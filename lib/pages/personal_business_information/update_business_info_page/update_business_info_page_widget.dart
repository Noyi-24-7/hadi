import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'update_business_info_page_model.dart';
export 'update_business_info_page_model.dart';

// Provider for fetching current user's store
final _currentUserStoresRowProvider = FutureProvider<StoresRow>((ref) async {
  final userId = currentUserUid;
  if (userId.isEmpty) {
    throw Exception('User not authenticated');
  }

  final response = await StoresTable().queryRows(
    queryFn: (q) => q.eq('owner_id', userId).limit(1),
  );

  if (response.isEmpty) {
    throw Exception('Store not found');
  }

  return response.first;
});

class UpdateBusinessInfoPageWidget extends ConsumerStatefulWidget {
  const UpdateBusinessInfoPageWidget({super.key});

  static String routeName = 'Update_Business_Info_Page';
  static String routePath = '/updateBusinessInfoPage';

  @override
  ConsumerState<UpdateBusinessInfoPageWidget> createState() =>
      _UpdateBusinessInfoPageWidgetState();
}

class _UpdateBusinessInfoPageWidgetState
    extends ConsumerState<UpdateBusinessInfoPageWidget> {
  late UpdateBusinessInfoPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateBusinessInfoPageModel());
    _model.tfBusinessNameFocusNode ??= FocusNode();
    _model.tfRCNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(_currentUserStoresRowProvider);

    return storeAsync.when(
      data: (store) {
        // Initialize fields with data if not already set (checking controller text to avoid overwriting user input on rebuilds)
        if (_model.tfBusinessNameTextController == null || _model.tfBusinessNameTextController!.text.isEmpty) {
             _model.tfBusinessNameTextController ??= TextEditingController();
             if (store.name != null && _model.tfBusinessNameTextController!.text.isEmpty) {
                 _model.tfBusinessNameTextController!.text = store.name!;
             }
        }
        
         if (_model.tfRCNumberTextController == null || _model.tfRCNumberTextController!.text.isEmpty) {
             _model.tfRCNumberTextController ??= TextEditingController();
             if (store.rcNumber != null && _model.tfRCNumberTextController!.text.isEmpty) {
                 _model.tfRCNumberTextController!.text = store.rcNumber!;
             }
        }

        if (_model.ddRegisteredValue == null) {
          _model.ddRegisteredValue = store.registrationStatus;
          _model.ddRegisteredValueController ??= FormFieldController<String>(_model.ddRegisteredValue);
        }

        return _buildContent(context, store);
      },
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
            Text('Error loading business information'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, store),
                _buildForm(context, store),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, StoresRow store) {
    return Column(
      children: [
        Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.menu, color: FlutterFlowTheme.of(context).primaryText, size: 24.0),
                    Text(
                      'Menu',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFF1C2626),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Row(
                children: [
                  Text(
                    valueOrDefault<String>(store.name, 'Northing Official'),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'General Sans',
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5CA86),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Center(
                      child: Text(
                        functions.getInitials(store.name!),
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'General Sans',
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ],
          ),
        ),
        Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
      ],
    );
  }

  Widget _buildForm(BuildContext context, StoresRow store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
           padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 0.0),
           child: InkWell(
             onTap: () => context.safePop(),
             child: Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 FaIcon(FontAwesomeIcons.chevronLeft, color: FlutterFlowTheme.of(context).primaryText, size: 14.0),
                 Text('Back', style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'General Sans', fontSize: 18.0, fontWeight: FontWeight.w500)),
               ].divide(SizedBox(width: 8.0)),
             ),
           ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Business Name', style: FlutterFlowTheme.of(context).titleLarge.override(fontFamily: 'General Sans', fontWeight: FontWeight.w500)),
              Text('Enter your business name', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'General Sans', color: Color(0xFF2A2525))),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Business name', style: FlutterFlowTheme.of(context).labelMedium.override(fontFamily: 'General Sans', color: Color(0xFF645E82), fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              TextFormField(
                controller: _model.tfBusinessNameTextController,
                focusNode: _model.tfBusinessNameFocusNode,
                decoration: InputDecoration(
                  hintText: 'eg. Hadi',
                  hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(fontFamily: 'General Sans', color: Color(0xFFD6D6D6)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE1DFEC)), borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary), borderRadius: BorderRadius.circular(8.0)),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(fontFamily: 'General Sans', color: Color(0xFF1B1A23)),
                validator: _model.tfBusinessNameTextControllerValidator.asValidator(context),
              ),
              SizedBox(height: 20),
              Text('Is your business registered?', style: FlutterFlowTheme.of(context).labelMedium.override(fontFamily: 'General Sans', color: Color(0xFF645E82), fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              FlutterFlowDropDown<String>(
                controller: _model.ddRegisteredValueController ??= FormFieldController<String>(_model.ddRegisteredValue),
                options: ['no', 'yes'],
                optionLabels: ['No', 'Yes'],
                onChanged: (val) => safeSetState(() => _model.ddRegisteredValue = val),
                width: double.infinity,
                height: 53.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'General Sans',
                      letterSpacing: 0.0,
                      lineHeight: 1.5,
                    ),
                hintText: 'Select...',
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                elevation: 2.0,
                borderColor: Color(0xFFE1DFEC),
                borderWidth: 1.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              ),
              if (_model.ddRegisteredValue == 'Yes' || _model.ddRegisteredValue == 'yes') ...[
                 SizedBox(height: 20),
                 Text('RC number', style: FlutterFlowTheme.of(context).labelMedium.override(fontFamily: 'General Sans', color: Color(0xFF645E82), fontWeight: FontWeight.w500)),
                 SizedBox(height: 4),
                 TextFormField(
                   controller: _model.tfRCNumberTextController,
                   focusNode: _model.tfRCNumberFocusNode,
                   decoration: InputDecoration(
                     hintText: 'eg. RC1234567',
                     hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(fontFamily: 'General Sans', color: Color(0xFFD6D6D6)),
                     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE1DFEC)), borderRadius: BorderRadius.circular(8.0)),
                     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary), borderRadius: BorderRadius.circular(8.0)),
                     filled: true,
                     fillColor: FlutterFlowTheme.of(context).primaryBackground,
                   ),
                   style: FlutterFlowTheme.of(context).bodyLarge.override(fontFamily: 'General Sans', color: Color(0xFF1B1A23)),
                   validator: _model.tfRCNumberTextControllerValidator.asValidator(context),
                 ),
              ],
              SizedBox(height: 30),
              FFButtonWidget(
                onPressed: () async {
                   final businessName = _model.tfBusinessNameTextController?.text ?? '';
                   final rcNumber = _model.tfRCNumberTextController?.text ?? '';
                   final isRegistered = _model.ddRegisteredValue == 'Yes' || _model.ddRegisteredValue == 'yes';
                   
                   if (businessName.isEmpty || (isRegistered && rcNumber.isEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please make sure all information has been filled')),
                      );
                      return;
                   }
                   
                   await StoresTable().update(
                     data: {
                       'name': businessName,
                       'registration_status': _model.ddRegisteredValue,
                       'rc_number': rcNumber,
                       'business_info_complete': true,
                     },
                     matchingRows: (rows) => rows.eq('id', store.id),
                   );
                   
                   if (context.mounted) {
                      context.pushNamed(AddBankAccountPageWidget.routeName);
                   }
                },
                text: 'Submit',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 72.0,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(fontFamily: 'General Sans', color: Colors.white),
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
