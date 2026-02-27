import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, Unit>> addItem(CartItem item);
  Future<Either<Failure, Unit>> removeItem(String productId, String? variantId);
  Future<Either<Failure, Unit>> updateQuantity(
    String productId,
    String? variantId,
    int quantity,
  );
  Future<Either<Failure, List<CartItem>>> getItems();
  Future<Either<Failure, Unit>> clear();
  Future<Either<Failure, bool>> validateStock(String productId, String? variantId, int quantity);
}
