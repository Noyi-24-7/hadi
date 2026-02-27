import 'package:equatable/equatable.dart';

/// Domain entity for user profile. No Supabase or framework types.
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.role,
    this.fullName,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
    this.referralCode,
    this.createdAt,
  });

  final String id;
  final String role;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;
  final String? referralCode;
  final DateTime? createdAt;

  @override
  List<Object?> get props =>
      [id, role, fullName, phone, email, firstName, lastName, profileImageUrl, referralCode, createdAt];
}
