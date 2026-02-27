import '../database.dart';

class PayoutsTable extends SupabaseTable<PayoutsRow> {
  @override
  String get tableName => 'payouts';

  @override
  PayoutsRow createRow(Map<String, dynamic> data) => PayoutsRow(data);
}

class PayoutsRow extends SupabaseDataRow {
  PayoutsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PayoutsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get storeId => getField<String>('store_id')!;
  set storeId(String value) => setField<String>('store_id', value);

  double get amount => getField<double>('amount')!;
  set amount(double value) => setField<double>('amount', value);

  String get currency => getField<String>('currency')!;
  set currency(String value) => setField<String>('currency', value);

  String? get provider => getField<String>('provider');
  set provider(String? value) => setField<String>('provider', value);

  String? get safehavenReference => getField<String>('safehaven_reference');
  set safehavenReference(String? value) =>
      setField<String>('safehaven_reference', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime get initiatedAt => getField<DateTime>('initiated_at')!;
  set initiatedAt(DateTime value) => setField<DateTime>('initiated_at', value);

  DateTime? get paidAt => getField<DateTime>('paid_at');
  set paidAt(DateTime? value) => setField<DateTime>('paid_at', value);

  dynamic get meta => getField<dynamic>('meta')!;
  set meta(dynamic value) => setField<dynamic>('meta', value);
}
