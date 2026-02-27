import '../database.dart';

class OrderDeliveryQuotesTable extends SupabaseTable<OrderDeliveryQuotesRow> {
  @override
  String get tableName => 'order_delivery_quotes';

  @override
  OrderDeliveryQuotesRow createRow(Map<String, dynamic> data) =>
      OrderDeliveryQuotesRow(data);
}

class OrderDeliveryQuotesRow extends SupabaseDataRow {
  OrderDeliveryQuotesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrderDeliveryQuotesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get orderId => getField<String>('order_id')!;
  set orderId(String value) => setField<String>('order_id', value);

  String get serviceLevel => getField<String>('service_level')!;
  set serviceLevel(String value) => setField<String>('service_level', value);

  String? get etaText => getField<String>('eta_text');
  set etaText(String? value) => setField<String>('eta_text', value);

  String get providerName => getField<String>('provider_name')!;
  set providerName(String value) => setField<String>('provider_name', value);

  int get priceAmount => getField<int>('price_amount')!;
  set priceAmount(int value) => setField<int>('price_amount', value);

  String? get currency => getField<String>('currency');
  set currency(String? value) => setField<String>('currency', value);

  dynamic get rawQuote => getField<dynamic>('raw_quote');
  set rawQuote(dynamic value) => setField<dynamic>('raw_quote', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);
}
