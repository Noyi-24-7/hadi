import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

abstract class StorageRepository {
  Future<Either<Failure, String>> uploadFile({
    required String bucketName,
    required String path,
    required Uint8List bytes,
  });
}
