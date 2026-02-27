import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:universal_io/io.dart';

import '../models/profile_model.dart';

abstract class AuthRemoteDataSource {
  User? get currentUser;
  Future<ProfileModel?> getProfileByUserId(String userId);
  Future<void> signOut();
  Stream<AuthState> get authStateChanges;

  Future<AuthResponse> signInWithEmail(String email, String password);
  Future<AuthResponse> signUpWithEmail(String email, String password);
  Future<ProfileModel> createProfile({
    required String userId,
    required String email,
    required String fullName,
    String? phone,
  });
  Future<ProfileModel> updateProfile({
    required String userId,
    String? fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
  });
  Future<String> uploadProfileImage({required String userId, required dynamic imageFile});
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  User? get currentUser => _supabase.auth.currentUser;

  @override
  Future<ProfileModel?> getProfileByUserId(String userId) async {
    final res = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
    if (res == null) return null;
    return ProfileModel.fromJson(res);
  }

  @override
  Future<void> signOut() => _supabase.auth.signOut();

  @override
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) {
    return _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUpWithEmail(String email, String password) {
    return _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<ProfileModel> createProfile({
    required String userId,
    required String email,
    required String fullName,
    String? phone,
  }) async {
    final data = await _supabase.from('profiles').insert({
      'id': userId,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'role': 'buyer', // Default role
    }).select().single();

    return ProfileModel.fromJson(data);
  }

  @override
  Future<ProfileModel> updateProfile({
    required String userId,
    String? fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
  }) async {
    final updates = <String, dynamic>{};
    if (fullName != null) updates['full_name'] = fullName;
    if (phone != null) updates['phone'] = phone;
    if (firstName != null) updates['first_name'] = firstName;
    if (lastName != null) updates['last_name'] = lastName;
    if (profileImageUrl != null) updates['profile_image_url'] = profileImageUrl;

    final data = await _supabase
        .from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return ProfileModel.fromJson(data);
  }

  @override
  Future<String> uploadProfileImage({required String userId, required dynamic imageFile}) async {
    final file = imageFile as File;
    final fileExt = file.path.split('.').last;
    final fileName = '$userId/profile_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

    await _supabase.storage.from('avatars').upload(
          fileName,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    return _supabase.storage.from('avatars').getPublicUrl(fileName);
  }
}
