import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/supabase_provider.dart';
import '../../../app_config.dart';
import 'storage_repository.dart';
import 'storage_repository_impl.dart';
import 'mock_storage_repository.dart';
import 'upload_file.dart';

final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  if (AppConfig.isMockMode) {
    return MockStorageRepository();
  }
  return StorageRepositoryImpl(
    ref.watch(supabaseClientProvider),
  );
});

final uploadFileProvider = Provider<UploadFile>((ref) {
  return UploadFile(ref.watch(storageRepositoryProvider));
});
