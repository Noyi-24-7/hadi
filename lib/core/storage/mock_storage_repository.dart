import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import '../error/failure.dart';
import 'storage_repository.dart';

class MockStorageRepository implements StorageRepository {
  @override
  Future<Either<Failure, String>> uploadFile({
    required String bucketName,
    required String path,
    required Uint8List bytes,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final fakeId = const Uuid().v4();
    return right('https://mock-storage.supabase.co/storage/v1/object/public/$bucketName/$path?mockId=$fakeId');
  }
}
