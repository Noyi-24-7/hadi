import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/preorder_request.dart';

abstract class PreorderRepository {
  Future<Either<Failure, List<PreorderRequest>>> getByStoreId(String storeId);

  Future<Either<Failure, PreorderRequest>> getById(String preorderId);

  Future<Either<Failure, Map<String, dynamic>>> createShipment(
    String preorderRequestId,
  );
}
