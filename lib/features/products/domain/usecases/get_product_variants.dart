import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product_variant.dart';
import '../repositories/product_repository.dart';

class GetProductVariants {
  GetProductVariants(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, List<ProductVariant>>> call(String productId) =>
      _repository.getVariantsByProductId(productId);
}
