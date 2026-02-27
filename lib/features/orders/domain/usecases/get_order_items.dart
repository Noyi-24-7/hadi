import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/order_item.dart';
import '../repositories/order_repository.dart';

class GetOrderItems {
  const GetOrderItems(this._repository);

  final OrderRepository _repository;

  Future<Either<Failure, List<OrderItem>>> call(String orderId) {
    return _repository.getOrderItems(orderId);
  }
}
