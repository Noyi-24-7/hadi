import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/supabase_provider.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_profile_use_case.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../domain/usecases/sign_out_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/update_profile_use_case.dart';
import '../../domain/usecases/upload_profile_image_use_case.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
}

// Use cases
@riverpod
SignInUseCase signInUseCase(SignInUseCaseRef ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(SignOutUseCaseRef ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentProfileUseCase getCurrentProfileUseCase(
  GetCurrentProfileUseCaseRef ref,
) {
  return GetCurrentProfileUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
UpdateProfileUseCase updateProfileUseCase(UpdateProfileUseCaseRef ref) {
  return UpdateProfileUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
UploadProfileImageUseCase uploadProfileImageUseCase(UploadProfileImageUseCaseRef ref) {
  return UploadProfileImageUseCase(ref.watch(authRepositoryProvider));
}

// Current profile provider
@riverpod
Future<Profile?> currentProfile(CurrentProfileRef ref) async {
  // MOCK DATA FOR UI AUDIT
  await Future.delayed(const Duration(milliseconds: 500));
  return const Profile(
    id: 'mock-user-id',
    email: 'mock@example.com',
    firstName: 'Mock',
    lastName: 'User',
    role: 'merchant',
    profileImageUrl: 'https://via.placeholder.com/150',
  );
}

// Auth state stream provider
@riverpod
Stream<Profile?> authStateStream(AuthStateStreamRef ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.watchAuthState().asyncMap((opt) {
    return opt.fold(() => null, (p) => p);
  });
}
