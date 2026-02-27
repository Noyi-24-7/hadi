import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/di.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
});

final transactionsByStoreProvider = FutureProvider.autoDispose
    .family<List<TransactionEntity>, String>((ref, storeId) async {
  final repo = ref.watch(transactionRepositoryProvider);
  final result = await repo.getTransactionsByStore(storeId);
  return result.fold((f) => throw Exception(f.message), (l) => l);
});

final payoutsByStoreProvider = FutureProvider.autoDispose
    .family<List<PayoutEntity>, String>((ref, storeId) async {
  final repo = ref.watch(transactionRepositoryProvider);
  final result = await repo.getPayoutsByStore(storeId);
  return result.fold((f) => throw Exception(f.message), (l) => l);
});
