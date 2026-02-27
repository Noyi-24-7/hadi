import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/product_repository.dart';

/// Use case for deleting a product.
class DeleteProduct {
  const DeleteProduct(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Unit>> call(String id) {
    return _repository.deleteProduct(id);
  }
}
