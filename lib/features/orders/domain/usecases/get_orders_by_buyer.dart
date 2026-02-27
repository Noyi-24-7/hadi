import 'package:fpdart/fpdart.dart' hide Order;

import '../../../../core/error/error.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrdersByBuyer {
  const GetOrdersByBuyer(this._repository);

  final OrderRepository _repository;

  Future<Either<Failure, List<Order>>> call(String buyerId) {
    return _repository.getOrdersByBuyer(buyerId);
  }
}
