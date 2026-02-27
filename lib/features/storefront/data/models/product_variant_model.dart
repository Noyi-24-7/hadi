import '../../../../features/products/domain/entities/product_variant.dart';

class ProductVariantModel extends ProductVariant {
  const ProductVariantModel({
    required super.id,
    required super.productId,
    super.size,
    super.color,
    required super.priceAmount,
    required super.quantity,
    super.isActive = true,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      size: json['size'] as String?,
      color: json['color'] as String?,
      priceAmount: (json['price_amount'] as num).toInt(),
      quantity: json['quantity'] as int,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'size': size,
      'color': color,
      'price_amount': priceAmount,
      'quantity': quantity,
      'is_active': isActive,
    };
  }

  factory ProductVariantModel.fromDomain(ProductVariant entity) {
    return ProductVariantModel(
      id: entity.id,
      productId: entity.productId,
      size: entity.size,
      color: entity.color,
      priceAmount: entity.priceAmount,
      quantity: entity.quantity,
      isActive: entity.isActive,
    );
  }

  ProductVariant toDomain() {
    return ProductVariant(
      id: id,
      productId: productId,
      size: size,
      color: color,
      priceAmount: priceAmount,
      quantity: quantity,
      isActive: isActive,
    );
  }
}
