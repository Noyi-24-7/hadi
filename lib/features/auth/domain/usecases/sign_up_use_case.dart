import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/profile.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing up with email and password.
class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Profile>> call({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) {
    return _repository.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );
  }
}
