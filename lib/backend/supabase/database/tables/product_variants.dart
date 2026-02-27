import '../database.dart';

class ProductVariantsTable extends SupabaseTable<ProductVariantsRow> {
  @override
  String get tableName => 'product_variants';

  @override
  ProductVariantsRow createRow(Map<String, dynamic> data) =>
      ProductVariantsRow(data);
}

class ProductVariantsRow extends SupabaseDataRow {
  ProductVariantsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProductVariantsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get productId => getField<String>('product_id')!;
  set productId(String value) => setField<String>('product_id', value);

  String? get size => getField<String>('size');
  set size(String? value) => setField<String>('size', value);

  String? get color => getField<String>('color');
  set color(String? value) => setField<String>('color', value);

  int get priceAmount => getField<int>('price_amount')!;
  set priceAmount(int value) => setField<int>('price_amount', value);

  int get quantity => getField<int>('quantity')!;
  set quantity(int value) => setField<int>('quantity', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
