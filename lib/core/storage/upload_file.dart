import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';
import 'storage_repository.dart';

class UploadFile {
  final StorageRepository _repository;

  UploadFile(this._repository);

  Future<Either<Failure, String>> call({
    required String bucketName,
    required String path,
    required Uint8List bytes,
  }) {
    return _repository.uploadFile(
      bucketName: bucketName,
      path: path,
      bytes: bytes,
    );
  }
}
