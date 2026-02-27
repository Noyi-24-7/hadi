import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/store_entity.dart';

part 'store_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StoreModel {
  const StoreModel({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.bannerUrl,
    this.logoUrl,
    this.rcNumber,
    this.isActive = true,
    this.storefrontSetupComplete = false,
  });

  final String id;
  final String name;
  final String? slug;
  final String? description;
  final String? bannerUrl;
  final String? logoUrl;
  final String? rcNumber;
  final bool isActive;
  final bool storefrontSetupComplete;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  StoreEntity toDomain() => StoreEntity(
        id: id,
        name: name,
        slug: slug,
        description: description,
        bannerUrl: bannerUrl,
        logoUrl: logoUrl,
        rcNumber: rcNumber,
        isActive: isActive,
        storefrontSetupComplete: storefrontSetupComplete,
      );

  static StoreModel fromDomain(StoreEntity entity) => StoreModel(
        id: entity.id,
        name: entity.name,
        slug: entity.slug,
        description: entity.description,
        bannerUrl: entity.bannerUrl,
        logoUrl: entity.logoUrl,
        rcNumber: entity.rcNumber,
        isActive: entity.isActive,
        storefrontSetupComplete: entity.storefrontSetupComplete,
      );
}
