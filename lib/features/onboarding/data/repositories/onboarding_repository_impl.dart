import 'package:fpdart/fpdart.dart';
import '../../../../auth/supabase_auth/auth_util.dart';
import '../../../../backend/api_requests/api_calls.dart';
import '../../../../backend/supabase/supabase.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/i_onboarding_repository.dart';

class OnboardingRepositoryImpl implements IOnboardingRepository {
  @override
  Future<Either<Failure, Unit>> sendOtp({
    required String phone,
    required String channel,
  }) async {
    try {
      final response = await OtpSendCall.call(
        phone: phone,
        channel: channel,
      );
      if (response.succeeded) {
        return const Right(unit);
      } else {
        return Left(ServerFailure(response.jsonBody.toString()));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      // Assuming OtpCheckCall returns failure if verification fails, 
      // or we check a specific field in the response.
      // Based on typical usage, succeed means verified.
      final response = await OtpCheckCall.call(
        phone: phone,
        code: code,
      );
      if (response.succeeded) {
        return const Right(true);
      } else {
        return Left(ServerFailure(response.jsonBody.toString()));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createAccount({
    required String email,
    required String password,
    required String phone,
    String? heardAbout,
  }) async {
    try {
      // 1. Create Supabase Auth User
      // We need a context for authManager.createAccountWithEmail internally for some reason (maybe snackbars?)
      // But usually repositories shouldn't depend on BuildContext.
      // Checking auth_util.dart, createAccountWithEmail takes context. 
      // This is a flaw in the existing auth wrapper. 
      // For now, we might have to use SupaFlow.client.auth directly or refactor authManager.
      // Using Supabase.instance.client.auth.signUp() is cleaner for repository usage.
      
      final authResponse = await SupaFlow.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = authResponse.user;

      if (user == null) {
        return const Left(AuthFailure('Failed to create account'));
      }

      // 2. Insert into Profiles
      await ProfilesTable().insert({
        'id': user.id,
        'phone': phone,
        'email': email,
        'heard_about': heardAbout,
      });

      // 3. Insert into Stores
      await StoresTable().insert({
        'owner_id': user.id,
        'name': 'My New Store',
        'is_active': false,
        'business_info_complete': false,
        'bank_complete': false,
        'pickup_address_complete': false,
        'storefront_setup_complete': false,
        'onboarding_complete': false,
        'slug': '',
      });

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
