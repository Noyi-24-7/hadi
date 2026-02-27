// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SizeEntryStruct extends BaseStruct {
  SizeEntryStruct({
    String? label,
    double? price,
    int? qty,
  })  : _label = label,
        _price = price,
        _qty = qty;

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  set label(String? val) => _label = val;

  bool hasLabel() => _label != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "qty" field.
  int? _qty;
  int get qty => _qty ?? 0;
  set qty(int? val) => _qty = val;

  void incrementQty(int amount) => qty = qty + amount;

  bool hasQty() => _qty != null;

  static SizeEntryStruct fromMap(Map<String, dynamic> data) => SizeEntryStruct(
        label: data['label'] as String?,
        price: castToType<double>(data['price']),
        qty: castToType<int>(data['qty']),
      );

  static SizeEntryStruct? maybeFromMap(dynamic data) => data is Map
      ? SizeEntryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'label': _label,
        'price': _price,
        'qty': _qty,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'label': serializeParam(
          _label,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'qty': serializeParam(
          _qty,
          ParamType.int,
        ),
      }.withoutNulls;

  static SizeEntryStruct fromSerializableMap(Map<String, dynamic> data) =>
      SizeEntryStruct(
        label: deserializeParam(
          data['label'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        qty: deserializeParam(
          data['qty'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'SizeEntryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SizeEntryStruct &&
        label == other.label &&
        price == other.price &&
        qty == other.qty;
  }

  @override
  int get hashCode => const ListEquality().hash([label, price, qty]);
}

SizeEntryStruct createSizeEntryStruct({
  String? label,
  double? price,
  int? qty,
}) =>
    SizeEntryStruct(
      label: label,
      price: price,
      qty: qty,
    );
