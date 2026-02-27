import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCart {
  const RemoveFromCart(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String productId,
    String? variantId,
  }) {
    return _repository.removeItem(productId, variantId);
  }
}
