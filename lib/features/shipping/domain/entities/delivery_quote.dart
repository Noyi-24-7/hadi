import 'package:equatable/equatable.dart';

class DeliveryQuote extends Equatable {
  const DeliveryQuote({
    required this.id,
    required this.serviceLevel,
    required this.providerName,
    required this.priceAmount,
    this.currency = 'NGN',
    this.etaText,
  });

  final String id;
  final String serviceLevel;
  final String providerName;
  final int priceAmount;
  final String currency;
  final String? etaText;

  @override
  List<Object?> get props => [id, serviceLevel, providerName, priceAmount, currency, etaText];
}
