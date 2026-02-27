import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByStore(
    String storeId,
  );
  Future<Either<Failure, List<PayoutEntity>>> getPayoutsByStore(String storeId);
}
