import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/profile.dart';

part 'profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileModel {
  const ProfileModel({
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
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime? createdAt;

  static DateTime? _dateTimeFromJson(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  Profile toDomain() => Profile(
        id: id,
        role: role,
        fullName: fullName,
        phone: phone,
        email: email,
        firstName: firstName,
        lastName: lastName,
        profileImageUrl: profileImageUrl,
        referralCode: referralCode,
        createdAt: createdAt,
      );
}
