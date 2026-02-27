// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      bannerUrl: json['banner_url'] as String?,
      logoUrl: json['logo_url'] as String?,
      rcNumber: json['rc_number'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      storefrontSetupComplete:
          json['storefront_setup_complete'] as bool? ?? false,
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'banner_url': instance.bannerUrl,
      'logo_url': instance.logoUrl,
      'rc_number': instance.rcNumber,
      'is_active': instance.isActive,
      'storefront_setup_complete': instance.storefrontSetupComplete,
    };
