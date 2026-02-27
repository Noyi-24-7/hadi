import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../error/failure.dart';
import 'storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  final SupabaseClient _supabase;

  StorageRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, String>> uploadFile({
    required String bucketName,
    required String path,
    required Uint8List bytes,
  }) async {
    try {
      await _supabase.storage.from(bucketName).uploadBinary(
        path,
        bytes,
        fileOptions: const FileOptions(upsert: true),
      );
      final publicUrl = _supabase.storage.from(bucketName).getPublicUrl(path);
      return right(publicUrl);
    } on StorageException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
