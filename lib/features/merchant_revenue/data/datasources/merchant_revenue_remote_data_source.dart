import '../models/payout_model.dart';
import '../models/transaction_model.dart';

abstract class MerchantRevenueRemoteDataSource {
  Future<List<TransactionModel>> getTransactions({
    required String storeId,
    String? type,
  });

  Future<List<PayoutModel>> getPayouts(String storeId);

  Future<Map<String, dynamic>> getRevenueStats(String storeId);
}
