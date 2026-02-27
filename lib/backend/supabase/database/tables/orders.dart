import '../database.dart';

class OrdersTable extends SupabaseTable<OrdersRow> {
  @override
  String get tableName => 'orders';

  @override
  OrdersRow createRow(Map<String, dynamic> data) => OrdersRow(data);
}

class OrdersRow extends SupabaseDataRow {
  OrdersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrdersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get storeId => getField<String>('store_id')!;
  set storeId(String value) => setField<String>('store_id', value);

  String? get buyerId => getField<String>('buyer_id');
  set buyerId(String? value) => setField<String>('buyer_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  double get totalAmount => getField<double>('total_amount')!;
  set totalAmount(double value) => setField<double>('total_amount', value);

  String? get currency => getField<String>('currency');
  set currency(String? value) => setField<String>('currency', value);

  String? get paymentReference => getField<String>('payment_reference');
  set paymentReference(String? value) =>
      setField<String>('payment_reference', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get buyerFullName => getField<String>('buyer_full_name');
  set buyerFullName(String? value) =>
      setField<String>('buyer_full_name', value);

  String? get buyerPhone => getField<String>('buyer_phone');
  set buyerPhone(String? value) => setField<String>('buyer_phone', value);

  String? get buyerEmail => getField<String>('buyer_email');
  set buyerEmail(String? value) => setField<String>('buyer_email', value);

  String? get deliveryCountry => getField<String>('delivery_country');
  set deliveryCountry(String? value) =>
      setField<String>('delivery_country', value);

  String? get deliveryState => getField<String>('delivery_state');
  set deliveryState(String? value) => setField<String>('delivery_state', value);

  String? get deliveryLga => getField<String>('delivery_lga');
  set deliveryLga(String? value) => setField<String>('delivery_lga', value);

  String? get deliveryAddress => getField<String>('delivery_address');
  set deliveryAddress(String? value) =>
      setField<String>('delivery_address', value);

  int? get subtotalAmount => getField<int>('subtotal_amount');
  set subtotalAmount(int? value) => setField<int>('subtotal_amount', value);

  int? get deliveryFee => getField<int>('delivery_fee');
  set deliveryFee(int? value) => setField<int>('delivery_fee', value);

  int? get transactionFee => getField<int>('transaction_fee');
  set transactionFee(int? value) => setField<int>('transaction_fee', value);

  String? get selectedDeliveryQuoteId =>
      getField<String>('selected_delivery_quote_id');
  set selectedDeliveryQuoteId(String? value) =>
      setField<String>('selected_delivery_quote_id', value);

  String? get safehavenReference => getField<String>('safehaven_reference');
  set safehavenReference(String? value) =>
      setField<String>('safehaven_reference', value);
}
