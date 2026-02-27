import '../database.dart';

class DeliveryTicketsTable extends SupabaseTable<DeliveryTicketsRow> {
  @override
  String get tableName => 'delivery_tickets';

  @override
  DeliveryTicketsRow createRow(Map<String, dynamic> data) =>
      DeliveryTicketsRow(data);
}

class DeliveryTicketsRow extends SupabaseDataRow {
  DeliveryTicketsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DeliveryTicketsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get storeId => getField<String>('store_id')!;
  set storeId(String value) => setField<String>('store_id', value);

  double? get deliveryPriceAmount => getField<double>('delivery_price_amount');
  set deliveryPriceAmount(double? value) =>
      setField<double>('delivery_price_amount', value);

  String get currency => getField<String>('currency')!;
  set currency(String value) => setField<String>('currency', value);

  String? get pickupName => getField<String>('pickup_name');
  set pickupName(String? value) => setField<String>('pickup_name', value);

  String? get pickupPhone => getField<String>('pickup_phone');
  set pickupPhone(String? value) => setField<String>('pickup_phone', value);

  String? get pickupAddressLine1 => getField<String>('pickup_address_line1');
  set pickupAddressLine1(String? value) =>
      setField<String>('pickup_address_line1', value);

  String? get pickupAddressLine2 => getField<String>('pickup_address_line2');
  set pickupAddressLine2(String? value) =>
      setField<String>('pickup_address_line2', value);

  String? get pickupCity => getField<String>('pickup_city');
  set pickupCity(String? value) => setField<String>('pickup_city', value);

  String? get pickupState => getField<String>('pickup_state');
  set pickupState(String? value) => setField<String>('pickup_state', value);

  String? get pickupLga => getField<String>('pickup_lga');
  set pickupLga(String? value) => setField<String>('pickup_lga', value);

  String? get pickupCountry => getField<String>('pickup_country');
  set pickupCountry(String? value) => setField<String>('pickup_country', value);

  String? get pickupPostalCode => getField<String>('pickup_postal_code');
  set pickupPostalCode(String? value) =>
      setField<String>('pickup_postal_code', value);

  String get dropoffName => getField<String>('dropoff_name')!;
  set dropoffName(String value) => setField<String>('dropoff_name', value);

  String get dropoffPhone => getField<String>('dropoff_phone')!;
  set dropoffPhone(String value) => setField<String>('dropoff_phone', value);

  String get dropoffAddressLine1 => getField<String>('dropoff_address_line1')!;
  set dropoffAddressLine1(String value) =>
      setField<String>('dropoff_address_line1', value);

  String? get dropoffAddressLine2 => getField<String>('dropoff_address_line2');
  set dropoffAddressLine2(String? value) =>
      setField<String>('dropoff_address_line2', value);

  String get dropoffCity => getField<String>('dropoff_city')!;
  set dropoffCity(String value) => setField<String>('dropoff_city', value);

  String? get dropoffState => getField<String>('dropoff_state');
  set dropoffState(String? value) => setField<String>('dropoff_state', value);

  String? get dropoffLga => getField<String>('dropoff_lga');
  set dropoffLga(String? value) => setField<String>('dropoff_lga', value);

  String get dropoffCountry => getField<String>('dropoff_country')!;
  set dropoffCountry(String value) =>
      setField<String>('dropoff_country', value);

  String? get dropoffPostalCode => getField<String>('dropoff_postal_code');
  set dropoffPostalCode(String? value) =>
      setField<String>('dropoff_postal_code', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  String? get terminalShipmentId => getField<String>('terminal_shipment_id');
  set terminalShipmentId(String? value) =>
      setField<String>('terminal_shipment_id', value);

  String? get trackingUrl => getField<String>('tracking_url');
  set trackingUrl(String? value) => setField<String>('tracking_url', value);

  dynamic get trackingEvents => getField<dynamic>('tracking_events')!;
  set trackingEvents(dynamic value) =>
      setField<dynamic>('tracking_events', value);

  String? get paymentReference => getField<String>('payment_reference');
  set paymentReference(String? value) =>
      setField<String>('payment_reference', value);

  String? get paymentStatus => getField<String>('payment_status');
  set paymentStatus(String? value) => setField<String>('payment_status', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
