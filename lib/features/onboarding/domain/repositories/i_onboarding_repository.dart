import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';

abstract class IOnboardingRepository {
  Future<Either<Failure, Unit>> sendOtp({
    required String phone,
    required String channel,
  });

  Future<Either<Failure, bool>> verifyOtp({
    required String phone,
    required String code,
  });

  Future<Either<Failure, Unit>> createAccount({
    required String email,
    required String password,
    required String phone,
    String? heardAbout,
  });
}
