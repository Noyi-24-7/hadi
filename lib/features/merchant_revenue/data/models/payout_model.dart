import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/payout.dart';

part 'payout_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PayoutModel {
  const PayoutModel({
    required this.id,
    required this.storeId,
    required this.amount,
    required this.currency,
    this.provider,
    this.safehavenReference,
    required this.status,
    required this.initiatedAt,
    this.paidAt,
    this.meta,
  });

  final String id;
  final String storeId;
  final double amount;
  final String currency;
  final String? provider;
  final String? safehavenReference;
  final String status;
  final DateTime initiatedAt;
  final DateTime? paidAt;
  final Map<String, dynamic>? meta;

  factory PayoutModel.fromJson(Map<String, dynamic> json) =>
      _$PayoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$PayoutModelToJson(this);

  Payout toDomain() => Payout(
        id: id,
        storeId: storeId,
        amount: amount,
        currency: currency,
        provider: provider,
        safehavenReference: safehavenReference,
        status: status,
        initiatedAt: initiatedAt,
        paidAt: paidAt,
        meta: meta,
      );
}
