import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/components/side_menu/side_menu_widget.dart';
import '/features/preorders/domain/entities/preorder_request.dart';
import '/features/preorders/presentation/providers/preorder_providers.dart';
import '/features/storefront/domain/entities/store_entity.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';

/// Page to show preorders: pending, requested, and tracking.
/// Also shows preorder items (products that have been preordered).
class PreordersPageWidget extends ConsumerStatefulWidget {
  const PreordersPageWidget({super.key});

  static String routeName = 'Preorders_Page';
  static String routePath = '/preordersPage';

  @override
  ConsumerState<PreordersPageWidget> createState() => _PreordersPageWidgetState();
}

class _PreordersPageWidgetState extends ConsumerState<PreordersPageWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  bool _isPreOrders = true;
  bool _isPreOrderItems = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(myStoreProvider);

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
          child: storeAsync.when(
            data: (store) {
              if (store == null) {
                return _buildError(context, 'Store not found');
              }
              return _buildContent(context, store);
            },
            loading: () => _buildLoading(context),
            error: (error, stack) => _buildError(context, error),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: SpinKitWanderingCubes(
          color: FlutterFlowTheme.of(context).primary,
          size: 50.0,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: FlutterFlowTheme.of(context).error,
            size: 60.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Failed to load store',
            style: FlutterFlowTheme.of(context).headlineSmall,
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              error.toString(),
              style: FlutterFlowTheme.of(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, StoreEntity store) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, store),
        _buildPageTitle(context),
        _buildToggleButtons(context),
        Expanded(
          child: _isPreOrders
              ? _buildPreOrdersView(context, store.id)
              : _buildPreOrderItemsView(context, store.id),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, StoreEntity store) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          const Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFEAEDED),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => scaffoldKey.currentState!.openDrawer(),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        Text(
                          'Menu',
                          style: FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF1C2626),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ].divide(const SizedBox(width: 8.0)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      store.name,
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
                        color: const Color(0xFFF5CA86),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Center(
                        child: Text(
                          functions.getInitials(store.name),
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'General Sans',
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 8.0)),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color(0xFFEAEDED),
          ),
        ],
      ),
    );
  }

  Widget _buildPageTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
      child: Text(
        'Pre-Orders',
        style: FlutterFlowTheme.of(context).titleLarge.override(
              fontFamily: 'General Sans',
              color: const Color(0xFF131919),
              letterSpacing: 0.0,
            ),
      ),
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                child: FFButtonWidget(
                  onPressed: () {
                    setState(() {
                      _isPreOrders = true;
                      _isPreOrderItems = false;
                    });
                  },
                  text: 'Pre-Orders',
                  options: FFButtonOptions(
                    height: 52.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    color: _isPreOrders ? const Color(0xFF363232) : const Color(0xFFF5F6F9),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'General Sans',
                          color: _isPreOrders ? Colors.white : const Color(0xFF363232),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Expanded(
                child: FFButtonWidget(
                  onPressed: () {
                    setState(() {
                      _isPreOrders = false;
                      _isPreOrderItems = true;
                    });
                  },
                  text: 'Pre-Order Items',
                  options: FFButtonOptions(
                    height: 52.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    color: _isPreOrderItems ? const Color(0xFF363232) : const Color(0xFFF5F6F9),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'General Sans',
                          color: _isPreOrderItems ? Colors.white : const Color(0xFF363232),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreOrdersView(BuildContext context, String storeId) {
    final preordersAsync = ref.watch(preordersByStoreProvider(storeId));

    return preordersAsync.when(
      data: (preorders) {
        final pending = preorders.where((p) => p.status == 'pending').toList();
        final requested = preorders.where((p) => p.status == 'requested').toList();
        final tracking = preorders.where((p) => p.status == 'tracking').toList();

        return Column(
          children: [
            TabBar(
              labelColor: const Color(0xFF363232),
              unselectedLabelColor: const Color(0xFF515151),
              labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'General Sans',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
              indicatorColor: const Color(0xFF666666),
              indicatorWeight: 2.0,
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 0.0),
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Requested'),
                Tab(text: 'Tracking'),
              ],
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPreorderList(context, pending, 'You do not have any pending pre-orders yet'),
                  _buildPreorderList(context, requested, 'You do not have any requested pre-orders yet'),
                  _buildPreorderList(context, tracking, 'You do not have any tracking pre-orders yet'),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => _buildLoading(context),
      error: (error, _) => _buildEmptyState(context, 'Failed to load pre-orders'),
    );
  }

  Widget _buildPreorderList(
    BuildContext context,
    List<PreorderRequest> preorders,
    String emptyMessage,
  ) {
    if (preorders.isEmpty) return _buildEmptyState(context, emptyMessage);
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      itemCount: preorders.length,
      separatorBuilder: (_, __) => const Divider(height: 1.0, color: Color(0xFFEAEDED)),
      itemBuilder: (context, index) {
        final preorder = preorders[index];
        return InkWell(
          onTap: () => context.pushNamed(
            PreordersProductDetailsPageWidget.routeName,
            queryParameters: {'preorderId': preorder.id},
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${preorder.id.substring(0, 8).toUpperCase()}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'General Sans',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.0,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Qty: ${preorder.quantity}',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'General Sans',
                              color: const Color(0xFF515151),
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _statusColor(preorder.status).withAlpha(30),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    preorder.status,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'General Sans',
                          color: _statusColor(preorder.status),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.chevron_right, color: Color(0xFF515151)),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending': return const Color(0xFFF5A623);
      case 'requested': return const Color(0xFF4A90E2);
      case 'tracking': return const Color(0xFF27AE60);
      default: return const Color(0xFF515151);
    }
  }

  Widget _buildPreOrderItemsView(BuildContext context, String storeId) {
    final preordersAsync = ref.watch(preordersByStoreProvider(storeId));
    return preordersAsync.when(
      data: (preorders) {
        if (preorders.isEmpty) {
          return _buildEmptyState(context, 'You do not have any pre-order items yet');
        }
        return _buildPreorderList(context, preorders, 'You do not have any pre-order items yet');
      },
      loading: () => _buildLoading(context),
      error: (_, __) => _buildEmptyState(context, 'You do not have any pre-order items yet'),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 128.0, 0.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/Empty_Pre-Orders.png',
                width: 220.0,
                height: 160.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            message,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF515151),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ].divide(const SizedBox(height: 32.0)),
      ),
    );
  }
}
