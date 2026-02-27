import '../database.dart';

class DeliveryTicketItemsTable extends SupabaseTable<DeliveryTicketItemsRow> {
  @override
  String get tableName => 'delivery_ticket_items';

  @override
  DeliveryTicketItemsRow createRow(Map<String, dynamic> data) =>
      DeliveryTicketItemsRow(data);
}

class DeliveryTicketItemsRow extends SupabaseDataRow {
  DeliveryTicketItemsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DeliveryTicketItemsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get deliveryTicketId => getField<String>('delivery_ticket_id')!;
  set deliveryTicketId(String value) =>
      setField<String>('delivery_ticket_id', value);

  String get itemName => getField<String>('item_name')!;
  set itemName(String value) => setField<String>('item_name', value);

  double? get itemAmount => getField<double>('item_amount');
  set itemAmount(double? value) => setField<double>('item_amount', value);

  int get quantity => getField<int>('quantity')!;
  set quantity(int value) => setField<int>('quantity', value);

  int? get weightGrams => getField<int>('weight_grams');
  set weightGrams(int? value) => setField<int>('weight_grams', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
