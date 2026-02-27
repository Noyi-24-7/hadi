import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/onboarding_state.dart';
import '../../data/repositories/onboarding_repository_provider.dart';
import '../../../../core/error/failure.dart';

part 'onboarding_notifier.g.dart';

@Riverpod(keepAlive: true)
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  void setPhone(String phone) {
    state = state.copyWith(phoneNumber: phone, error: null);
  }

  void setChannel(String channel) {
    state = state.copyWith(selectedChannel: channel, error: null);
  }

  void setOtpCode(String code) {
    state = state.copyWith(otpCode: code, error: null);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email, error: null);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  void setHeardAbout(String heardAbout) {
    state = state.copyWith(heardAbout: heardAbout, error: null);
  }

  Future<void> sendOtp() async {
    state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(onboardingRepositoryProvider);
    final result = await repository.sendOtp(
      phone: state.phoneNumber,
      channel: state.selectedChannel,
    );
    state = result.fold(
      (l) => state.copyWith(isLoading: false, error: l.message),
      (r) => state.copyWith(isLoading: false),
    );
  }

  Future<bool> verifyOtp() async {
    state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(onboardingRepositoryProvider);
    final result = await repository.verifyOtp(
      phone: state.phoneNumber,
      code: state.otpCode,
    );
    
    return result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.message);
        return false;
      },
      (success) {
        state = state.copyWith(isLoading: false, isPhoneVerified: success);
        return success;
      },
    );
  }

  Future<bool> createAccount() async {
     state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(onboardingRepositoryProvider);
    final result = await repository.createAccount(
      email: state.email,
      password: state.password,
      phone: state.phoneNumber,
      heardAbout: state.heardAbout,
    );
    
    return result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.message);
        return false;
      },
      (r) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }
}
