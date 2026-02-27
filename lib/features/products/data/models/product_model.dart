import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel {
  const ProductModel({
    required this.id,
    required this.storeId,
    required this.name,
    this.description,
    required this.price,
    this.stockQuantity,
    this.isActive = true,
    this.createdAt,
    this.category,
    this.weightGrams,
    this.isPreorder = false,
    this.pickupAddressId,
  });

  final String id;
  final String storeId;
  final String name;
  final String? description;
  final double price;
  final int? stockQuantity;
  final bool? isActive;
  final DateTime? createdAt;
  final String? category;
  final double? weightGrams;
  final bool? isPreorder;
  final String? pickupAddressId;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product toDomain() => Product(
        id: id,
        storeId: storeId,
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        isActive: isActive ?? true,
        createdAt: createdAt,
        category: category,
        weightGrams: weightGrams,
        isPreorder: isPreorder ?? false,
        pickupAddressId: pickupAddressId,
      );
}
