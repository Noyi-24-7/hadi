import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/repositories/storefront_repository.dart';

/// Use case to get a store by owner ID
class GetStoreByOwnerId {
  const GetStoreByOwnerId(this._repository);

  final StorefrontRepository _repository;

  Future<Either<Failure, StoreEntity>> call(String ownerId) {
    return _repository.getStoreByOwnerId(ownerId);
  }
}
