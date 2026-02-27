import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remote = remoteDataSource;

  final AuthRemoteDataSource _remote;

  @override
  Future<Either<Failure, Profile?>> getCurrentProfile() async {
    try {
      final user = _remote.currentUser;
      if (user == null) return right(null);
      final model = await _remote.getProfileByUserId(user.id);
      return right(model?.toDomain());
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _remote.signOut();
      return right(unit);
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Option<Profile?>> watchAuthState() async* {
    await for (final state in _remote.authStateChanges) {
      final user = state.session?.user;
      if (user == null) {
        yield none();
        continue;
      }
      try {
        final model = await _remote.getProfileByUserId(user.id);
        yield some(model?.toDomain());
      } catch (_) {
        yield some(null);
      }
    }
  }

  @override
  Future<Either<Failure, Profile>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.signInWithEmail(email, password);
      final user = response.user;
      if (user == null) {
        return left(const AuthFailure('Sign in failed: no user returned'));
      }

      final model = await _remote.getProfileByUserId(user.id);
      if (model == null) {
        return left(const AuthFailure('Profile not found'));
      }

      return right(model.toDomain());
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    try {
      final response = await _remote.signUpWithEmail(email, password);
      final user = response.user;
      if (user == null) {
        return left(const AuthFailure('Sign up failed: no user returned'));
      }

      // Create profile in profiles table
      final model = await _remote.createProfile(
        userId: user.id,
        email: email,
        fullName: fullName,
        phone: phone,
      );

      return right(model.toDomain());
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile({
    String? fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
  }) async {
    try {
      final user = _remote.currentUser;
      if (user == null) {
        return left(const AuthFailure('No authenticated user'));
      }

      final model = await _remote.updateProfile(
        userId: user.id,
        fullName: fullName,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        profileImageUrl: profileImageUrl,
      );

      return right(model.toDomain());
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(dynamic imageFile) async {
    try {
      final user = _remote.currentUser;
      if (user == null) {
        return left(const AuthFailure('No authenticated user'));
      }

      final imageUrl = await _remote.uploadProfileImage(
        userId: user.id,
        imageFile: imageFile,
      );

      return right(imageUrl);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
