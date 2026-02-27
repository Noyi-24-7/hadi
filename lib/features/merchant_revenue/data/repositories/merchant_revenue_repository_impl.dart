import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/payout.dart';
import '../../domain/entities/revenue_stats.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/merchant_revenue_repository.dart';
import '../datasources/merchant_revenue_remote_data_source.dart';

class MerchantRevenueRepositoryImpl implements MerchantRevenueRepository {
  MerchantRevenueRepositoryImpl({
    required MerchantRevenueRemoteDataSource remote,
  }) : _remote = remote;

  final MerchantRevenueRemoteDataSource _remote;

  @override
  Future<Either<Failure, RevenueStats>> getRevenueStats(
    String storeId,
  ) async {
    try {
      final stats = await _remote.getRevenueStats(storeId);
      return right(
        RevenueStats(
          totalRevenue: stats['total_revenue'] as double,
          totalItemsSold: stats['total_items_sold'] as int,
          currency: stats['currency'] as String,
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions({
    required String storeId,
    String? type,
  }) async {
    try {
      final models = await _remote.getTransactions(
        storeId: storeId,
        type: type,
      );
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Payout>>> getPayouts(String storeId) async {
    try {
      final models = await _remote.getPayouts(storeId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
