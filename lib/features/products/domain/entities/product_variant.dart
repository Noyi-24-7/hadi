import 'package:equatable/equatable.dart';

/// Variant for size/color and per-variant price and quantity.
class ProductVariant extends Equatable {
  const ProductVariant({
    required this.id,
    required this.productId,
    this.size,
    this.color,
    required this.priceAmount,
    required this.quantity,
    this.isActive = true,
    this.createdAt,
  });

  final String id;
  final String productId;
  final String? size;
  final String? color;
  final int priceAmount;
  final int quantity;
  final bool isActive;
  final DateTime? createdAt;

  bool get isOutOfStock => quantity <= 0;

  @override
  List<Object?> get props => [id, productId, size, color, priceAmount, quantity, isActive, createdAt];
}
