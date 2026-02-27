import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCartItems {
  const GetCartItems(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, List<CartItem>>> call() {
    return _repository.getItems();
  }
}
