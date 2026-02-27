import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default('') String phoneNumber,
    @Default('') String selectedChannel, // 'sms' or 'whatsapp'
    @Default('') String otpCode,
    @Default(false) bool isPhoneVerified,
    @Default('') String email,
    @Default('') String password,
    @Default('') String heardAbout,
    @Default(false) bool isLoading,
    @Default(null) String? error,
  }) = _OnboardingState;
}
