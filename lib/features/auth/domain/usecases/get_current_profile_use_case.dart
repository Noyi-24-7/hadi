import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/profile.dart';
import '../repositories/auth_repository.dart';

/// Use case for getting the current user's profile.
class GetCurrentProfileUseCase {
  const GetCurrentProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Profile?>> call() {
    return _repository.getCurrentProfile();
  }
}
