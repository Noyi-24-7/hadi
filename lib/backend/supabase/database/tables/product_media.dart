import '../database.dart';

class ProductMediaTable extends SupabaseTable<ProductMediaDbRow> {
  @override
  String get tableName => 'product_media';

  @override
  ProductMediaDbRow createRow(Map<String, dynamic> data) => ProductMediaDbRow(data);
}

class ProductMediaDbRow extends SupabaseDataRow {
  ProductMediaDbRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProductMediaTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get productId => getField<String>('product_id')!;
  set productId(String value) => setField<String>('product_id', value);

  String get storagePath => getField<String>('storage_path')!;
  set storagePath(String value) => setField<String>('storage_path', value);

  String? get publicUrl => getField<String>('public_url');
  set publicUrl(String? value) => setField<String>('public_url', value);

  String? get fileName => getField<String>('file_name');
  set fileName(String? value) => setField<String>('file_name', value);

  int? get fileSize => getField<int>('file_size');
  set fileSize(int? value) => setField<int>('file_size', value);

  int? get sortOrder => getField<int>('sort_order');
  set sortOrder(int? value) => setField<int>('sort_order', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool? get isVideo => getField<bool>('is_video');
  set isVideo(bool? value) => setField<bool>('is_video', value);
}
