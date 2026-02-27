
import '../../domain/entities/cart_item.dart';

class CartItemModel {
  const CartItemModel({
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

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'variantId': variantId,
        'productName': productName,
        'variantDescription': variantDescription,
        'unitPrice': unitPrice,
        'quantity': quantity,
        'availableStock': availableStock,
        'imageUrl': imageUrl,
      };

  static CartItemModel fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['productId'] as String,
        variantId: json['variantId'] as String?,
        productName: json['productName'] as String,
        variantDescription: json['variantDescription'] as String?,
        unitPrice: (json['unitPrice'] as num).toDouble(),
        quantity: (json['quantity'] as num).toInt(),
        availableStock: (json['availableStock'] as num).toInt(),
        imageUrl: json['imageUrl'] as String?,
      );

  CartItem toDomain() => CartItem(
        productId: productId,
        variantId: variantId,
        productName: productName,
        variantDescription: variantDescription,
        unitPrice: unitPrice,
        quantity: quantity,
        availableStock: availableStock,
        imageUrl: imageUrl,
      );

  static CartItemModel fromDomain(CartItem item) => CartItemModel(
        productId: item.productId,
        variantId: item.variantId,
        productName: item.productName,
        variantDescription: item.variantDescription,
        unitPrice: item.unitPrice,
        quantity: item.quantity,
        availableStock: item.availableStock,
        imageUrl: item.imageUrl,
      );
}
