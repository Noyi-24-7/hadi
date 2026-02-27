import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/side_menu/side_menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/app_config.dart'; // Import AppConfig
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_incomplete_info_model.dart';
export 'home_incomplete_info_model.dart';

// Provider for fetching current user's store
final _currentUserStoresRowProvider = FutureProvider<StoresRow>((ref) async {
  if (AppConfig.isMockMode) {
    // MOCK DATA FOR UI AUDIT
    await Future.delayed(const Duration(milliseconds: 500));
    return StoresRow({
      'id': '1',
      'owner_id': 'mock-user-id',
      'name': 'Mock Store',
      'slug': 'mock-store',
      'onboarding_complete': false, 
      'business_info_complete': true,
      'bank_complete': false,
      'pickup_address_complete': false,
      'storefront_setup_complete': false,
      'is_active': true,
      'created_at': DateTime.now().toIso8601String(),
    });
  } else {
    // REAL DATA
    final userId = currentUserUid; // from auth_util.dart
    if (userId.isEmpty) {
       throw Exception('User not logged in');
    }
    
    // Check if store exists, if not return a default "new" store or throw
    try {
      final response = await Supabase.instance.client
          .from('stores')
          .select()
          .eq('owner_id', userId)
          .limit(1)
          .maybeSingle();
      
      if (response == null) {
        // Return a default structure if no store found yet
         return StoresRow({
          'owner_id': userId,
          'name': 'New Store',
          'onboarding_complete': false,
          'business_info_complete': false,
          'bank_complete': false,
          'pickup_address_complete': false,
          'storefront_setup_complete': false,
          'is_active': true,
        });
      }
      return StoresRow(response);
    } catch (e) {
      // Fallback for robust UI testing if table missing or other error
      print('Error fetching store: $e');
      throw e;
    }
  }
});

/// This page is the page that shows only if the user hasn't finished
/// providing all his information, so they're meant to see the card showing
/// what they have left and the update button leading to the screen they need
/// to go to fill in the necessary information.
///
/// When all of this is completed, the page loads and checks if the onboarding
/// is complete, then navigate to the actual Main Home screen.
class HomeIncompleteInfoWidget extends ConsumerStatefulWidget {
  const HomeIncompleteInfoWidget({super.key});

  static String routeName = 'Home_IncompleteInfo';
  static String routePath = '/homeIncompleteInfo';

  @override
  ConsumerState<HomeIncompleteInfoWidget> createState() =>
      _HomeIncompleteInfoWidgetState();
}

class _HomeIncompleteInfoWidgetState
    extends ConsumerState<HomeIncompleteInfoWidget> {
  late HomeIncompleteInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeIncompleteInfoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final storeAsync = ref.read(_currentUserStoresRowProvider);
      
      storeAsync.when(
        data: (store) {
          FFAppState().onboardingcomplete = store.onboardingComplete;
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
        },
        loading: () {},
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading store: $error')),
          );
        },
      );
    });
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
            SizedBox(height: 8),
            Text('$error', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.sideMenuModel,
            updateCallback: () => safeSetState(() {}),
            child: SideMenuWidget(),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildHeader(context, store),
              _buildNotificationBadge(context),
              if (store.onboardingComplete == false)
                _buildOnboardingCard(context, store),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, StoresRow store) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFEAEDED),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.menu,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        Text(
                          'Menu',
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: 'General Sans',
                                color: Color(0xFF1C2626),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        store.name,
                        'Northing Official',
                      ),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'General Sans',
                            letterSpacing: 0.0,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            functions.getInitials(store.name!),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'General Sans',
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFEAEDED),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 12.0, 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.bell,
              color: Color(0xFF6B6B6B),
              size: 16.0,
            ),
            Text(
              'No new notifications',
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'General Sans',
                    color: Color(0xFF6B6B6B),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ].divide(SizedBox(width: 5.0)),
        ),
      ),
    );
  }

  Widget _buildOnboardingCard(BuildContext context, StoresRow store) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Color(0xFFEAEDED),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Just a few more things to go',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'General Sans',
                        color: Color(0xFF49455F),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (store.businessInfoComplete == false)
                            _buildCheckboxRow(
                                context, store.businessInfoComplete, 'Business Name & Info', 1),
                          if (store.bankComplete == false)
                            _buildCheckboxRow(
                                context, store.bankComplete, 'Your account number', 2),
                          if (store.pickupAddressComplete == false)
                            _buildCheckboxRow(
                                context, store.pickupAddressComplete, 'Set pickup address', 3),
                          if (store.storefrontSetupComplete == false)
                            _buildCheckboxRow(
                                context, store.storefrontSetupComplete, 'Setup store front', 4),
                        ],
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        if (store.businessInfoComplete == false) {
                          context.pushNamed(UpdateBusinessInfoPageWidget.routeName);
                          return;
                        } else if (store.bankComplete == false) {
                          context.pushNamed(AddBankAccountPageWidget.routeName);
                          return;
                        } else if (store.pickupAddressComplete == false) {
                          context.pushNamed(
                          AddPickupAddressPageWidget.routeName,
                          queryParameters: {
                            'returnToOnboarding': serializeParam(true, ParamType.bool),
                          }.withoutNulls,
                        );
                          return;
                        } else if (store.storefrontSetupComplete == false) {
                          context.pushNamed(HomeMainWidget.routeName);
                          return;
                        }
                      },
                      text: 'Update',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).tertiary,
                        textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'General Sans',
                              color: Colors.white,
                              letterSpacing: 0.0,
                              lineHeight: 1.142,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(BuildContext context, bool? isComplete, String label, int checkboxNum) {
    bool? checkboxValue;
    switch (checkboxNum) {
      case 1:
        checkboxValue = _model.checkboxValue1 ??= isComplete == true;
        break;
      case 2:
        checkboxValue = _model.checkboxValue2 ??= isComplete == true;
        break;
      case 3:
        checkboxValue = _model.checkboxValue3 ??= isComplete == true;
        break;
      case 4:
        checkboxValue = _model.checkboxValue4 ??= isComplete == true;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: CircleBorder(),
            ),
            unselectedWidgetColor: Color(0xFFD2D4D4),
          ),
          child: Checkbox(
            value: checkboxValue,
            onChanged: (newValue) async {
              safeSetState(() {
                switch (checkboxNum) {
                  case 1:
                    _model.checkboxValue1 = newValue!;
                    break;
                  case 2:
                    _model.checkboxValue2 = newValue!;
                    break;
                  case 3:
                    _model.checkboxValue3 = newValue!;
                    break;
                  case 4:
                    _model.checkboxValue4 = newValue!;
                    break;
                }
              });
            },
            side: BorderSide(
              width: 2,
              color: Color(0xFFD2D4D4),
            ),
            activeColor: FlutterFlowTheme.of(context).primary,
            checkColor: FlutterFlowTheme.of(context).info,
          ),
        ),
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'General Sans',
                letterSpacing: 0.0,
                lineHeight: 1.14,
              ),
        ),
      ].divide(SizedBox(width: 2.0)),
    );
  }

}
