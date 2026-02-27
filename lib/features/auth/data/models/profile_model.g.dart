// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as String,
      role: json['role'] as String,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      referralCode: json['referral_code'] as String?,
      createdAt: ProfileModel._dateTimeFromJson(json['created_at']),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'profile_image_url': instance.profileImageUrl,
      'referral_code': instance.referralCode,
      'created_at': instance.createdAt?.toIso8601String(),
    };
