import '../database.dart';

class ProductsTable extends SupabaseTable<ProductsRow> {
  @override
  String get tableName => 'products';

  @override
  ProductsRow createRow(Map<String, dynamic> data) => ProductsRow(data);
}

class ProductsRow extends SupabaseDataRow {
  ProductsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProductsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get storeId => getField<String>('store_id')!;
  set storeId(String value) => setField<String>('store_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  double get price => getField<double>('price')!;
  set price(double value) => setField<double>('price', value);

  int? get stockQuantity => getField<int>('stock_quantity');
  set stockQuantity(int? value) => setField<int>('stock_quantity', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);

  double? get weightGrams => getField<double>('weight_grams');
  set weightGrams(double? value) => setField<double>('weight_grams', value);

  bool? get isPreorder => getField<bool>('is_preorder');
  set isPreorder(bool? value) => setField<bool>('is_preorder', value);

  String? get pickupAddressId => getField<String>('pickup_address_id');
  set pickupAddressId(String? value) =>
      setField<String>('pickup_address_id', value);
}
