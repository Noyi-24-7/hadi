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
import '/components/side_menu/side_menu_widget.dart';
import '../../../features/orders/presentation/providers/checkout_provider.dart';
import 'checkout1_page_model.dart';
export 'checkout1_page_model.dart';

final checkout1PageStoreProvider = FutureProvider<StoresRow>((ref) async {
  // MOCK DATA FOR UI AUDIT
  await Future.delayed(const Duration(milliseconds: 500));
  return StoresRow({
    'id': 'store-123',
    'owner_id': 'mock-user-id',
    'name': 'Mock Store',
    'slug': 'mock-store',
    'is_active': true,
    'created_at': DateTime.now().toIso8601String(),
    'business_info_complete': true,
    'bank_complete': true,
    'pickup_address_complete': true,
    'storefront_setup_complete': true,
    'onboarding_complete': true,
  });
});

/// 1st page when users want to checkout, they'll just confirm all their
/// information, and fill some others.
class Checkout1PageWidget extends ConsumerStatefulWidget {
  const Checkout1PageWidget({super.key});

  static String routeName = 'Checkout_1_Page';
  static String routePath = '/checkout1Page';

  @override
  ConsumerState<Checkout1PageWidget> createState() => _Checkout1PageWidgetState();
}

class _Checkout1PageWidgetState extends ConsumerState<Checkout1PageWidget> {
  late Checkout1PageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Checkout1PageModel());

    _model.tfBuyerNameTextController ??= TextEditingController();
    _model.tfBuyerNameFocusNode ??= FocusNode();

    _model.tfBuyerNumberTextController ??= TextEditingController();
    _model.tfBuyerNumberFocusNode ??= FocusNode();

    _model.tfBuyerEmailTextController ??= TextEditingController();
    _model.tfBuyerEmailFocusNode ??= FocusNode();

    _model.tfAddressTextController ??= TextEditingController();
    _model.tfAddressFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(checkout1PageStoreProvider);
    final session = ref.watch(checkoutSessionProvider);

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
      data: (checkout1PageStoresRow) {

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
                  Form(
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
                                          checkout1PageStoresRow.name,
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
                                                  checkout1PageStoresRow
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
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
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
                                                          // Product name
                                                          Flexible(
                                                            child: Text(
                                                              session.itemName,
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

                                                      Text(
                                                        session.itemQuantity.toString(),
                                                        style: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'General Sans',
                                                              color: Color(0xFF1B1A23),
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
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
                                                    // Individual product price.
                                                    Text(
                                                      formatNumber(
                                                        session.itemValue,
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
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
                                                    // Total price with taking the quantity into account.
                                                    Text(
                                                      formatNumber(
                                                        session.itemValue * session.itemQuantity,
                                                        formatType: FormatType.decimal,
                                                        decimalType: DecimalType.automatic,
                                                      ),
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

                                          // Total price with taking the quantity into account.
                                          Text(
                                            formatNumber(
                                              session.itemValue * session.itemQuantity,
                                              formatType: FormatType.custom,
                                              currency: 'NGN ',
                                              decimalType: DecimalType.automatic,
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
                                            // Pickup address.
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
                                          'PROVIDE DELIVERY DETAILS',
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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Contact Details',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        color:
                                                            Color(0xFF585661),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF4F4F4),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.chevronUp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 6.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Full Name*',
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

                                        // The name of the buyer.
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model
                                                .tfBuyerNameTextController,
                                            focusNode:
                                                _model.tfBuyerNameFocusNode,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'eg. John Doe',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 20.0),
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
                                                .tfBuyerNameTextControllerValidator
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone Number*',
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

                                        // The buyer's phone number.
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model
                                                .tfBuyerNumberTextController,
                                            focusNode:
                                                _model.tfBuyerNumberFocusNode,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'eg. 09030086526',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 20.0),
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
                                                .tfBuyerNumberTextControllerValidator
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
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

                                        // The buyer's email.
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model
                                                .tfBuyerEmailTextController,
                                            focusNode:
                                                _model.tfBuyerEmailFocusNode,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'eg. johndoe@gmail.com',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 20.0),
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
                                                .tfBuyerEmailTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Delivery Details',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        color:
                                                            Color(0xFF585661),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF4F4F4),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.chevronUp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 6.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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

                                        // Dropdown where users can select the buyer's country.
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .ddcountryValueController ??=
                                              FormFieldController<String>(null),
                                          options:
                                              List<String>.from(<String>[]),
                                          optionLabels: <String>[],
                                          onChanged: (val) => safeSetState(() =>
                                              _model.ddcountryValue = val),
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
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                  ),
                                          hintText: 'Select Category...',
                                          searchHintText: 'Search...',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xFF645E82),
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          elevation: 2.0,
                                          borderColor: Color(0xFFE1DFEC),
                                          borderWidth: 1.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                        20.0, 0.0, 20.0, 6.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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

                                        // Dropdown so users can select the buyer's state.
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .ddstateValueController ??=
                                              FormFieldController<String>(null),
                                          options:
                                              List<String>.from(<String>[]),
                                          optionLabels: <String>[],
                                          onChanged: (val) => safeSetState(
                                              () => _model.ddstateValue = val),
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
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                  ),
                                          hintText: 'Select Category...',
                                          searchHintText: 'Search...',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xFF645E82),
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          elevation: 2.0,
                                          borderColor: Color(0xFFE1DFEC),
                                          borderWidth: 1.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                        20.0, 0.0, 20.0, 6.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Local Government Area',
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

                                        // Dropdown so they can select the buyer's LGA.
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .tflgaValueController ??=
                                              FormFieldController<String>(null),
                                          options:
                                              List<String>.from(<String>[]),
                                          optionLabels: <String>[],
                                          onChanged: (val) => safeSetState(
                                              () => _model.tflgaValue = val),
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
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.5,
                                                  ),
                                          hintText: 'Select Category...',
                                          searchHintText: 'Search...',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xFF645E82),
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          elevation: 2.0,
                                          borderColor: Color(0xFFE1DFEC),
                                          borderWidth: 1.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address',
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

                                        // Textfield so users can enter the delivery location.
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.tfAddressTextController,
                                            focusNode:
                                                _model.tfAddressFocusNode,
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText:
                                                  'eg. No.3 NNPC Quarters, Barnawa High-Cost. Zambia Street.',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 20.0),
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
                                            maxLines: null,
                                            minLines: 4,
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .tfAddressTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              ),
                            ]
                                .divide(SizedBox(height: 16.0))
                                .addToEnd(SizedBox(height: 120.0)),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                  ),

                  // Button to continue, all this information is saved.
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

                          ref.read(checkoutSessionProvider.notifier).updateBuyerInfo(
                                name: _model.tfBuyerNameTextController?.text,
                                email: _model.tfBuyerEmailTextController?.text,
                                phoneNumber: _model.tfBuyerNumberTextController?.text,
                              );

                          ref.read(checkoutSessionProvider.notifier).updateDeliveryAddress(
                                address: _model.tfAddressTextController?.text,
                                state: _model.ddstateValue,
                                lga: _model.tflgaValue,
                                country: _model.ddcountryValue,
                              );

                          context.pushNamed(Checkout2PageWidget.routeName);
                        },
                        text: 'Continue',
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
