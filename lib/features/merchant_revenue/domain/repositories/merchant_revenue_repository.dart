import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/payout.dart';
import '../entities/revenue_stats.dart';
import '../entities/transaction.dart';

abstract class MerchantRevenueRepository {
  Future<Either<Failure, RevenueStats>> getRevenueStats(String storeId);

  Future<Either<Failure, List<Transaction>>> getTransactions({
    required String storeId,
    String? type,
  });

  Future<Either<Failure, List<Payout>>> getPayouts(String storeId);
}
