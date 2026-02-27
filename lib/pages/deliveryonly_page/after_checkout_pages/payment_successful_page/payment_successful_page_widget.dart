import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/side_menu/side_menu_widget.dart';
import 'payment_successful_page_model.dart';
export 'payment_successful_page_model.dart';

final paymentSuccessfulPageStoreProvider = FutureProvider<StoresRow>((ref) async {
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

/// Page to show when the payment is successful.
class PaymentSuccessfulPageWidget extends ConsumerStatefulWidget {
  const PaymentSuccessfulPageWidget({super.key});

  static String routeName = 'Payment_Successful_Page';
  static String routePath = '/paymentSuccessfulPage';

  @override
  ConsumerState<PaymentSuccessfulPageWidget> createState() =>
      _PaymentSuccessfulPageWidgetState();
}

class _PaymentSuccessfulPageWidgetState
    extends ConsumerState<PaymentSuccessfulPageWidget> {
  late PaymentSuccessfulPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentSuccessfulPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(paymentSuccessfulPageStoreProvider);

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
      data: (paymentSuccessfulPageStoresRow) {

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
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                                      paymentSuccessfulPageStoresRow.name,
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
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Placeholder with the initial/letter avatar.
                                        Text(
                                          functions.getInitials(
                                              paymentSuccessfulPageStoresRow
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
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/ri-checkbox-circle-fill.png',
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          'Payment successful',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF131919),
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F9FB),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Hey ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      'Osamudiamen ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'check your email for ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'tracking and delivery details.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '(Check your spam',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'folder if you cannot find it)',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Send an email to ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'support@hadi.africa ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF1DA79F),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'if you ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'have any issues. Include your order number.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: Color(0x16000000),
                            ),
                            Text(
                              'Order No: 132492 ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF131919),
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFF3F3A57),
                          size: 16.0,
                        ),
                        Text(
                          'The invoice link has your order number',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF3F3A57),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ),

                  // Button to navigate back to checkout.
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Return to Checkout',
                    options: FFButtonOptions(
                      height: 46.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconAlignment: IconAlignment.end,
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.white,
                      textStyle:
                          FlutterFlowTheme.of(context).labelSmall.override(
                                fontFamily: 'General Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
