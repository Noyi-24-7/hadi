import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/i_onboarding_repository.dart';
import 'onboarding_repository_impl.dart';

part 'onboarding_repository_provider.g.dart';

@riverpod
IOnboardingRepository onboardingRepository(OnboardingRepositoryRef ref) {
  return OnboardingRepositoryImpl();
}
