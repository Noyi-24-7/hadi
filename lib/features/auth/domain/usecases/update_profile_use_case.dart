import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/profile.dart';
import '../repositories/auth_repository.dart';

/// Use case for updating the current user's profile.
class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Profile>> call({
    String? fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
  }) {
    return _repository.updateProfile(
      fullName: fullName,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      profileImageUrl: profileImageUrl,
    );
  }
}
