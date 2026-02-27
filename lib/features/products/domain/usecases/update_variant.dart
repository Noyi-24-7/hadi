import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product_variant.dart';
import '../repositories/product_repository.dart';

/// Use case for updating an existing product variant.
class UpdateVariant {
  const UpdateVariant(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, ProductVariant>> call({
    required String id,
    int? priceAmount,
    int? quantity,
    bool? isActive,
  }) {
    return _repository.updateVariant(
      id: id,
      priceAmount: priceAmount,
      quantity: quantity,
      isActive: isActive,
    );
  }
}
