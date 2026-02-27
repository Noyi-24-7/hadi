// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductMediaEntryStructStruct extends BaseStruct {
  ProductMediaEntryStructStruct({
    String? url,
    String? fileName,
    int? bytes,
    bool? isVideo,
    String? storagePath,
  })  : _url = url,
        _fileName = fileName,
        _bytes = bytes,
        _isVideo = isVideo,
        _storagePath = storagePath;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  // "fileName" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  set fileName(String? val) => _fileName = val;

  bool hasFileName() => _fileName != null;

  // "bytes" field.
  int? _bytes;
  int get bytes => _bytes ?? 0;
  set bytes(int? val) => _bytes = val;

  void incrementBytes(int amount) => bytes = bytes + amount;

  bool hasBytes() => _bytes != null;

  // "isVideo" field.
  bool? _isVideo;
  bool get isVideo => _isVideo ?? false;
  set isVideo(bool? val) => _isVideo = val;

  bool hasIsVideo() => _isVideo != null;

  // "storagePath" field.
  String? _storagePath;
  String get storagePath => _storagePath ?? '';
  set storagePath(String? val) => _storagePath = val;

  bool hasStoragePath() => _storagePath != null;

  static ProductMediaEntryStructStruct fromMap(Map<String, dynamic> data) =>
      ProductMediaEntryStructStruct(
        url: data['url'] as String?,
        fileName: data['fileName'] as String?,
        bytes: castToType<int>(data['bytes']),
        isVideo: data['isVideo'] as bool?,
        storagePath: data['storagePath'] as String?,
      );

  static ProductMediaEntryStructStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? ProductMediaEntryStructStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'url': _url,
        'fileName': _fileName,
        'bytes': _bytes,
        'isVideo': _isVideo,
        'storagePath': _storagePath,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'fileName': serializeParam(
          _fileName,
          ParamType.String,
        ),
        'bytes': serializeParam(
          _bytes,
          ParamType.int,
        ),
        'isVideo': serializeParam(
          _isVideo,
          ParamType.bool,
        ),
        'storagePath': serializeParam(
          _storagePath,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProductMediaEntryStructStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ProductMediaEntryStructStruct(
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        fileName: deserializeParam(
          data['fileName'],
          ParamType.String,
          false,
        ),
        bytes: deserializeParam(
          data['bytes'],
          ParamType.int,
          false,
        ),
        isVideo: deserializeParam(
          data['isVideo'],
          ParamType.bool,
          false,
        ),
        storagePath: deserializeParam(
          data['storagePath'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ProductMediaEntryStructStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductMediaEntryStructStruct &&
        url == other.url &&
        fileName == other.fileName &&
        bytes == other.bytes &&
        isVideo == other.isVideo &&
        storagePath == other.storagePath;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([url, fileName, bytes, isVideo, storagePath]);
}

ProductMediaEntryStructStruct createProductMediaEntryStructStruct({
  String? url,
  String? fileName,
  int? bytes,
  bool? isVideo,
  String? storagePath,
}) =>
    ProductMediaEntryStructStruct(
      url: url,
      fileName: fileName,
      bytes: bytes,
      isVideo: isVideo,
      storagePath: storagePath,
    );
