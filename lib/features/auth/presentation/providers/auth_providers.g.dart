// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'9e5cec384bd32dfc5b5f5b9d8f094e42161e62e1';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'571ed5da8d84c80603a93178ad3ee568cf1dc67e';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$signInUseCaseHash() => r'd8c4ca8799d3c785d724fcb12259fb8cb5c6f7aa';

/// See also [signInUseCase].
@ProviderFor(signInUseCase)
final signInUseCaseProvider = AutoDisposeProvider<SignInUseCase>.internal(
  signInUseCase,
  name: r'signInUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignInUseCaseRef = AutoDisposeProviderRef<SignInUseCase>;
String _$signUpUseCaseHash() => r'4201daf5f96493848da629b32fddadef84544cd7';

/// See also [signUpUseCase].
@ProviderFor(signUpUseCase)
final signUpUseCaseProvider = AutoDisposeProvider<SignUpUseCase>.internal(
  signUpUseCase,
  name: r'signUpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signUpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignUpUseCaseRef = AutoDisposeProviderRef<SignUpUseCase>;
String _$signOutUseCaseHash() => r'3e06d6c315dc4710dd995e6114538ae28f4c3336';

/// See also [signOutUseCase].
@ProviderFor(signOutUseCase)
final signOutUseCaseProvider = AutoDisposeProvider<SignOutUseCase>.internal(
  signOutUseCase,
  name: r'signOutUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signOutUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SignOutUseCaseRef = AutoDisposeProviderRef<SignOutUseCase>;
String _$getCurrentProfileUseCaseHash() =>
    r'62fa4cbf44b689aca9ed7e2398d922e177aec54d';

/// See also [getCurrentProfileUseCase].
@ProviderFor(getCurrentProfileUseCase)
final getCurrentProfileUseCaseProvider =
    AutoDisposeProvider<GetCurrentProfileUseCase>.internal(
  getCurrentProfileUseCase,
  name: r'getCurrentProfileUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentProfileUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCurrentProfileUseCaseRef
    = AutoDisposeProviderRef<GetCurrentProfileUseCase>;
String _$updateProfileUseCaseHash() =>
    r'05af46fd24a203bb7874fcbb33455b3cbc48cf34';

/// See also [updateProfileUseCase].
@ProviderFor(updateProfileUseCase)
final updateProfileUseCaseProvider =
    AutoDisposeProvider<UpdateProfileUseCase>.internal(
  updateProfileUseCase,
  name: r'updateProfileUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateProfileUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpdateProfileUseCaseRef = AutoDisposeProviderRef<UpdateProfileUseCase>;
String _$uploadProfileImageUseCaseHash() =>
    r'bbaf0bfb3197198cfe54bee3dabe9ffc506b5cec';

/// See also [uploadProfileImageUseCase].
@ProviderFor(uploadProfileImageUseCase)
final uploadProfileImageUseCaseProvider =
    AutoDisposeProvider<UploadProfileImageUseCase>.internal(
  uploadProfileImageUseCase,
  name: r'uploadProfileImageUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uploadProfileImageUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UploadProfileImageUseCaseRef
    = AutoDisposeProviderRef<UploadProfileImageUseCase>;
String _$currentProfileHash() => r'b32b60b6bf2b69c987da2d3ec1512d78d24b2013';

/// See also [currentProfile].
@ProviderFor(currentProfile)
final currentProfileProvider = AutoDisposeFutureProvider<Profile?>.internal(
  currentProfile,
  name: r'currentProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentProfileRef = AutoDisposeFutureProviderRef<Profile?>;
String _$authStateStreamHash() => r'e9e73007ca20d9d9aaf36b6f5f1a30354910c356';

/// See also [authStateStream].
@ProviderFor(authStateStream)
final authStateStreamProvider = AutoDisposeStreamProvider<Profile?>.internal(
  authStateStream,
  name: r'authStateStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateStreamRef = AutoDisposeStreamProviderRef<Profile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
