import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/profile.dart';

abstract class AuthRepository {
  Future<Either<Failure, Profile?>> getCurrentProfile();
  Future<Either<Failure, Unit>> signOut();
  Stream<Option<Profile?>> watchAuthState();

  Future<Either<Failure, Profile>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  });

  Future<Either<Failure, Profile>> updateProfile({
    String? fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
  });

  Future<Either<Failure, String>> uploadProfileImage(dynamic imageFile);
}
