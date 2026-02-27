import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.productId,
    this.variantId,
    required this.productName,
    this.variantDescription,
    required this.unitPrice,
    required this.quantity,
    required this.availableStock,
    this.imageUrl,
  });

  final String productId;
  final String? variantId;
  final String productName;
  final String? variantDescription;
  final double unitPrice;
  final int quantity;
  final int availableStock;
  final String? imageUrl;

  double get lineTotal => unitPrice * quantity;

  @override
  List<Object?> get props =>
      [productId, variantId, productName, variantDescription, unitPrice, quantity, availableStock, imageUrl];
}
