import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product_variant.dart';

part 'product_variant_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductVariantModel {
  const ProductVariantModel({
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
  final bool? isActive;
  final DateTime? createdAt;

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantModelToJson(this);

  ProductVariant toDomain() => ProductVariant(
        id: id,
        productId: productId,
        size: size,
        color: color,
        priceAmount: priceAmount,
        quantity: quantity,
        isActive: isActive ?? true,
        createdAt: createdAt,
      );
}
