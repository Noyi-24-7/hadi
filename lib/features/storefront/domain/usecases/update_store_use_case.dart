import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/store_entity.dart';
import '../repositories/storefront_repository.dart';

class UpdateStoreUseCase {
  const UpdateStoreUseCase(this._repository);

  final StorefrontRepository _repository;

  Future<Either<Failure, StoreEntity>> call(StoreEntity store) {
    return _repository.updateStore(store);
  }
}
