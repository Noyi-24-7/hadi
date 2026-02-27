import '../database.dart';

class DeliveriesTable extends SupabaseTable<DeliveriesRow> {
  @override
  String get tableName => 'deliveries';

  @override
  DeliveriesRow createRow(Map<String, dynamic> data) => DeliveriesRow(data);
}

class DeliveriesRow extends SupabaseDataRow {
  DeliveriesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DeliveriesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get orderId => getField<String>('order_id')!;
  set orderId(String value) => setField<String>('order_id', value);

  String? get shipmentId => getField<String>('shipment_id');
  set shipmentId(String? value) => setField<String>('shipment_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  String? get trackingUrl => getField<String>('tracking_url');
  set trackingUrl(String? value) => setField<String>('tracking_url', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
