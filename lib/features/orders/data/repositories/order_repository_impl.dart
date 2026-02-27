import 'package:fpdart/fpdart.dart' hide Order;

import '../../../../core/error/error.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../datasources/order_remote_data_source_impl.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required OrderRemoteDataSource remoteDataSource})
      : _remote = remoteDataSource;

  final OrderRemoteDataSource _remote;

  @override
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
  }) async {
    try {
      final result = await _remote.createOrder(
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
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String orderId) async {
    try {
      final model = await _remote.getOrderById(orderId);
      if (model == null) return left(const ValidationFailure('Order not found'));
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getOrdersByBuyer(String buyerId) async {
    try {
      final models = await _remote.getOrdersByBuyer(buyerId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getOrdersByStore(String storeId) async {
    try {
      final models = await _remote.getOrdersByStore(storeId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderItem>>> getOrderItems(String orderId) async {
    try {
      final models = await _remote.getOrderItems(orderId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
