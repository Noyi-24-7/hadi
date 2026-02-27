import '../database.dart';

class PreorderRequestsTable extends SupabaseTable<PreorderRequestsRow> {
  @override
  String get tableName => 'preorder_requests';

  @override
  PreorderRequestsRow createRow(Map<String, dynamic> data) =>
      PreorderRequestsRow(data);
}

class PreorderRequestsRow extends SupabaseDataRow {
  PreorderRequestsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PreorderRequestsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get storeId => getField<String>('store_id')!;
  set storeId(String value) => setField<String>('store_id', value);

  String get productId => getField<String>('product_id')!;
  set productId(String value) => setField<String>('product_id', value);

  String? get productVariantId => getField<String>('product_variant_id');
  set productVariantId(String? value) =>
      setField<String>('product_variant_id', value);

  int get quantity => getField<int>('quantity')!;
  set quantity(int value) => setField<int>('quantity', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime? get requestedAt => getField<DateTime>('requested_at');
  set requestedAt(DateTime? value) => setField<DateTime>('requested_at', value);

  DateTime? get lastResentAt => getField<DateTime>('last_resent_at');
  set lastResentAt(DateTime? value) =>
      setField<DateTime>('last_resent_at', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  String? get terminalShipmentId => getField<String>('terminal_shipment_id');
  set terminalShipmentId(String? value) =>
      setField<String>('terminal_shipment_id', value);

  String? get trackingUrl => getField<String>('tracking_url');
  set trackingUrl(String? value) => setField<String>('tracking_url', value);

  dynamic get trackingEvents => getField<dynamic>('tracking_events')!;
  set trackingEvents(dynamic value) =>
      setField<dynamic>('tracking_events', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
