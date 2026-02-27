import '../database.dart';

class StoresTable extends SupabaseTable<StoresRow> {
  @override
  String get tableName => 'stores';

  @override
  StoresRow createRow(Map<String, dynamic> data) => StoresRow(data);
}

class StoresRow extends SupabaseDataRow {
  StoresRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StoresTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get ownerId => getField<String>('owner_id')!;
  set ownerId(String value) => setField<String>('owner_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get slug => getField<String>('slug');
  set slug(String? value) => setField<String>('slug', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  bool get isActive => getField<bool>('is_active')!;
  set isActive(bool value) => setField<bool>('is_active', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get bannerUrl => getField<String>('banner_url');
  set bannerUrl(String? value) => setField<String>('banner_url', value);

  String? get logoUrl => getField<String>('logo_url');
  set logoUrl(String? value) => setField<String>('logo_url', value);

  bool get businessInfoComplete => getField<bool>('business_info_complete')!;
  set businessInfoComplete(bool value) =>
      setField<bool>('business_info_complete', value);

  bool get bankComplete => getField<bool>('bank_complete')!;
  set bankComplete(bool value) => setField<bool>('bank_complete', value);

  bool get pickupAddressComplete => getField<bool>('pickup_address_complete')!;
  set pickupAddressComplete(bool value) =>
      setField<bool>('pickup_address_complete', value);

  bool get storefrontSetupComplete =>
      getField<bool>('storefront_setup_complete')!;
  set storefrontSetupComplete(bool value) =>
      setField<bool>('storefront_setup_complete', value);

  bool get onboardingComplete => getField<bool>('onboarding_complete')!;
  set onboardingComplete(bool value) =>
      setField<bool>('onboarding_complete', value);

  String? get registrationStatus => getField<String>('registration_status');
  set registrationStatus(String? value) =>
      setField<String>('registration_status', value);

  String? get rcNumber => getField<String>('rc_number');
  set rcNumber(String? value) => setField<String>('rc_number', value);

  String? get defaultPickupAddressId =>
      getField<String>('default_pickup_address_id');
  set defaultPickupAddressId(String? value) =>
      setField<String>('default_pickup_address_id', value);
}
