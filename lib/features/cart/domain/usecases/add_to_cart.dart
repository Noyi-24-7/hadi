import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  const AddToCart(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, Unit>> call(CartItem item) {
    return _repository.addItem(item);
  }
}
