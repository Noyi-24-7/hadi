import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/transaction.dart';
import '../repositories/merchant_revenue_repository.dart';

class GetTransactions {
  const GetTransactions(this._repository);

  final MerchantRevenueRepository _repository;

  Future<Either<Failure, List<Transaction>>> call({
    required String storeId,
    String? type,
  }) {
    return _repository.getTransactions(storeId: storeId, type: type);
  }
}
