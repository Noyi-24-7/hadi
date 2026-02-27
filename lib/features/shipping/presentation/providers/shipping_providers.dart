import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/di.dart';
import '../../data/datasources/shipping_remote_data_source.dart';
import '../../data/datasources/shipping_remote_data_source_impl.dart';
import '../../data/repositories/shipping_repository_impl.dart';
import '../../domain/entities/delivery_quote.dart';
import '../../domain/repositories/shipping_repository.dart';
import '../../domain/usecases/get_delivery_quotes.dart';

part 'shipping_providers.g.dart';

// Infrastructure
@riverpod
ShippingRemoteDataSource shippingRemoteDataSource(
  ShippingRemoteDataSourceRef ref,
) {
  return ShippingRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
ShippingRepository shippingRepository(ShippingRepositoryRef ref) {
  return ShippingRepositoryImpl(
    remote: ref.watch(shippingRemoteDataSourceProvider),
  );
}

// Use Cases
@riverpod
GetDeliveryQuotes getDeliveryQuotes(GetDeliveryQuotesRef ref) {
  return GetDeliveryQuotes(ref.watch(shippingRepositoryProvider));
}

// Data Providers
// Data Providers
class DeliveryQuotesParams {
  final Map<String, dynamic> pickupAddress;
  final Map<String, dynamic> deliveryAddress;
  final Map<String, dynamic> package;

  const DeliveryQuotesParams({
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.package,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DeliveryQuotesParams &&
      _mapEquals(other.pickupAddress, pickupAddress) &&
      _mapEquals(other.deliveryAddress, deliveryAddress) &&
      _mapEquals(other.package, package);
  }

  @override
  int get hashCode => 
    _mapHashCode(pickupAddress) ^ 
    _mapHashCode(deliveryAddress) ^ 
    _mapHashCode(package);

  bool _mapEquals(Map a, Map b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || b[key] != a[key]) return false;
    }
    return true;
  }

  int _mapHashCode(Map m) {
    return m.keys.fold(0, (prev, key) => prev ^ key.hashCode ^ m[key].hashCode);
  }
}

@riverpod
Future<List<DeliveryQuote>> deliveryQuotes(
  DeliveryQuotesRef ref, 
  DeliveryQuotesParams params,
) async {
  final result = await ref.watch(getDeliveryQuotesProvider).call(
        pickupAddress: params.pickupAddress,
        deliveryAddress: params.deliveryAddress,
        package: params.package,
      );
  return result.fold(
    (failure) => throw Exception(failure.message),
    (quotes) => quotes,
  );
}
