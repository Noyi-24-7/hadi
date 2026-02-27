import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/order.dart';
import '../entities/order_item.dart';
import '../repositories/order_repository.dart';

class CreateOrder {
  const CreateOrder(this._repository);

  final OrderRepository _repository;

  Future<Either<Failure, CreateOrderResult>> call({
    required String storeId,
    required BuyerInfo buyer,
    required DeliveryInfo delivery,
    required List<OrderItem> items,
    required String selectedQuoteId,
    required int deliveryFee,
    required int transactionFee,
    required int subtotalAmount,
    required int totalAmount,
  }) {
    return _repository.createOrder(
      storeId: storeId,
      buyer: buyer,
      delivery: delivery,
      items: items,
      selectedQuoteId: selectedQuoteId,
      deliveryFee: deliveryFee,
      transactionFee: transactionFee,
      subtotalAmount: subtotalAmount,
      totalAmount: totalAmount,
    );
  }
}
