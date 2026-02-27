import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/preorder_repository.dart';

class CreatePreorderShipment {
  const CreatePreorderShipment(this._repository);

  final PreorderRepository _repository;

  Future<Either<Failure, Map<String, dynamic>>> call(
    String preorderRequestId,
  ) {
    return _repository.createShipment(preorderRequestId);
  }
}
