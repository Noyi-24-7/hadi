import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
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
  final bool isActive;
  final DateTime? createdAt;
  final String? category;
  final double? weightGrams;
  final bool isPreorder;
  final String? pickupAddressId;

  @override
  List<Object?> get props => [
        id, storeId, name, description, price, stockQuantity, isActive,
        createdAt, category, weightGrams, isPreorder, pickupAddressId,
      ];
}
