import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../../products/domain/entities/product.dart';
import '../repositories/storefront_repository.dart';

class GetActiveProducts {
  const GetActiveProducts(this._repository);

  final StorefrontRepository _repository;

  Future<Either<Failure, List<Product>>> call(String storeId) {
    return _repository.getActiveProductsByStoreId(storeId);
  }
}
