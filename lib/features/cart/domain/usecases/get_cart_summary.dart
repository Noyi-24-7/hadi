import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class CartSummary extends Equatable {
  const CartSummary({
    required this.items,
    required this.subtotal,
    required this.totalItems,
  });

  final List<CartItem> items;
  final double subtotal;
  final int totalItems;

  @override
  List<Object?> get props => [items, subtotal, totalItems];
}

class GetCartSummary {
  const GetCartSummary(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, CartSummary>> call() async {
    final result = await _repository.getItems();
    return result.map((items) {
      final subtotal = items.fold<double>(0, (s, i) => s + i.lineTotal);
      final totalItems = items.fold<int>(0, (s, i) => s + i.quantity);
      return CartSummary(
        items: items,
        subtotal: subtotal,
        totalItems: totalItems,
      );
    });
  }
}
