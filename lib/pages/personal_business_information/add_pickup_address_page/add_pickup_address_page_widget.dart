import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/side_menu/side_menu_widget.dart';
import '../../../../features/orders/presentation/providers/checkout_provider.dart';
import '../../deliveryonly_page/checkout_1_page/checkout1_page_widget.dart';
import 'add_pickup_address_page_model.dart';
export 'add_pickup_address_page_model.dart';
import '/backend/supabase/database/tables/pickup_addresses.dart';
import '/index.dart';

final addPickupAddressPageStoreProvider = FutureProvider<StoresRow>((ref) async {
  final userId = currentUserUid;
  if (userId.isEmpty) {
    throw Exception('User not authenticated');
  }
  final response = await StoresTable().querySingleRow(
    queryFn: (q) => q.eq('owner_id', userId).limit(1),
  );
  if (response.isEmpty) {
    throw Exception('Store not found');
  }
  return response.first;
});

class AddPickupAddressPageWidget extends ConsumerStatefulWidget {
  const AddPickupAddressPageWidget({super.key, this.returnToOnboarding = false});

  /// When true, saving the address navigates back to [HomeIncompleteInfoWidget]
  /// (onboarding flow). When false, it navigates to [Checkout1PageWidget]
  /// (delivery ticket checkout flow).
  final bool returnToOnboarding;

  static String routeName = 'Add_Pickup_Address_Page';
  static String routePath = '/addPickupAddressPage';

  @override
  ConsumerState<AddPickupAddressPageWidget> createState() =>
      _AddPickupAddressPageWidgetState();
}

class _AddPickupAddressPageWidgetState
    extends ConsumerState<AddPickupAddressPageWidget> {
  late AddPickupAddressPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddPickupAddressPageModel());

    _model.tfCityTextController ??= TextEditingController();
    _model.tfCityFocusNode ??= FocusNode();

    _model.tfAddress1TextController ??= TextEditingController();
    _model.tfAddress1FocusNode ??= FocusNode();

    _model.tfAddress2TextController ??= TextEditingController();
    _model.tfAddress2FocusNode ??= FocusNode();

    _model.tfZipTextController ??= TextEditingController();
    _model.tfZipFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(addPickupAddressPageStoreProvider);

    return storeAsync.when(
      loading: () => Scaffold(
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
      ),
      error: (e, s) => Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(child: Text('Error loading store data')),
      ),
      data: (addPickupAddressPageStoresRow) {

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
              child: SideMenuWidget(),
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 96.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _model.formKey,
                        child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 16.0, 20.0, 16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // A clickable row that's supposed to activate the "Side_Menu" component that would be used to navigate to some other pages by the user.
                                      Expanded(
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            scaffoldKey.currentState!
                                                .openDrawer();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.menu,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                              Text(
                                                'Menu',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF1C2626),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                      ),

                                      // Row containing the user's business name and their pfp or placeholder with the initial/letter avatar.
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // name
                                          Text(
                                            valueOrDefault<String>(
                                              addPickupAddressPageStoresRow
                                                  .name,
                                              'Northing Official',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
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
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Placeholder with the initial/letter avatar.
                                                Text(
                                                  functions.getInitials(
                                                      addPickupAddressPageStoresRow
                                                          .name!),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        fontSize: 10.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                              },
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.chevronLeft,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 14.0,
                                      ),
                                      Text(
                                        'Back',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'General Sans',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.33,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 0.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add pickup address',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'General Sans',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  'Add address for dispatch to come pick items',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'General Sans',
                                        color: Color(0xFF2A2525),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
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
                                  'Pickup Address',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'General Sans',
                                        color: Color(0xFF585661),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
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
                                      'Country',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF645E82),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),

                                    // Dropdown meant to show a list of countries.
                                    FlutterFlowDropDown<String>(
                                      controller:
                                          _model.tfcountryValueController ??=
                                              FormFieldController<String>(null),
                                      options: List<String>.from(['Nigeria']),
                                      optionLabels: <String>[],
                                      onChanged: (val) => safeSetState(
                                          () => _model.tfcountryValue = val),
                                      width: double.infinity,
                                      height: 53.0,
                                      searchHintTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'General Sans',
                                                letterSpacing: 0.0,
                                              ),
                                      searchTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'General Sans',
                                                letterSpacing: 0.0,
                                              ),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            letterSpacing: 0.0,
                                            lineHeight: 1.5,
                                          ),
                                      hintText: 'Select Country...',
                                      searchHintText: 'Search...',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF645E82),
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      elevation: 2.0,
                                      borderColor: Color(0xFFE1DFEC),
                                      borderWidth: 1.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: true,
                                      isMultiSelect: false,
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
                                      'State',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF645E82),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),

                                    // Dropdown meant to show a list of states in that country.
                                    FlutterFlowDropDown<String>(
                                      controller:
                                          _model.ddStateValueController ??=
                                              FormFieldController<String>(null),
                                      options: List<String>.from(['Abuja', 'Lagos', 'Kaduna', 'Kano', 'Rivers', 'Oyo', 'Enugu']),
                                      optionLabels: <String>[],
                                      onChanged: (val) => safeSetState(
                                          () => _model.ddStateValue = val),
                                      width: double.infinity,
                                      height: 53.0,
                                      searchHintTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'General Sans',
                                                letterSpacing: 0.0,
                                              ),
                                      searchTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'General Sans',
                                                letterSpacing: 0.0,
                                              ),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            letterSpacing: 0.0,
                                            lineHeight: 1.5,
                                          ),
                                      hintText: 'Select State...',
                                      searchHintText: 'Search...',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF645E82),
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      elevation: 2.0,
                                      borderColor: Color(0xFFE1DFEC),
                                      borderWidth: 1.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: true,
                                      isMultiSelect: false,
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
                                      'City',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF645E82),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),

                                    // Text Field where the user would enter their city name.
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model.tfCityTextController,
                                        focusNode: _model.tfCityFocusNode,
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
                                          hintText: 'eg. Kaduna',
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
                                              color: Color(0xFFE1DFEC),
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
                                            .tfCityTextControllerValidator
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
                                      'Address Line 1',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF645E82),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),

                                    // Text Field where they user would enter their address line 1.
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.tfAddress1TextController,
                                        focusNode: _model.tfAddress1FocusNode,
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
                                          hintText:
                                              'eg. CBN Quarters, Barnawa Complex',
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
                                              color: Color(0xFFE1DFEC),
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
                                            .tfAddress1TextControllerValidator
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
                                      'Address Line 2',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF645E82),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),

                                    // Text Field where they user would enter their address line 2.
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.tfAddress2TextController,
                                        focusNode: _model.tfAddress2FocusNode,
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
                                          hintText:
                                              'eg. Congo Street, Kaduna South',
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
                                              color: Color(0xFFE1DFEC),
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
                                            .tfAddress2TextControllerValidator
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
                                      'Zip',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF645E82),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),

                                    // Text Field where they user would enter their zip code.
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model.tfZipTextController,
                                        focusNode: _model.tfZipFocusNode,
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
                                          hintText: 'eg. 123456',
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
                                              color: Color(0xFFE1DFEC),
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
                                            .tfZipTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                ),
                              ),
                            ].divide(SizedBox(height: 20.0)),
                          ),
                        ].divide(SizedBox(height: 20.0)),
                      ),
                      ),
                    ),
                  ),

                  // Button that would save all these information to the Supabase table.
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                            return;
                          }

                          
                          // 1. Insert into pickup_addresses
                          // 2. Update stores
                          
                          final store = addPickupAddressPageStoresRow;

                          try {
                            // Insert address
                            final newAddress = await PickupAddressesTable().insert({
                              'store_id': store.id,
                              'country': _model.tfcountryValue,
                              'state': _model.ddStateValue,
                              'city': _model.tfCityTextController.text,
                              'address_line1': _model.tfAddress1TextController.text,
                              'address_line2': _model.tfAddress2TextController.text,
                              'zip': _model.tfZipTextController.text,
                              'is_default': true,
                            });
                            
                            // Update store
                            await StoresTable().update(
                              data: {
                                'pickup_address_complete': true,
                                'default_pickup_address_id': newAddress.id,
                              },
                              matchingRows: (rows) => rows.eq('id', store.id),
                            );

                            if (widget.returnToOnboarding) {
                              context.pushNamed(HomeIncompleteInfoWidget.routeName);
                            } else {
                              context.pushNamed(Checkout1PageWidget.routeName);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to save address: $e'),
                              ),
                            );
                          }
                        },
                        text: 'Save',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 72.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 24.0, 32.0, 24.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'General Sans',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
