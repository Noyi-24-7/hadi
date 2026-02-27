import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/delivery_quote.dart';
import '../../domain/repositories/shipping_repository.dart';
import '../datasources/shipping_remote_data_source.dart';

class ShippingRepositoryImpl implements ShippingRepository {
  ShippingRepositoryImpl({required ShippingRemoteDataSource remote})
      : _remote = remote;

  final ShippingRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<DeliveryQuote>>> getQuotes({
    required Map<String, dynamic> pickupAddress,
    required Map<String, dynamic> deliveryAddress,
    required Map<String, dynamic> package,
  }) async {
    try {
      final models = await _remote.getQuotes(
        pickupAddress: pickupAddress,
        deliveryAddress: deliveryAddress,
        package: package,
      );
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
