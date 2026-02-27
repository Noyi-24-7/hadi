import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByStore(
    String storeId,
  ) async {
    try {
      final res = await _supabase
          .from('transactions')
          .select()
          .eq('store_id', storeId)
          .order('created_at', ascending: false);
      final list = res as List<dynamic>;
      return right(
        list.map((e) => _transactionFromJson(e as Map<String, dynamic>)).toList(),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PayoutEntity>>> getPayoutsByStore(
    String storeId,
  ) async {
    try {
      final res = await _supabase
          .from('payouts')
          .select()
          .eq('store_id', storeId)
          .order('initiated_at', ascending: false);
      final list = res as List<dynamic>;
      return right(
        list.map((e) => _payoutFromJson(e as Map<String, dynamic>)).toList(),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  TransactionEntity _transactionFromJson(Map<String, dynamic> e) =>
      TransactionEntity(
        id: e['id'] as String,
        storeId: e['store_id'] as String?,
        orderId: e['order_id'] as String?,
        type: e['type'] as String,
        amount: (e['amount'] as num).toDouble(),
        currency: e['currency'] as String? ?? 'NGN',
        provider: e['provider'] as String?,
        reference: e['reference'] as String?,
        status: e['status'] as String,
        createdAt: e['created_at'] != null
            ? DateTime.parse(e['created_at'] as String)
            : null,
      );

  PayoutEntity _payoutFromJson(Map<String, dynamic> e) => PayoutEntity(
        id: e['id'] as String,
        storeId: e['store_id'] as String,
        amount: (e['amount'] as num).toDouble(),
        currency: e['currency'] as String? ?? 'NGN',
        provider: e['provider'] as String?,
        safehavenReference: e['safehaven_reference'] as String?,
        status: e['status'] as String,
        initiatedAt: e['initiated_at'] != null
            ? DateTime.parse(e['initiated_at'] as String)
            : null,
        paidAt: e['paid_at'] != null
            ? DateTime.parse(e['paid_at'] as String)
            : null,
      );
}
