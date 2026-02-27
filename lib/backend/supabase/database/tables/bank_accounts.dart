import '../database.dart';

class BankAccountsTable extends SupabaseTable<BankAccountsRow> {
  @override
  String get tableName => 'bank_accounts';

  @override
  BankAccountsRow createRow(Map<String, dynamic> data) => BankAccountsRow(data);
}

class BankAccountsRow extends SupabaseDataRow {
  BankAccountsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => BankAccountsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get merchantId => getField<String>('merchant_id')!;
  set merchantId(String value) => setField<String>('merchant_id', value);

  String get bankName => getField<String>('bank_name')!;
  set bankName(String value) => setField<String>('bank_name', value);

  String get bankCode => getField<String>('bank_code')!;
  set bankCode(String value) => setField<String>('bank_code', value);

  String get accountNumber => getField<String>('account_number')!;
  set accountNumber(String value) => setField<String>('account_number', value);

  String get accountName => getField<String>('account_name')!;
  set accountName(String value) => setField<String>('account_name', value);

  bool get verified => getField<bool>('verified')!;
  set verified(bool value) => setField<bool>('verified', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get storeId => getField<String>('store_id');
  set storeId(String? value) => setField<String>('store_id', value);

  DateTime? get verifiedAt => getField<DateTime>('verified_at');
  set verifiedAt(DateTime? value) => setField<DateTime>('verified_at', value);

  String? get verificationRef => getField<String>('verification_ref');
  set verificationRef(String? value) =>
      setField<String>('verification_ref', value);
}
