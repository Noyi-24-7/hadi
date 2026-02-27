import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/di.dart';
import '../../data/datasources/merchant_revenue_remote_data_source.dart';
import '../../data/datasources/merchant_revenue_remote_data_source_impl.dart';
import '../../data/repositories/merchant_revenue_repository_impl.dart';
import '../../domain/entities/payout.dart';
import '../../domain/entities/revenue_stats.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/merchant_revenue_repository.dart';
import '../../domain/usecases/get_payouts.dart';
import '../../domain/usecases/get_revenue_stats.dart';
import '../../domain/usecases/get_transactions.dart';

part 'merchant_revenue_providers.g.dart';

// Infrastructure
@riverpod
MerchantRevenueRemoteDataSource merchantRevenueRemoteDataSource(
  MerchantRevenueRemoteDataSourceRef ref,
) {
  return MerchantRevenueRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
MerchantRevenueRepository merchantRevenueRepository(
  MerchantRevenueRepositoryRef ref,
) {
  return MerchantRevenueRepositoryImpl(
    remote: ref.watch(merchantRevenueRemoteDataSourceProvider),
  );
}

// Use Cases
@riverpod
GetRevenueStats getRevenueStats(GetRevenueStatsRef ref) {
  return GetRevenueStats(ref.watch(merchantRevenueRepositoryProvider));
}

@riverpod
GetTransactions getTransactions(GetTransactionsRef ref) {
  return GetTransactions(ref.watch(merchantRevenueRepositoryProvider));
}

@riverpod
GetPayouts getPayouts(GetPayoutsRef ref) {
  return GetPayouts(ref.watch(merchantRevenueRepositoryProvider));
}

// Data Providers
@riverpod
Future<RevenueStats> revenueStats(
  RevenueStatsRef ref,
  String storeId,
) async {
  final result = await ref.watch(getRevenueStatsProvider).call(storeId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (stats) => stats,
  );
}

@riverpod
Future<List<Transaction>> transactions(
  TransactionsRef ref,
  String storeId, {
  String? type,
}) async {
  final result = await ref
      .watch(getTransactionsProvider)
      .call(storeId: storeId, type: type);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (transactions) => transactions,
  );
}

@riverpod
Future<List<Payout>> payouts(
  PayoutsRef ref,
  String storeId,
) async {
  final result = await ref.watch(getPayoutsProvider).call(storeId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (payouts) => payouts,
  );
}
