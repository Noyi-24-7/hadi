import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  const OrderItem({
    required this.productId,
    this.variantId,
    required this.quantity,
    required this.unitPrice,
    this.lineTotalAmount,
  });

  final String productId;
  final String? variantId;
  final int quantity;
  final double unitPrice;
  final double? lineTotalAmount;

  @override
  List<Object?> get props => [productId, variantId, quantity, unitPrice, lineTotalAmount];
}
