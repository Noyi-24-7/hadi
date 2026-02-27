import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/di.dart';
import '../../data/datasources/delivery_ticket_remote_data_source.dart';
import '../../data/datasources/delivery_ticket_remote_data_source_impl.dart';
import '../../data/repositories/delivery_ticket_repository_impl.dart';
import '../../domain/entities/delivery_ticket.dart';
import '../../domain/repositories/delivery_ticket_repository.dart';
import '../../domain/usecases/create_delivery_ticket.dart';
import '../../domain/usecases/get_delivery_ticket.dart';
import '../../domain/usecases/get_delivery_tickets_by_store.dart';

part 'delivery_ticket_providers.g.dart';

// Infrastructure
@riverpod
DeliveryTicketRemoteDataSource deliveryTicketRemoteDataSource(
  DeliveryTicketRemoteDataSourceRef ref,
) {
  return DeliveryTicketRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
DeliveryTicketRepository deliveryTicketRepository(
  DeliveryTicketRepositoryRef ref,
) {
  return DeliveryTicketRepositoryImpl(
    remote: ref.watch(deliveryTicketRemoteDataSourceProvider),
  );
}

// Use Cases
@riverpod
CreateDeliveryTicket createDeliveryTicket(CreateDeliveryTicketRef ref) {
  return CreateDeliveryTicket(ref.watch(deliveryTicketRepositoryProvider));
}

@riverpod
GetDeliveryTicket getDeliveryTicket(GetDeliveryTicketRef ref) {
  return GetDeliveryTicket(ref.watch(deliveryTicketRepositoryProvider));
}

@riverpod
GetDeliveryTicketsByStore getDeliveryTicketsByStore(
  GetDeliveryTicketsByStoreRef ref,
) {
  return GetDeliveryTicketsByStore(
    ref.watch(deliveryTicketRepositoryProvider),
  );
}

// Data Providers
@riverpod
Future<DeliveryTicket> deliveryTicket(
  DeliveryTicketRef ref,
  String ticketId,
) async {
  final result = await ref.watch(getDeliveryTicketProvider).call(ticketId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (ticket) => ticket,
  );
}

@riverpod
Future<List<DeliveryTicket>> deliveryTicketsByStore(
  DeliveryTicketsByStoreRef ref,
  String storeId,
) async {
  final result = await ref
      .watch(getDeliveryTicketsByStoreProvider)
      .call(storeId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (tickets) => tickets,
  );
}
