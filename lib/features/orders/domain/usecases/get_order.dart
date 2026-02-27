import 'package:fpdart/fpdart.dart' hide Order;

import '../../../../core/error/error.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrder {
  const GetOrder(this._repository);

  final OrderRepository _repository;

  Future<Either<Failure, Order>> call(String orderId) {
    return _repository.getOrderById(orderId);
  }
}
