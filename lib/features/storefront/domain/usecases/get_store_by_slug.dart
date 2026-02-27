import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/store_entity.dart';
import '../repositories/storefront_repository.dart';

class GetStoreBySlug {
  const GetStoreBySlug(this._repository);

  final StorefrontRepository _repository;

  Future<Either<Failure, StoreEntity>> call(String slug) {
    return _repository.getStoreBySlug(slug);
  }
}
