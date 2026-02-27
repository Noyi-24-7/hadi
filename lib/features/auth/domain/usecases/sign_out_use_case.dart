import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing out the current user.
class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Unit>> call() {
    return _repository.signOut();
  }
}
