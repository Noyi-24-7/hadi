import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/cart_local_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/get_cart_summary.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_cart_quantity.dart';

part 'cart_providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
Future<CartLocalDataSource> cartLocalDataSource(
  CartLocalDataSourceRef ref,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return CartLocalDataSourceImpl(prefs: prefs);
}

@riverpod
Future<CartRepository> cartRepository(CartRepositoryRef ref) async {
  final localDataSource = await ref.watch(cartLocalDataSourceProvider.future);
  return CartRepositoryImpl(localDataSource: localDataSource);
}

// Use cases
@riverpod
Future<AddToCart> addToCart(AddToCartRef ref) async {
  final repository = await ref.watch(cartRepositoryProvider.future);
  return AddToCart(repository);
}

@riverpod
Future<RemoveFromCart> removeFromCart(RemoveFromCartRef ref) async {
  final repository = await ref.watch(cartRepositoryProvider.future);
  return RemoveFromCart(repository);
}

@riverpod
Future<UpdateCartQuantity> updateCartQuantity(
  UpdateCartQuantityRef ref,
) async {
  final repository = await ref.watch(cartRepositoryProvider.future);
  return UpdateCartQuantity(repository);
}

@riverpod
Future<GetCartItems> getCartItems(GetCartItemsRef ref) async {
  final repository = await ref.watch(cartRepositoryProvider.future);
  return GetCartItems(repository);
}

@riverpod
Future<ClearCart> clearCart(ClearCartRef ref) async {
  final repository = await ref.watch(cartRepositoryProvider.future);
  return ClearCart(repository);
}

@riverpod
Future<GetCartSummary> getCartSummary(GetCartSummaryRef ref) async {
  final repository = await ref.watch(cartRepositoryProvider.future);
  return GetCartSummary(repository);
}

// Data providers
@riverpod
Future<List<CartItem>> cartItems(CartItemsRef ref) async {
  final useCase = await ref.watch(getCartItemsProvider.future);
  final result = await useCase.call();
  return result.fold((f) => throw Exception(f.message), (items) => items);
}

@riverpod
Future<CartSummary> cartSummary(CartSummaryRef ref) async {
  final useCase = await ref.watch(getCartSummaryProvider.future);
  final result = await useCase.call();
  return result.fold((f) => throw Exception(f.message), (summary) => summary);
}

@riverpod
double cartSubtotal(CartSubtotalRef ref) {
  final summaryAsync = ref.watch(cartSummaryProvider);
  return summaryAsync.when(
    data: (summary) => summary.subtotal,
    loading: () => 0,
    error: (_, __) => 0,
  );
}

@riverpod
int cartItemCount(CartItemCountRef ref) {
  final summaryAsync = ref.watch(cartSummaryProvider);
  return summaryAsync.when(
    data: (summary) => summary.totalItems,
    loading: () => 0,
    error: (_, __) => 0,
  );
}
