import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/payout.dart';
import '../repositories/merchant_revenue_repository.dart';

class GetPayouts {
  const GetPayouts(this._repository);

  final MerchantRevenueRepository _repository;

  Future<Either<Failure, List<Payout>>> call(String storeId) {
    return _repository.getPayouts(storeId);
  }
}
