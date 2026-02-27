import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProduct {
  GetProduct(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call(String productId) =>
      _repository.getProductById(productId);
}
