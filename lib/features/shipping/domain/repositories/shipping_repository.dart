import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/delivery_quote.dart';

abstract class ShippingRepository {
  Future<Either<Failure, List<DeliveryQuote>>> getQuotes({
    required Map<String, dynamic> pickupAddress,
    required Map<String, dynamic> deliveryAddress,
    required Map<String, dynamic> package,
  });
}
