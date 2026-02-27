import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case for updating an existing product.
class UpdateProduct {
  const UpdateProduct(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call({
    required String id,
    String? name,
    String? description,
    double? price,
    int? stockQuantity,
    bool? isActive,
    String? category,
    double? weightGrams,
    bool? isPreorder,
    String? pickupAddressId,
  }) {
    return _repository.updateProduct(
      id: id,
      name: name,
      description: description,
      price: price,
      stockQuantity: stockQuantity,
      isActive: isActive,
      category: category,
      weightGrams: weightGrams,
      isPreorder: isPreorder,
      pickupAddressId: pickupAddressId,
    );
  }
}
