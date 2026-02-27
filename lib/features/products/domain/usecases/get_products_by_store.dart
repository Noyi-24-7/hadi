import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case for getting all products for a specific store.
class GetProductsByStore {
  const GetProductsByStore(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, List<Product>>> call(String storeId) {
    return _repository.getProductsByStoreId(storeId);
  }
}
