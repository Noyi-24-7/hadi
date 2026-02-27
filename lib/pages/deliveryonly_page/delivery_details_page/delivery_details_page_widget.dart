import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/side_menu/side_menu_widget.dart';
import 'delivery_details_page_model.dart';
export 'delivery_details_page_model.dart';

final deliveryDetailsPageStoreProvider = FutureProvider<StoresRow>((ref) async {
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

/// Page to see the delivery details of the product.
///
/// From the pickup address to the inbetween locations up on till the delivery
/// address.
class DeliveryDetailsPageWidget extends ConsumerStatefulWidget {
  const DeliveryDetailsPageWidget({super.key});

  static String routeName = 'Delivery_Details_Page';
  static String routePath = '/deliveryDetailsPage';

  @override
  ConsumerState<DeliveryDetailsPageWidget> createState() =>
      _DeliveryDetailsPageWidgetState();
}

class _DeliveryDetailsPageWidgetState extends ConsumerState<DeliveryDetailsPageWidget> {
  late DeliveryDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeliveryDetailsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(deliveryDetailsPageStoreProvider);

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
      data: (deliveryDetailsPageStoresRow) {

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
              child: SingleChildScrollView(
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
                                        deliveryDetailsPageStoresRow.name,
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
                                                deliveryDetailsPageStoresRow
                                                    .name!),
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
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Row(
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
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product name.
                          Text(
                            'Drake CLB Airforce 1s',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'General Sans',
                                      color: Color(0xFF131919),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),

                          // Product Price.
                          Text(
                            'N80,000',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF818686),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Price',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'General Sans',
                                      color: Color(0xFF131919),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),

                          // Delivery price.
                          Text(
                            'N8,000',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF818686),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 14.0, 20.0, 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 48.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/package.png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    // Pick up Address.
                                    Flexible(
                                      child: Text(
                                        'CBN Quarter, Wuse , Oladeiji Avenue. Abuja, Nigeria',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF667085),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/Line.png',
                                    width: 4.0,
                                    height: 40.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 48.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Location.png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    // In between location.
                                    Flexible(
                                      child: Text(
                                        'Picked up from location A',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF667085),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/Line.png',
                                    width: 4.0,
                                    height: 40.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 48.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Location.png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    // In between location.
                                    Flexible(
                                      child: Text(
                                        'Picked up from location B',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF667085),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/Line.png',
                                    width: 4.0,
                                    height: 40.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 48.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/package-delivered_green.png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    // Delivery Address.
                                    Flexible(
                                      child: Text(
                                        'NNPC Quarters, Barnawa High Cost, Barnawa Kaduna',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF667085),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Have any issues?',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'General Sans',
                                      color: Color(0xFF936817),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              // Button to contact support.
                              Align(
                                alignment: AlignmentDirectional(1.0, 1.0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Contact Support',
                                  icon: Icon(
                                    Icons.headset_mic_outlined,
                                    size: 16.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconAlignment: IconAlignment.end,
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: Colors.white,
                                    color: Color(0xFF262626),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily: 'General Sans',
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
