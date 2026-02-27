import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product_variant.dart';
import '../repositories/product_repository.dart';

/// Use case for creating a new product variant.
class CreateVariant {
  const CreateVariant(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, ProductVariant>> call({
    required String productId,
    String? size,
    String? color,
    required int priceAmount,
    required int quantity,
  }) {
    return _repository.createVariant(
      productId: productId,
      size: size,
      color: color,
      priceAmount: priceAmount,
      quantity: quantity,
    );
  }
}
