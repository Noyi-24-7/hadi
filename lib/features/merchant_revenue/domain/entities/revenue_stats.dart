import 'package:equatable/equatable.dart';

class RevenueStats extends Equatable {
  const RevenueStats({
    required this.totalRevenue,
    required this.totalItemsSold,
    required this.currency,
  });

  final double totalRevenue;
  final int totalItemsSold;
  final String currency;

  @override
  List<Object?> get props => [totalRevenue, totalItemsSold, currency];
}
