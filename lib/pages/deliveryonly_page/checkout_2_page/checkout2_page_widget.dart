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
import '../../../../features/shipping/presentation/providers/shipping_providers.dart';

import '../../../../features/delivery_tickets/presentation/providers/delivery_ticket_providers.dart';
import 'checkout2_page_model.dart';
export 'checkout2_page_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '/index.dart';
import '/pages/home_main/home_main_widget.dart';

final checkout2PageStoreProvider = FutureProvider<StoresRow>((ref) async {
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

/// Page to verify everything about the delivery and contact details.
///
/// the options to select a delivery option, should link to Terminal I
/// believe.
class Checkout2PageWidget extends ConsumerStatefulWidget {
  const Checkout2PageWidget({super.key});

  static String routeName = 'Checkout_2_Page';
  static String routePath = '/checkout2Page';

  @override
  ConsumerState<Checkout2PageWidget> createState() => _Checkout2PageWidgetState();
}

class _Checkout2PageWidgetState extends ConsumerState<Checkout2PageWidget> {
  late Checkout2PageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Checkout2PageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(checkout2PageStoreProvider);
    final session = ref.watch(checkoutSessionProvider);

    final pickupMap = {
      'address': session.pickupAddress,
      'city': session.pickupCity,
      'state': session.pickupState,
      'country': session.pickupCountry,
    };
    final deliveryMap = {
      'address': session.deliveryAddress,
      'state': session.state,
      'lga': session.lga,
      'country': session.country,
    };
    final packageMap = {
      'weight': session.itemWeight,
      'value': session.itemValue,
    };

    final quotesAsync = ref.watch(deliveryQuotesProvider(
      DeliveryQuotesParams(
        pickupAddress: pickupMap,
        deliveryAddress: deliveryMap,
        package: packageMap,
      ),
    ));

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
      data: (checkout2PageStoresRow) {


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
                fit: StackFit.expand,
                children: [
                  Column(
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
                                        scaffoldKey.currentState!.openDrawer();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.menu,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
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

                                  // Row containing the user's business name and their pfp or placeholder with the initial/letter avatar.
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // name
                                      Text(
                                        valueOrDefault<String>(
                                          checkout2PageStoresRow.name,
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
                                                  checkout2PageStoresRow
                                                      .name!),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
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
                        ]
                            .addToStart(SizedBox(width: 20.0))
                            .addToEnd(SizedBox(width: 20.0)),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Checkout',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF131919),
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF8F7F7),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 16.0, 20.0, 16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ITEM',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF818181),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          Text(
                                            'PRICE',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF818181),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 20.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://picsum.photos/seed/436/600',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 151.0,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            session.itemName.isNotEmpty ? session.itemName : 'Item Name',
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'General Sans',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Quantity: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'General Sans',
                                                                  color: Color(
                                                                      0xFF82818D),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                      FlutterFlowDropDown<
                                                          String>(
                                                        controller: _model
                                                                .dropDownValueController ??=
                                                            FormFieldController<
                                                                String>(
                                                          _model.dropDownValue ??=
                                                              '',
                                                        ),
                                                        options:
                                                            List<String>.generate(
                                                              10, (i) => '${i + 1}'),
                                                        optionLabels:
                                                            List<String>.generate(
                                                              10, (i) => '${i + 1}'),
                                                        onChanged: (val) =>
                                                            safeSetState(() =>
                                                                _model.dropDownValue =
                                                                    val),
                                                        width: 36.0,
                                                        height: 22.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'General Sans',
                                                                  color: Color(
                                                                      0xFF82818D),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                        hintText: '${session.itemQuantity}',
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color:
                                                              Color(0xFF82818D),
                                                          size: 24.0,
                                                        ),
                                                        elevation: 2.0,
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderWidth: 0.0,
                                                        borderRadius: 8.0,
                                                        margin:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        hidesUnderline: true,
                                                        isOverButton: false,
                                                        isSearchable: false,
                                                        isMultiSelect: false,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      formatNumber(
                                                        session.itemValue,
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
                                                        currency: 'NGN ',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Color(
                                                                0xFF3F3A57),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'per unit',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Color(
                                                                0xFF82818D),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ].divide(SizedBox(height: 2.0)),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Divider(
                                              height: 1.0,
                                              thickness: 1.0,
                                              color: Color(0xFFF4F5F5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF8F7F7),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 8.0, 20.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1CA888),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(9.0, 6.0, 9.0, 6.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'TOTAL',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            formatNumber(
                                              (session.itemValue * session.itemQuantity),
                                              formatType: FormatType.decimal,
                                              decimalType: DecimalType.automatic,
                                              currency: 'NGN ',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF818181),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F7F7),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'PICK UP ADDRESS',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF3F3A57),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF3F3F3),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color(0xFFE1DFEC),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 20.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '${session.pickupAddress}\n${session.pickupCity}, ${session.pickupState}\n${session.pickupCountry}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF3F3A57),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Button to edit the pick up address. Would activate the "Select_Address_Bottom_Sheet" bottom sheet so they can select the address they want, or add another address.
                                      FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text: 'Edit',
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          size: 16.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 32.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 4.0, 8.0, 4.0),
                                          iconAlignment: IconAlignment.end,
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFFF3F3F3),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF171719),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.0,
                                                  ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'CONTACT & DELIVERY DETAILS',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'General Sans',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF3F3F3),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color(0xFFE1DFEC),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/user-verified-square(24x24)@1x_(1)_4.png',
                                                          width: 24.0,
                                                          height: 24.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      session.buyerName.isNotEmpty ? session.buyerName : 'Guest',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Color(
                                                                0xFF1B1A23),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      session.buyerPhoneNumber.isNotEmpty ? session.buyerPhoneNumber : 'No phone',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Color(
                                                                0xFF82818D),
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 2.0)),
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/compass(24x24)@1x_1.png',
                                                          width: 24.0,
                                                          height: 24.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Delivery Address',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Color(
                                                                0xFF1B1A23),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      '${session.deliveryAddress}\n${session.lga}, ${session.state}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Color(
                                                                0xFF82818D),
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 2.0)),
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),

                                      // Button that routes them back to "Checkout_1_Page" page so they can change or edit the contact and delivery information.
                                      FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text: 'Edit',
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          size: 16.0,
                                        ),
                                        options: FFButtonOptions(
                                          width: 71.0,
                                          height: 32.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 4.0, 8.0, 4.0),
                                          iconAlignment: IconAlignment.end,
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFFF3F3F3),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF171719),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.0,
                                                  ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SELECT DELIVERY OPTION',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'General Sans',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'High-Priority Shipping (3 working days)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF6E6A82),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text(
                                          'Delivery by July 24th',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF188E73),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),

                              // Dynamic Delivery Quotes
                              quotesAsync.when(
                                loading: () => Center(child: CircularProgressIndicator()),
                                error: (e, s) => Text('Error loading quotes: $e'),
                                data: (quotes) {
                                  if (quotes.isEmpty) {
                                    return Text('No delivery quotes available.');
                                  }
                                  return Column(
                                    children: quotes.map((quote) {
                                      final isSelected = session.selectedDeliveryQuote?.id == quote.id;
                                      return InkWell(
                                        onTap: () {
                                          ref.read(checkoutSessionProvider.notifier).selectDeliveryQuote(quote);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: isSelected ? Color(0xFFF8FCFB) : Colors.white,
                                            borderRadius: BorderRadius.circular(16.0),
                                            border: Border.all(
                                              color: isSelected ? Color(0xFF188E73) : Color(0xFFEAEDED),
                                              width: isSelected ? 2.0 : 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        quote.providerName,
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'General Sans',
                                                          color: Color(0xFF434343),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        quote.serviceLevel,
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'General Sans',
                                                          color: Color(0xFF434343),
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                      Text(
                                                        quote.etaText ?? 'N/A',
                                                        style: FlutterFlowTheme.of(context).bodySmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    if (isSelected)
                                                      Icon(Icons.check_circle, color: Color(0xFF1CA888), size: 24),
                                                    if (!isSelected)
                                                      Icon(Icons.radio_button_unchecked, color: Color(0xFFD2D4D4), size: 24),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      formatNumber(
                                                        quote.priceAmount,
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
                                                        currency: 'NGN ',
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                        fontFamily: 'General Sans',
                                                        color: Color(0xFF3F3A57),
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList().divide(SizedBox(height: 8.0)),
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'AMOUNT BREAKDOWN',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'General Sans',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              // Amount breakdown card
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1D2323),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 24.0, 20.0, 24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 16.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Product Price',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'General Sans',
                                                              color: Color(
                                                                  0xFFDBDBDB),
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              // Product price
                                                Text(
                                                  formatNumber(
                                                    (session.itemValue * session.itemQuantity),
                                                    formatType: FormatType.decimal,
                                                    decimalType: DecimalType.automatic,
                                                    currency: 'NGN ',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                ),
                                            ],
                                          ),
                                        ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 16.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Delivery Fee',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'General Sans',
                                                              color: Color(
                                                                  0xFFDBDBDB),
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              // The delivery fee.
                                                Text(
                                                  session.selectedDeliveryQuote != null
                                                      ? formatNumber(
                                                          session.selectedDeliveryQuote!.priceAmount.toDouble(),
                                                          formatType: FormatType.decimal,
                                                          decimalType: DecimalType.automatic,
                                                          currency: 'NGN ',
                                                        )
                                                      : 'Select Quote',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                ),
                                            ],
                                          ),
                                        ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 16.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Transaction Fee',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'General Sans',
                                                              color: Color(
                                                                  0xFFDBDBDB),
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              // The transaction fee.
                                              Text(
                                                'NGN 150.00',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 16.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF1CA888),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      9.0,
                                                                      6.0,
                                                                      9.0,
                                                                      6.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                'TOTAL',
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'General Sans',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // The total amount and price for this product's delivery to the destination.
                                                Text(
                                                  formatNumber(
                                                    (session.itemValue * session.itemQuantity) + (session.selectedDeliveryQuote?.priceAmount ?? 0) + 150.0,
                                                    formatType: FormatType.decimal,
                                                    decimalType: DecimalType.automatic,
                                                    currency: 'NGN ',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                                .cast<Widget>()
                                .divide(SizedBox(height: 16.0))
                                .addToEnd(SizedBox(height: 120.0)),
                          ),
                        ),

                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),

                  // Button to place your order. They would be prompted to make the payment to and after words, Terminal initialtes the delivery process and starts showing the information about the product's delivery journey.
                  //
                  // After payment is successful they navigate to "Payment_Successful_Page".
                  //
                  // If shipment fails then navigate to "Shipment_Not_Created_Page".
                  //
                  // If payment fails or is cancelled navigate to "Payment_Cancelled_Page".
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (session.selectedDeliveryQuote == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select a delivery quote')),
                            );
                            return;
                          }

                          final result = await ref.read(createDeliveryTicketProvider).call(
                            storeId: checkout2PageStoresRow.id,
                            pickup: {
                              'address': session.pickupAddress,
                              'city': session.pickupCity,
                              'state': session.pickupState,
                              'country': session.pickupCountry,
                            },
                            dropoff: {
                              'name': session.buyerName,
                              'email': session.buyerEmail,
                              'phone': session.buyerPhoneNumber,
                              'address': session.deliveryAddress,
                              'state': session.state,
                              'lga': session.lga,
                              'country': session.country,
                            },
                            items: [
                              {
                                'name': session.itemName,
                                'val': session.itemValue,
                                'qty': session.itemQuantity,
                                'weight': session.itemWeight,
                              }
                            ],
                            selectedQuoteId: session.selectedDeliveryQuote!.id,
                            deliveryPrice: session.selectedDeliveryQuote!.priceAmount.toDouble(),
                          );

                          result.fold(
                            (failure) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error creating ticket: ${failure.message}')),
                            ),
                            (ticketResult) async {
                              // Launch Safe Haven payment URL in the device browser.
                              final uri = Uri.tryParse(ticketResult.paymentUrl);
                              if (uri != null && await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                                // After returning from payment, navigate to the
                                // success page. Webhook will update order status
                                // server-side; the page polls or shows confirmation.
                                if (context.mounted) {
                                  context.pushNamed(PaymentSuccessfulPageWidget.routeName);
                                }
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Could not open payment page. URL: ${ticketResult.paymentUrl}',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                        text: 'Place your order',
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
