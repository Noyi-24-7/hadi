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
import 'preorders_product_details_page_model.dart';
export 'preorders_product_details_page_model.dart';

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

/// Page showing the details of the preordered item.
class PreordersProductDetailsPageWidget extends ConsumerStatefulWidget {
  const PreordersProductDetailsPageWidget({super.key});

  static String routeName = 'Preorders_Product_Details_Page';
  static String routePath = '/preordersProductDetailsPage';

  @override
  ConsumerState<PreordersProductDetailsPageWidget> createState() =>
      _PreordersProductDetailsPageWidgetState();
}

class _PreordersProductDetailsPageWidgetState
    extends ConsumerState<PreordersProductDetailsPageWidget> {
  late PreordersProductDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PreordersProductDetailsPageModel());
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, store),
                _buildBackAndEditRow(context),
                _buildProductLinkSection(context),
                _buildProductDetailsPlaceholder(context),
              ],
            ),
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
          Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
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
                              letterSpacing: 0.0,
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
                      child: Center(
                        child: Text(
                          functions.getInitials(store.name!),
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'General Sans',
                                fontSize: 10.0,
                                letterSpacing: 0.0,
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
      ),
    );
  }

  Widget _buildBackAndEditRow(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
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
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
            ),
          ),
          FFButtonWidget(
            onPressed: () {
              // TODO: Implement edit functionality
            },
            text: 'Edit',
            icon: Icon(Icons.edit_outlined, size: 16.0),
            options: FFButtonOptions(
              height: 32.0,
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
              color: Color(0x19918D8D),
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'General Sans',
                    color: Color(0xFF171719),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
              elevation: 0.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ]
            .addToStart(SizedBox(width: 20.0))
            .addToEnd(SizedBox(width: 20.0)),
      ),
    );
  }

  Widget _buildProductLinkSection(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Link',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: Color(0xFF2A3535),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFBFBF9),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 16.0, 10.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'https://hadi.northing.shop/northingofficial',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'General Sans',
                          color: Color(0xFF797979),
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      // TODO: Implement copy functionality
                    },
                    text: 'Copy',
                    options: FFButtonOptions(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
                      color: Color(0xFFF4F0E7),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFF2A3535),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildProductDetailsPlaceholder(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'Product details will be loaded here',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'TODO: Implement product details fetching and display',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
