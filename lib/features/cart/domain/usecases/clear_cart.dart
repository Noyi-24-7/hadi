import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/cart_repository.dart';

class ClearCart {
  const ClearCart(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, Unit>> call() {
    return _repository.clear();
  }
}
