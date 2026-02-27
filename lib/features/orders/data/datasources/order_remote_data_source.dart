import '../models/order_item_model.dart';
import '../models/order_model.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/repositories/order_repository.dart';

abstract class OrderRemoteDataSource {
  Future<CreateOrderResult> createOrder({
    required String storeId,
    required BuyerInfo buyer,
    required DeliveryInfo delivery,
    required List<OrderItem> items,
    required String selectedQuoteId,
    required int deliveryFee,
    required int transactionFee,
    required int subtotalAmount,
    required int totalAmount,
  });

  Future<OrderModel?> getOrderById(String orderId);

  Future<List<OrderModel>> getOrdersByBuyer(String buyerId);

  Future<List<OrderModel>> getOrdersByStore(String storeId);

  Future<List<OrderItemModel>> getOrderItems(String orderId);
}
