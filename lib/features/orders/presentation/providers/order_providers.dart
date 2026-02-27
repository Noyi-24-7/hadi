import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/supabase_provider.dart';
import '../../data/datasources/order_remote_data_source.dart';
import '../../data/datasources/order_remote_data_source_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/create_order.dart';
import '../../domain/usecases/get_order.dart';
import '../../domain/usecases/get_order_items.dart';
import '../../domain/usecases/get_orders_by_buyer.dart';
import '../../domain/usecases/get_orders_by_store.dart';

part 'order_providers.g.dart';

@riverpod
OrderRemoteDataSource orderRemoteDataSource(OrderRemoteDataSourceRef ref) {
  return OrderRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepositoryImpl(
    remoteDataSource: ref.watch(orderRemoteDataSourceProvider),
  );
}

// Use cases
@riverpod
CreateOrder createOrder(CreateOrderRef ref) {
  return CreateOrder(ref.watch(orderRepositoryProvider));
}

@riverpod
GetOrder getOrder(GetOrderRef ref) {
  return GetOrder(ref.watch(orderRepositoryProvider));
}

@riverpod
GetOrdersByBuyer getOrdersByBuyer(GetOrdersByBuyerRef ref) {
  return GetOrdersByBuyer(ref.watch(orderRepositoryProvider));
}

@riverpod
GetOrdersByStore getOrdersByStore(GetOrdersByStoreRef ref) {
  return GetOrdersByStore(ref.watch(orderRepositoryProvider));
}

@riverpod
GetOrderItems getOrderItems(GetOrderItemsRef ref) {
  return GetOrderItems(ref.watch(orderRepositoryProvider));
}

// Data providers
@riverpod
Future<Order> order(OrderRef ref, String orderId) async {
  final result = await ref.watch(getOrderProvider).call(orderId);
  return result.fold((f) => throw Exception(f.message), (order) => order);
}

@riverpod
Future<List<Order>> ordersByBuyer(OrdersByBuyerRef ref, String buyerId) async {
  final result = await ref.watch(getOrdersByBuyerProvider).call(buyerId);
  return result.fold((f) => throw Exception(f.message), (orders) => orders);
}

@riverpod
Future<List<Order>> ordersByStore(OrdersByStoreRef ref, String storeId) async {
  final result = await ref.watch(getOrdersByStoreProvider).call(storeId);
  return result.fold((f) => throw Exception(f.message), (orders) => orders);
}

@riverpod
Future<List<OrderItem>> orderItems(OrderItemsRef ref, String orderId) async {
  final result = await ref.watch(getOrderItemsProvider).call(orderId);
  return result.fold((f) => throw Exception(f.message), (items) => items);
}
