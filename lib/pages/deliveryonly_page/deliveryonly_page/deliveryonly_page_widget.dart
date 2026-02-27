import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/components/side_menu/side_menu_widget.dart';
import '/features/storefront/domain/entities/store_entity.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/features/delivery_tickets/presentation/providers/delivery_ticket_providers.dart';
import '/features/delivery_tickets/domain/entities/delivery_ticket.dart';
import '/index.dart';


/// Page showing all the products that are under ongoing delivery or have been
/// delivered.
class DeliveryonlyPageWidget extends ConsumerStatefulWidget {
  const DeliveryonlyPageWidget({super.key});

  static String routeName = 'Deliveryonly_Page';
  static String routePath = '/deliveryonlyPage';

  @override
  ConsumerState<DeliveryonlyPageWidget> createState() =>
      _DeliveryonlyPageWidgetState();
}

class _DeliveryonlyPageWidgetState
    extends ConsumerState<DeliveryonlyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showOngoing = true;

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.pushNamed(CreateDeliveryTicketPageWidget.routeName),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            'Create Ticket',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'General Sans',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: storeAsync.when(
            data: (store) {
              if (store == null) return _buildError(context, 'Store not found');
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
            'Failed to load data',
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
    final ticketsAsync = ref.watch(deliveryTicketsByStoreProvider(store.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, store),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
          child: Text(
            'Delivery',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF131919),
                  letterSpacing: 0.0,
                ),
          ),
        ),
        _buildToggleButtons(context),
        Expanded(
          child: ticketsAsync.when(
            data: (tickets) {
              final filtered = _filterTickets(tickets);
              if (filtered.isEmpty) return _buildEmptyState(context);
              return _buildTicketList(context, filtered);
            },
            loading: () => _buildLoading(context),
            error: (error, stack) => _buildEmptyState(context),
          ),
        ),
      ],
    );
  }

  List<DeliveryTicket> _filterTickets(List<DeliveryTicket> tickets) {
    if (_showOngoing) {
      // Ongoing: pending payment, paid, or shipment created but not yet delivered
      return tickets.where((t) {
        final s = t.status?.toLowerCase() ?? '';
        return s == 'pending_payment' || s == 'paid' || s == 'shipment_created' || s.isEmpty;
      }).toList();
    } else {
      // Completed: delivered or cancelled
      return tickets.where((t) {
        final s = t.status?.toLowerCase() ?? '';
        return s == 'delivered' || s == 'cancelled' || s == 'payment_failed';
      }).toList();
    }
  }

  Widget _buildTicketList(BuildContext context, List<DeliveryTicket> tickets) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: tickets.length,
      separatorBuilder: (_, __) => const Divider(height: 1.0, color: Color(0xFFEAEDED)),
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return InkWell(
          onTap: () => context.pushNamed(DeliveryDetailsPageWidget.routeName),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
            child: Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.local_shipping_outlined,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ticket #${ticket.id.substring(0, 8).toUpperCase()}',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'General Sans',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.0,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        _statusLabel(ticket.status),
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'General Sans',
                              color: _statusColor(context, ticket.status),
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _statusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending_payment':
        return 'Awaiting payment';
      case 'paid':
        return 'Payment confirmed';
      case 'shipment_created':
        return 'Shipment in progress';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      case 'payment_failed':
        return 'Payment failed';
      default:
        return 'Pending';
    }
  }

  Color _statusColor(BuildContext context, String? status) {
    switch (status?.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'cancelled':
      case 'payment_failed':
        return FlutterFlowTheme.of(context).error;
      default:
        return FlutterFlowTheme.of(context).primary;
    }
  }

  Widget _buildHeader(BuildContext context, StoreEntity store) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
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
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        ],
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
                      _showOngoing = true;
                    });
                  },
                  text: 'Ongoing',
                  options: FFButtonOptions(
                    height: 52.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    color: _showOngoing ? Colors.white : const Color(0xFFF5F6F9),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xFF383838),
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
                      _showOngoing = false;
                    });
                  },
                  text: 'Completed',
                  options: FFButtonOptions(
                    height: 52.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    color: !_showOngoing ? Colors.white : const Color(0xFFF5F6F9),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xFF383838),
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_shipping_outlined,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 80.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            _showOngoing ? 'No ongoing deliveries' : 'No completed deliveries',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Your delivery information will appear here',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'General Sans',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
