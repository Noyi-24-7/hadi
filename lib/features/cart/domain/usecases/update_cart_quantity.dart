import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantity {
  const UpdateCartQuantity(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String productId,
    String? variantId,
    required int quantity,
  }) {
    return _repository.updateQuantity(productId, variantId, quantity);
  }
}
