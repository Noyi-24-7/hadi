import '../database.dart';

class OrderItemsTable extends SupabaseTable<OrderItemsRow> {
  @override
  String get tableName => 'order_items';

  @override
  OrderItemsRow createRow(Map<String, dynamic> data) => OrderItemsRow(data);
}

class OrderItemsRow extends SupabaseDataRow {
  OrderItemsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrderItemsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get orderId => getField<String>('order_id')!;
  set orderId(String value) => setField<String>('order_id', value);

  String get productId => getField<String>('product_id')!;
  set productId(String value) => setField<String>('product_id', value);

  int get quantity => getField<int>('quantity')!;
  set quantity(int value) => setField<int>('quantity', value);

  double get unitPrice => getField<double>('unit_price')!;
  set unitPrice(double value) => setField<double>('unit_price', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get variantId => getField<String>('variant_id');
  set variantId(String? value) => setField<String>('variant_id', value);

  double? get lineTotalAmount => getField<double>('line_total_amount');
  set lineTotalAmount(double? value) =>
      setField<double>('line_total_amount', value);

  String? get productVariantId => getField<String>('product_variant_id');
  set productVariantId(String? value) =>
      setField<String>('product_variant_id', value);
}
