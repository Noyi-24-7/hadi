import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/preorder_request.dart';
import '../repositories/preorder_repository.dart';

class GetPreordersByStore {
  const GetPreordersByStore(this._repository);

  final PreorderRepository _repository;

  Future<Either<Failure, List<PreorderRequest>>> call(String storeId) {
    return _repository.getByStoreId(storeId);
  }
}
