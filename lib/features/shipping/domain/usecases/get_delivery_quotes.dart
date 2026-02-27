import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/delivery_quote.dart';
import '../repositories/shipping_repository.dart';

class GetDeliveryQuotes {
  const GetDeliveryQuotes(this._repository);

  final ShippingRepository _repository;

  Future<Either<Failure, List<DeliveryQuote>>> call({
    required Map<String, dynamic> pickupAddress,
    required Map<String, dynamic> deliveryAddress,
    required Map<String, dynamic> package,
  }) {
    return _repository.getQuotes(
      pickupAddress: pickupAddress,
      deliveryAddress: deliveryAddress,
      package: package,
    );
  }
}
