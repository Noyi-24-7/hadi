// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductMediaEntryStruct2Struct extends BaseStruct {
  ProductMediaEntryStruct2Struct({
    String? id,
    String? productId,
    String? fileName,
    int? fileSize,
    String? publicUrl,
    String? imagePath,
    String? videoPath,
    String? path,
    String? mediaType,
    int? sortOrder,
  })  : _id = id,
        _productId = productId,
        _fileName = fileName,
        _fileSize = fileSize,
        _publicUrl = publicUrl,
        _imagePath = imagePath,
        _videoPath = videoPath,
        _path = path,
        _mediaType = mediaType,
        _sortOrder = sortOrder;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "productId" field.
  String? _productId;
  String get productId => _productId ?? '';
  set productId(String? val) => _productId = val;

  bool hasProductId() => _productId != null;

  // "fileName" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  set fileName(String? val) => _fileName = val;

  bool hasFileName() => _fileName != null;

  // "fileSize" field.
  int? _fileSize;
  int get fileSize => _fileSize ?? 0;
  set fileSize(int? val) => _fileSize = val;

  void incrementFileSize(int amount) => fileSize = fileSize + amount;

  bool hasFileSize() => _fileSize != null;

  // "publicUrl" field.
  String? _publicUrl;
  String get publicUrl => _publicUrl ?? '';
  set publicUrl(String? val) => _publicUrl = val;

  bool hasPublicUrl() => _publicUrl != null;

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  set imagePath(String? val) => _imagePath = val;

  bool hasImagePath() => _imagePath != null;

  // "videoPath" field.
  String? _videoPath;
  String get videoPath => _videoPath ?? '';
  set videoPath(String? val) => _videoPath = val;

  bool hasVideoPath() => _videoPath != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "mediaType" field.
  String? _mediaType;
  String get mediaType => _mediaType ?? '';
  set mediaType(String? val) => _mediaType = val;

  bool hasMediaType() => _mediaType != null;

  // "sortOrder" field.
  int? _sortOrder;
  int get sortOrder => _sortOrder ?? 0;
  set sortOrder(int? val) => _sortOrder = val;

  void incrementSortOrder(int amount) => sortOrder = sortOrder + amount;

  bool hasSortOrder() => _sortOrder != null;

  static ProductMediaEntryStruct2Struct fromMap(Map<String, dynamic> data) =>
      ProductMediaEntryStruct2Struct(
        id: data['id'] as String?,
        productId: data['productId'] as String?,
        fileName: data['fileName'] as String?,
        fileSize: castToType<int>(data['fileSize']),
        publicUrl: data['publicUrl'] as String?,
        imagePath: data['imagePath'] as String?,
        videoPath: data['videoPath'] as String?,
        path: data['path'] as String?,
        mediaType: data['mediaType'] as String?,
        sortOrder: castToType<int>(data['sortOrder']),
      );

  static ProductMediaEntryStruct2Struct? maybeFromMap(dynamic data) =>
      data is Map
          ? ProductMediaEntryStruct2Struct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'productId': _productId,
        'fileName': _fileName,
        'fileSize': _fileSize,
        'publicUrl': _publicUrl,
        'imagePath': _imagePath,
        'videoPath': _videoPath,
        'path': _path,
        'mediaType': _mediaType,
        'sortOrder': _sortOrder,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'productId': serializeParam(
          _productId,
          ParamType.String,
        ),
        'fileName': serializeParam(
          _fileName,
          ParamType.String,
        ),
        'fileSize': serializeParam(
          _fileSize,
          ParamType.int,
        ),
        'publicUrl': serializeParam(
          _publicUrl,
          ParamType.String,
        ),
        'imagePath': serializeParam(
          _imagePath,
          ParamType.String,
        ),
        'videoPath': serializeParam(
          _videoPath,
          ParamType.String,
        ),
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'mediaType': serializeParam(
          _mediaType,
          ParamType.String,
        ),
        'sortOrder': serializeParam(
          _sortOrder,
          ParamType.int,
        ),
      }.withoutNulls;

  static ProductMediaEntryStruct2Struct fromSerializableMap(
          Map<String, dynamic> data) =>
      ProductMediaEntryStruct2Struct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        productId: deserializeParam(
          data['productId'],
          ParamType.String,
          false,
        ),
        fileName: deserializeParam(
          data['fileName'],
          ParamType.String,
          false,
        ),
        fileSize: deserializeParam(
          data['fileSize'],
          ParamType.int,
          false,
        ),
        publicUrl: deserializeParam(
          data['publicUrl'],
          ParamType.String,
          false,
        ),
        imagePath: deserializeParam(
          data['imagePath'],
          ParamType.String,
          false,
        ),
        videoPath: deserializeParam(
          data['videoPath'],
          ParamType.String,
          false,
        ),
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        mediaType: deserializeParam(
          data['mediaType'],
          ParamType.String,
          false,
        ),
        sortOrder: deserializeParam(
          data['sortOrder'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ProductMediaEntryStruct2Struct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductMediaEntryStruct2Struct &&
        id == other.id &&
        productId == other.productId &&
        fileName == other.fileName &&
        fileSize == other.fileSize &&
        publicUrl == other.publicUrl &&
        imagePath == other.imagePath &&
        videoPath == other.videoPath &&
        path == other.path &&
        mediaType == other.mediaType &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        productId,
        fileName,
        fileSize,
        publicUrl,
        imagePath,
        videoPath,
        path,
        mediaType,
        sortOrder
      ]);
}

ProductMediaEntryStruct2Struct createProductMediaEntryStruct2Struct({
  String? id,
  String? productId,
  String? fileName,
  int? fileSize,
  String? publicUrl,
  String? imagePath,
  String? videoPath,
  String? path,
  String? mediaType,
  int? sortOrder,
}) =>
    ProductMediaEntryStruct2Struct(
      id: id,
      productId: productId,
      fileName: fileName,
      fileSize: fileSize,
      publicUrl: publicUrl,
      imagePath: imagePath,
      videoPath: videoPath,
      path: path,
      mediaType: mediaType,
      sortOrder: sortOrder,
    );
