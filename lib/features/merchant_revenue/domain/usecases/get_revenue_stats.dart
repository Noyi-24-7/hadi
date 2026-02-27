import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/revenue_stats.dart';
import '../repositories/merchant_revenue_repository.dart';

class GetRevenueStats {
  const GetRevenueStats(this._repository);

  final MerchantRevenueRepository _repository;

  Future<Either<Failure, RevenueStats>> call(String storeId) {
    return _repository.getRevenueStats(storeId);
  }
}
