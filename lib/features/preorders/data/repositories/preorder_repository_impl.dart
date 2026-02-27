import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/preorder_request.dart';
import '../../domain/repositories/preorder_repository.dart';
import '../datasources/preorder_remote_data_source.dart';

class PreorderRepositoryImpl implements PreorderRepository {
  PreorderRepositoryImpl({required PreorderRemoteDataSource remote})
      : _remote = remote;

  final PreorderRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<PreorderRequest>>> getByStoreId(
    String storeId,
  ) async {
    try {
      final models = await _remote.getByStoreId(storeId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreorderRequest>> getById(String preorderId) async {
    try {
      final model = await _remote.getById(preorderId);
      if (model == null) {
        return left(const ValidationFailure('Preorder not found'));
      }
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createShipment(
    String preorderRequestId,
  ) async {
    try {
      final result = await _remote.createShipment(preorderRequestId);
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
