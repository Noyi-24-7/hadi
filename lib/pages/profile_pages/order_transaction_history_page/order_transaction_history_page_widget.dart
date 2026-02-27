import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';

import '/features/merchant_revenue/domain/entities/payout.dart';
import '/features/merchant_revenue/domain/entities/revenue_stats.dart';
import '/features/merchant_revenue/domain/entities/transaction.dart';
import '/features/merchant_revenue/presentation/providers/merchant_revenue_providers.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';

/// Page to show the users order & transaction history.
class OrderTransactionHistoryPageWidget extends ConsumerStatefulWidget {
  const OrderTransactionHistoryPageWidget({super.key});

  static String routeName = 'Order_Transaction_History_Page';
  static String routePath = '/orderTransactionHistoryPage';

  @override
  ConsumerState<OrderTransactionHistoryPageWidget> createState() =>
      _OrderTransactionHistoryPageWidgetState();
}

class _OrderTransactionHistoryPageWidgetState
    extends ConsumerState<OrderTransactionHistoryPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FormFieldController<String>? _filterController;

  @override
  void initState() {
    super.initState();

    // On page load action
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _filterController?.dispose();
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
        body: SafeArea(
          top: true,
          child: storeAsync.when(
            data: (store) => store != null
                ? _buildContent(context, store.id)
                : _buildError(context, 'Store not found'),
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

  Widget _buildContent(BuildContext context, String storeId) {
    final revenueAsync = ref.watch(revenueStatsProvider(storeId));
    final selectedFilter = _filterController?.value ?? 'all';
    final transactionsAsync = ref.watch(transactionsProvider(storeId));
    final payoutsAsync = ref.watch(payoutsProvider(storeId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        // Revenue cards section
        _buildRevenueCardsSection(context, revenueAsync),
        // Compact filter dropdown
        _buildFilterSection(context),
        // Transaction list
        Expanded(
          child: _buildTransactionList(
            context,
            selectedFilter,
            transactionsAsync,
            payoutsAsync,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                    onTap: () => context.safePop(),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 18.0,
                            ),
                            Text(
                              'Back',
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
                  ),
                ),
                Text(
                  'Order & Transaction History',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'General Sans',
                        letterSpacing: 0.0,
                        lineHeight: 1.33,
                      ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        ],
      ),
    );
  }

  Widget _buildRevenueCardsSection(
    BuildContext context,
    AsyncValue<RevenueStats> revenueAsync,
  ) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF9F7F5)),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: revenueAsync.when(
          data: (stats) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRevenueCard(
                context,
                'Total Revenue',
                'NGN ${_formatAmount(stats.totalRevenue)}',
                'assets/images/Total_Rev.png',
              ),
              _buildRevenueCard(
                context,
                'Total Items sold',
                stats.totalItemsSold.toString(),
                'assets/images/Items_Sold.png',
              ),
            ].divide(const SizedBox(height: 20.0)),
          ),
          loading: () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRevenueCard(context, 'Total Revenue', '—', 'assets/images/Total_Rev.png'),
              _buildRevenueCard(context, 'Total Items sold', '—', 'assets/images/Items_Sold.png'),
            ].divide(const SizedBox(height: 20.0)),
          ),
          error: (e, s) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRevenueCard(context, 'Total Revenue', 'NGN 0.00', 'assets/images/Total_Rev.png'),
              _buildRevenueCard(context, 'Total Items sold', '0', 'assets/images/Items_Sold.png'),
            ].divide(const SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildRevenueCard(
    BuildContext context,
    String title,
    String amount,
    String iconPath,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE1DFEC)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xCC000000),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    amount,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'General Sans',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ].divide(const SizedBox(height: 30.0)),
              ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  iconPath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 4.0),
      child: FlutterFlowDropDown<String>(
        controller: _filterController ??= FormFieldController<String>('all'),
        options: const ['all', 'payouts', 'orders'],
        optionLabels: const ['All', 'Payouts', 'Orders'],
        onChanged: (val) => setState(() {}),
        width: 143.0,
        height: 37.0,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'General Sans',
              letterSpacing: 0.0,
            ),
        hintText: 'Select...',
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
        fillColor: const Color(0xFFF9F9F9),
        elevation: 2.0,
        borderColor: const Color(0xFFE1DFEC),
        borderWidth: 0.0,
        borderRadius: 8.0,
        margin: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
        hidesUnderline: true,
        isOverButton: false,
        isSearchable: false,
        isMultiSelect: false,
      ),
    );
  }

  Widget _buildTransactionList(
    BuildContext context,
    String filter,
    AsyncValue<List<Transaction>> transactionsAsync,
    AsyncValue<List<Payout>> payoutsAsync,
  ) {
    // Combine loading states
    if (transactionsAsync.isLoading || payoutsAsync.isLoading) {
      return _buildLoading(context);
    }

    final transactions = transactionsAsync.asData?.value ?? [];
    final payouts = payoutsAsync.asData?.value ?? [];

    // Build unified list entries sorted by date
    final List<_HistoryItem> items = [];

    if (filter == 'all' || filter == 'orders') {
      for (final t in transactions) {
        items.add(_HistoryItem(
          isTransaction: true,
          transaction: t,
          date: t.createdAt,
        ));
      }
    }

    if (filter == 'all' || filter == 'payouts') {
      for (final p in payouts) {
        items.add(_HistoryItem(
          isTransaction: false,
          payout: p,
          date: p.initiatedAt,
        ));
      }
    }

    // Sort by date descending
    items.sort((a, b) => b.date.compareTo(a.date));

    if (items.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
      itemBuilder: (context, index) {
        final item = items[index];
        if (item.isTransaction && item.transaction != null) {
          return _buildTransactionCard(context, item.transaction!);
        } else if (!item.isTransaction && item.payout != null) {
          return _buildPayoutCard(context, item.payout!);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTransactionCard(BuildContext context, Transaction t) {
    final iconPath = t.type == 'order_payment'
        ? 'assets/images/Payment.png'
        : 'assets/images/Payout.png';
    final label = t.type == 'order_payment'
        ? 'Payment for order'
        : t.type.replaceAll('_', ' ');
    final dateStr = DateFormat('MMM d, y').format(t.createdAt);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: const Color(0x0C0D0D0D)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(iconPath, fit: BoxFit.contain),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'General Sans',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    dateStr,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xFF8D8D8D),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ].divide(const SizedBox(height: 4.0)),
              ),
            ),
            Text(
              '${t.currency} ${_formatAmount(t.amount)}',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'General Sans',
                    color: const Color(0xFF5F5F5F),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ].divide(const SizedBox(width: 5.0)),
        ),
      ),
    );
  }

  Widget _buildPayoutCard(BuildContext context, Payout p) {
    final dateStr = DateFormat('MMM d, y').format(p.initiatedAt);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: const Color(0x0C0D0D0D)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/Payout.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payout${p.provider != null ? ' via ${p.provider}' : ''}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'General Sans',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    dateStr,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xFF8D8D8D),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ].divide(const SizedBox(height: 4.0)),
              ),
            ),
            Text(
              '${p.currency} ${_formatAmount(p.amount)}',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'General Sans',
                    color: const Color(0xFF5F5F5F),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ].divide(const SizedBox(width: 5.0)),
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
            Icons.receipt_long_outlined,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 80.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            'No transaction history yet',
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
              'Your orders and transactions will appear here',
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

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(amount);
  }
}

/// Helper class to unify transactions and payouts in a single sortable list.
class _HistoryItem {
  const _HistoryItem({
    required this.isTransaction,
    required this.date,
    this.transaction,
    this.payout,
  });

  final bool isTransaction;
  final DateTime date;
  final Transaction? transaction;
  final Payout? payout;
}
