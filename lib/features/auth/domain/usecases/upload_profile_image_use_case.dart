import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../repositories/auth_repository.dart';

class UploadProfileImageUseCase {
  const UploadProfileImageUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, String>> call(dynamic imageFile) {
    return _repository.uploadProfileImage(imageFile);
  }
}
