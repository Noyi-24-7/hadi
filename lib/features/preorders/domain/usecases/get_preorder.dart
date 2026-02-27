import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/preorder_request.dart';
import '../repositories/preorder_repository.dart';

class GetPreorder {
  const GetPreorder(this._repository);

  final PreorderRepository _repository;

  Future<Either<Failure, PreorderRequest>> call(String preorderId) {
    return _repository.getById(preorderId);
  }
}
