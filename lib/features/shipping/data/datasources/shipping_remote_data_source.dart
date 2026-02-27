import '../models/delivery_quote_model.dart';

abstract class ShippingRemoteDataSource {
  Future<List<DeliveryQuoteModel>> getQuotes({
    required Map<String, dynamic> pickupAddress,
    required Map<String, dynamic> deliveryAddress,
    required Map<String, dynamic> package,
  });
}
