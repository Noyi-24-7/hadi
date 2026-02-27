import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/di.dart';
import '../../data/datasources/preorder_remote_data_source.dart';
import '../../data/datasources/preorder_remote_data_source_impl.dart';
import '../../data/repositories/preorder_repository_impl.dart';
import '../../domain/entities/preorder_request.dart';
import '../../domain/repositories/preorder_repository.dart';
import '../../domain/usecases/create_preorder_shipment.dart';
import '../../domain/usecases/get_preorder.dart';
import '../../domain/usecases/get_preorders_by_store.dart';

part 'preorder_providers.g.dart';

// Infrastructure
@riverpod
PreorderRemoteDataSource preorderRemoteDataSource(
  PreorderRemoteDataSourceRef ref,
) {
  return PreorderRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
PreorderRepository preorderRepository(PreorderRepositoryRef ref) {
  return PreorderRepositoryImpl(
    remote: ref.watch(preorderRemoteDataSourceProvider),
  );
}

// Use Cases
@riverpod
GetPreordersByStore getPreordersByStore(GetPreordersByStoreRef ref) {
  return GetPreordersByStore(ref.watch(preorderRepositoryProvider));
}

@riverpod
GetPreorder getPreorder(GetPreorderRef ref) {
  return GetPreorder(ref.watch(preorderRepositoryProvider));
}

@riverpod
CreatePreorderShipment createPreorderShipment(CreatePreorderShipmentRef ref) {
  return CreatePreorderShipment(ref.watch(preorderRepositoryProvider));
}

// Data Providers
@riverpod
Future<List<PreorderRequest>> preordersByStore(
  PreordersByStoreRef ref,
  String storeId,
) async {
  final result = await ref.watch(getPreordersByStoreProvider).call(storeId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (preorders) => preorders,
  );
}

@riverpod
Future<PreorderRequest> preorder(
  PreorderRef ref,
  String preorderId,
) async {
  final result = await ref.watch(getPreorderProvider).call(preorderId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (preorder) => preorder,
  );
}
