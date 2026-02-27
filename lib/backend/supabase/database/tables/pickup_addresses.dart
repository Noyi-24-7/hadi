import '../database.dart';

class PickupAddressesTable extends SupabaseTable<PickupAddressesRow> {
  @override
  String get tableName => 'pickup_addresses';

  @override
  PickupAddressesRow createRow(Map<String, dynamic> data) =>
      PickupAddressesRow(data);
}

class PickupAddressesRow extends SupabaseDataRow {
  PickupAddressesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PickupAddressesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get storeId => getField<String>('store_id')!;
  set storeId(String value) => setField<String>('store_id', value);

  String get country => getField<String>('country')!;
  set country(String value) => setField<String>('country', value);

  String get state => getField<String>('state')!;
  set state(String value) => setField<String>('state', value);

  String get city => getField<String>('city')!;
  set city(String value) => setField<String>('city', value);

  String get addressLine1 => getField<String>('address_line1')!;
  set addressLine1(String value) => setField<String>('address_line1', value);

  String? get addressLine2 => getField<String>('address_line2');
  set addressLine2(String? value) => setField<String>('address_line2', value);

  String? get zip => getField<String>('zip');
  set zip(String? value) => setField<String>('zip', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool get isDefault => getField<bool>('is_default')!;
  set isDefault(bool value) => setField<bool>('is_default', value);
}
