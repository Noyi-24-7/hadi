import 'package:equatable/equatable.dart';

class Payout extends Equatable {
  const Payout({
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
  final String status; // pending, processing, paid, failed, reversed
  final DateTime initiatedAt;
  final DateTime? paidAt;
  final Map<String, dynamic>? meta;

  @override
  List<Object?> get props => [
        id,
        storeId,
        amount,
        currency,
        provider,
        safehavenReference,
        status,
        initiatedAt,
        paidAt,
        meta,
      ];
}
