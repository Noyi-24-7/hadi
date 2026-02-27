import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  const StoreEntity({
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

  @override
  List<Object?> get props => [id, name, slug, description, bannerUrl, logoUrl, rcNumber, isActive, storefrontSetupComplete];
}
