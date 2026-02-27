import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required CartLocalDataSource localDataSource})
      : _local = localDataSource;

  final CartLocalDataSource _local;

  @override
  Future<Either<Failure, Unit>> addItem(CartItem item) async {
    try {
      final items = await _local.getItems();
      final existingIndex = items.indexWhere(
        (e) => e.productId == item.productId && e.variantId == item.variantId,
      );
      if (existingIndex >= 0) {
        final existing = items[existingIndex];
        final newQty = existing.quantity + item.quantity;
        if (newQty > item.availableStock) {
          return left(ValidationFailure(
            'Only ${item.availableStock} items available',
          ));
        }
        items[existingIndex] = CartItemModel(
          productId: existing.productId,
          variantId: existing.variantId,
          productName: existing.productName,
          variantDescription: existing.variantDescription,
          unitPrice: existing.unitPrice,
          quantity: newQty,
          availableStock: existing.availableStock,
        );
      } else {
        if (item.quantity > item.availableStock) {
          return left(ValidationFailure(
            'Only ${item.availableStock} items available',
          ));
        }
        items.add(CartItemModel.fromDomain(item));
      }
      await _local.saveItems(items);
      return right(unit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItem(
    String productId,
    String? variantId,
  ) async {
    try {
      final items = await _local.getItems();
      items.removeWhere(
        (e) => e.productId == productId && e.variantId == variantId,
      );
      await _local.saveItems(items);
      return right(unit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuantity(
    String productId,
    String? variantId,
    int quantity,
  ) async {
    try {
      final items = await _local.getItems();
      final i = items.indexWhere(
        (e) => e.productId == productId && e.variantId == variantId,
      );
      if (i < 0) return left(const ValidationFailure('Cart item not found'));
      if (quantity <= 0) {
        items.removeAt(i);
      } else {
        if (quantity > items[i].availableStock) {
          return left(ValidationFailure(
            'Only ${items[i].availableStock} items available',
          ));
        }
        items[i] = CartItemModel(
          productId: items[i].productId,
          variantId: items[i].variantId,
          productName: items[i].productName,
          variantDescription: items[i].variantDescription,
          unitPrice: items[i].unitPrice,
          quantity: quantity,
          availableStock: items[i].availableStock,
        );
      }
      await _local.saveItems(items);
      return right(unit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getItems() async {
    try {
      final models = await _local.getItems();
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    try {
      await _local.saveItems([]);
      return right(unit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> validateStock(
    String productId,
    String? variantId,
    int quantity,
  ) async {
    try {
      final items = await _local.getItems();
      final existing = items.where(
        (e) => e.productId == productId && e.variantId == variantId,
      );
      final currentQty = existing.fold<int>(0, (s, e) => s + e.quantity);
      return right(quantity <= currentQty);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
