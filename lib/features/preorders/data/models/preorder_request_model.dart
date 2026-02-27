import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/preorder_request.dart';

part 'preorder_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreorderRequestModel {
  const PreorderRequestModel({
    required this.id,
    required this.storeId,
    required this.productId,
    this.productVariantId,
    required this.quantity,
    required this.status,
    this.terminalShipmentId,
    this.trackingUrl,
    this.trackingEvents,
    this.requestedAt,
    this.lastResentAt,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String storeId;
  final String productId;
  final String? productVariantId;
  final int quantity;
  final String status;
  final String? terminalShipmentId;
  final String? trackingUrl;
  final List<dynamic>? trackingEvents;
  final DateTime? requestedAt;
  final DateTime? lastResentAt;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PreorderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PreorderRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreorderRequestModelToJson(this);

  PreorderRequest toDomain() => PreorderRequest(
        id: id,
        storeId: storeId,
        productId: productId,
        productVariantId: productVariantId,
        quantity: quantity,
        status: status,
        terminalShipmentId: terminalShipmentId,
        trackingUrl: trackingUrl,
        trackingEvents: trackingEvents,
      );
}
