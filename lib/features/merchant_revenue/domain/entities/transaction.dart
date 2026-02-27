import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.storeId,
    this.orderId,
    required this.type,
    required this.amount,
    required this.currency,
    this.provider,
    this.reference,
    required this.status,
    this.meta,
    required this.createdAt,
  });

  final String id;
  final String storeId;
  final String? orderId;
  final String type; // order_payment, fee, payout, refund, adjustment
  final double amount;
  final String currency;
  final String? provider;
  final String? reference;
  final String status; // pending, successful, failed, reversed
  final Map<String, dynamic>? meta;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        storeId,
        orderId,
        type,
        amount,
        currency,
        provider,
        reference,
        status,
        meta,
        createdAt,
      ];
}
