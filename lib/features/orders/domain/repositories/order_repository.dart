import 'package:fpdart/fpdart.dart' hide Order;

import '../../../../core/error/error.dart';
import '../entities/order.dart';
import '../entities/order_item.dart';

abstract class OrderRepository {
  /// Creates order via Edge Function orders-create; returns order id + payment URL.
  /// Safe Haven payment is initialized server-side; client only redirects to payment_url.
  Future<Either<Failure, CreateOrderResult>> createOrder({
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

  Future<Either<Failure, Order>> getOrderById(String orderId);

  /// Lists all orders for a specific buyer
  Future<Either<Failure, List<Order>>> getOrdersByBuyer(String buyerId);

  /// Lists all orders for a specific store
  Future<Either<Failure, List<Order>>> getOrdersByStore(String storeId);

  /// Retrieves all items for a specific order
  Future<Either<Failure, List<OrderItem>>> getOrderItems(String orderId);
}

class BuyerInfo {
  const BuyerInfo({
    required this.name,
    required this.phone,
    required this.email,
  });
  final String name;
  final String phone;
  final String email;
}

class DeliveryInfo {
  const DeliveryInfo({
    required this.address,
    required this.city,
    required this.state,
    required this.lga,
    required this.country,
  });
  final String address;
  final String city;
  final String state;
  final String lga;
  final String country;
}
