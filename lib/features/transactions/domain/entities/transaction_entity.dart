import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  const TransactionEntity({
    required this.id,
    this.storeId,
    this.orderId,
    required this.type,
    required this.amount,
    this.currency = 'NGN',
    this.provider,
    this.reference,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String? storeId;
  final String? orderId;
  final String type;
  final double amount;
  final String currency;
  final String? provider;
  final String? reference;
  final String status;
  final DateTime? createdAt;

  @override
  List<Object?> get props =>
      [id, storeId, orderId, type, amount, currency, provider, reference, status, createdAt];
}

class PayoutEntity extends Equatable {
  const PayoutEntity({
    required this.id,
    required this.storeId,
    required this.amount,
    this.currency = 'NGN',
    this.provider,
    this.safehavenReference,
    required this.status,
    this.initiatedAt,
    this.paidAt,
  });

  final String id;
  final String storeId;
  final double amount;
  final String currency;
  final String? provider;
  final String? safehavenReference;
  final String status;
  final DateTime? initiatedAt;
  final DateTime? paidAt;

  @override
  List<Object?> get props =>
      [id, storeId, amount, currency, provider, safehavenReference, status, initiatedAt, paidAt];
}
