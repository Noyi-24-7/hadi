import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_providers.dart';
import 'auth_state.dart';

part 'auth_state_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Watch auth state stream and update state accordingly
    ref.listen(authStateStreamProvider, (prev, next) {
      next.when(
        data: (profile) {
          if (profile != null) {
            state = AuthState.authenticated(profile);
          } else {
            state = const AuthState.unauthenticated();
          }
        },
        loading: () {
          // Only set loading if we're in initial state
          if (state == const AuthState.initial()) {
            state = const AuthState.loading();
          }
        },
        error: (err, stack) => state = AuthState.error(err.toString()),
      );
    });

    return const AuthState.initial();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    final result = await ref.read(signInUseCaseProvider).call(
          email: email,
          password: password,
        );
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (profile) => state = AuthState.authenticated(profile),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    state = const AuthState.loading();
    final result = await ref.read(signUpUseCaseProvider).call(
          email: email,
          password: password,
          fullName: fullName,
          phone: phone,
        );
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (profile) => state = AuthState.authenticated(profile),
    );
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    final result = await ref.read(signOutUseCaseProvider).call();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }

  Future<void> updateProfile({
    String? fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
  }) async {
    state = const AuthState.loading();
    final result = await ref.read(updateProfileUseCaseProvider).call(
          fullName: fullName,
          phone: phone,
          firstName: firstName,
          lastName: lastName,
          profileImageUrl: profileImageUrl,
        );
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (profile) => state = AuthState.authenticated(profile),
    );
  }
}
