import '../database.dart';

class TransactionsTable extends SupabaseTable<TransactionsRow> {
  @override
  String get tableName => 'transactions';

  @override
  TransactionsRow createRow(Map<String, dynamic> data) => TransactionsRow(data);
}

class TransactionsRow extends SupabaseDataRow {
  TransactionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TransactionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get storeId => getField<String>('store_id');
  set storeId(String? value) => setField<String>('store_id', value);

  String? get orderId => getField<String>('order_id');
  set orderId(String? value) => setField<String>('order_id', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  double get amount => getField<double>('amount')!;
  set amount(double value) => setField<double>('amount', value);

  String get currency => getField<String>('currency')!;
  set currency(String value) => setField<String>('currency', value);

  String? get provider => getField<String>('provider');
  set provider(String? value) => setField<String>('provider', value);

  String? get referenceField => getField<String>('reference');
  set referenceField(String? value) => setField<String>('reference', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  dynamic get meta => getField<dynamic>('meta')!;
  set meta(dynamic value) => setField<dynamic>('meta', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
