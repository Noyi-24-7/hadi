import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case for creating a new product.
class CreateProduct {
  const CreateProduct(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call({
    required String storeId,
    required String name,
    String? description,
    required double price,
    int? stockQuantity,
    String? category,
    double? weightGrams,
    bool isPreorder = false,
    String? pickupAddressId,
  }) {
    return _repository.createProduct(
      storeId: storeId,
      name: name,
      description: description,
      price: price,
      stockQuantity: stockQuantity,
      category: category,
      weightGrams: weightGrams,
      isPreorder: isPreorder,
      pickupAddressId: pickupAddressId,
    );
  }
}
