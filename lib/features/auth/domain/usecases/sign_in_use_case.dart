import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/profile.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing in with email and password.
class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Profile>> call({
    required String email,
    required String password,
  }) {
    return _repository.signInWithEmail(
      email: email,
      password: password,
    );
  }
}
