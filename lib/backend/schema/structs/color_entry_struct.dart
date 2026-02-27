// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ColorEntryStruct extends BaseStruct {
  ColorEntryStruct({
    String? label,
    String? sizeLabel,
    int? qty,
  })  : _label = label,
        _sizeLabel = sizeLabel,
        _qty = qty;

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  set label(String? val) => _label = val;

  bool hasLabel() => _label != null;

  // "sizeLabel" field.
  String? _sizeLabel;
  String get sizeLabel => _sizeLabel ?? '';
  set sizeLabel(String? val) => _sizeLabel = val;

  bool hasSizeLabel() => _sizeLabel != null;

  // "qty" field.
  int? _qty;
  int get qty => _qty ?? 0;
  set qty(int? val) => _qty = val;

  void incrementQty(int amount) => qty = qty + amount;

  bool hasQty() => _qty != null;

  static ColorEntryStruct fromMap(Map<String, dynamic> data) =>
      ColorEntryStruct(
        label: data['label'] as String?,
        sizeLabel: data['sizeLabel'] as String?,
        qty: castToType<int>(data['qty']),
      );

  static ColorEntryStruct? maybeFromMap(dynamic data) => data is Map
      ? ColorEntryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'label': _label,
        'sizeLabel': _sizeLabel,
        'qty': _qty,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'label': serializeParam(
          _label,
          ParamType.String,
        ),
        'sizeLabel': serializeParam(
          _sizeLabel,
          ParamType.String,
        ),
        'qty': serializeParam(
          _qty,
          ParamType.int,
        ),
      }.withoutNulls;

  static ColorEntryStruct fromSerializableMap(Map<String, dynamic> data) =>
      ColorEntryStruct(
        label: deserializeParam(
          data['label'],
          ParamType.String,
          false,
        ),
        sizeLabel: deserializeParam(
          data['sizeLabel'],
          ParamType.String,
          false,
        ),
        qty: deserializeParam(
          data['qty'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ColorEntryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ColorEntryStruct &&
        label == other.label &&
        sizeLabel == other.sizeLabel &&
        qty == other.qty;
  }

  @override
  int get hashCode => const ListEquality().hash([label, sizeLabel, qty]);
}

ColorEntryStruct createColorEntryStruct({
  String? label,
  String? sizeLabel,
  int? qty,
}) =>
    ColorEntryStruct(
      label: label,
      sizeLabel: sizeLabel,
      qty: qty,
    );
