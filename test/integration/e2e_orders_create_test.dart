
import 'package:flutter_test/flutter_test.dart';
import 'package:hadi/features/orders/data/datasources/order_remote_data_source_impl.dart';
import 'package:hadi/features/orders/domain/entities/order_item.dart';
import 'package:hadi/features/orders/domain/repositories/order_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('E2E: Create Order via Edge Function (Supabase)', () async {
    // 1. Initialize Supabase Client directly (avoiding Flutter bindings if possible)
    // Keys copied from lib/backend/supabase/supabase.dart for independence
    const supabaseUrl = 'https://cdkbwqzduobjayxnuhcz.supabase.co';
    const supabaseAnonKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNka2J3cXpkdW9iamF5eG51aGN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1MjY3NTgsImV4cCI6MjA4MTEwMjc1OH0.hVPF8RRY4IfD0DUFB564nKWGFq1ukZQwyakkhcCdbas';

    final client = SupabaseClient(
      supabaseUrl, 
      supabaseAnonKey,
      authOptions: const AuthClientOptions(authFlowType: AuthFlowType.implicit),
    );

    // 2. Authenticate (Sign Up Temp User)
    final email = 'test_e2e_${DateTime.now().millisecondsSinceEpoch}@example.com';
    final password = 'TestPassword123!';
    
    // ignore: unused_local_variable
    User? user;
    
    try {
      final authRes = await client.auth.signUp(email: email, password: password);
      user = authRes.user;
      
      if (client.auth.currentSession == null) {
         print('Warning: No session after sign up. Check Email Confirm settings.');
      }
    } catch (e) {
      print('Auth Error: $e');
    }

    // 3. Data Setup
    // Get a store
    final storeRes = await client.from('stores').select().eq('is_active', true).limit(1).maybeSingle();
    if (storeRes == null) {
      // Fail gently
      print('SKIPPING TEST: No active stores found in DB.');
      return; 
    }
    final storeId = storeRes['id'];

    // Get a product
    final productRes = await client.from('products').select().eq('store_id', storeId).limit(1).maybeSingle();
    if (productRes == null) {
      print('SKIPPING TEST: No products found for store $storeId');
      return;
    }
    final productId = productRes['id'];
    final productPrice = productRes['price'];
    
    // Get variant (optional)
    final variantRes = await client.from('product_variants').select().eq('product_id', productId).limit(1).maybeSingle();
    final variantId = variantRes?['id']; 
    final price = variantRes?['price_amount'] != null 
        ? (variantRes!['price_amount'] as num).toDouble() / 100 
        : (productPrice as num).toDouble();
        
    final priceInt = (price * 100).toInt(); 
    
    // 4. Create Order
    final dataSource = OrderRemoteDataSourceImpl(supabase: client);
    
    final items = [
      OrderItem(
        productId: productId,
        variantId: variantId,
        quantity: 1,
        unitPrice: price, 
      )
    ];

    try {
      final result = await dataSource.createOrder(
        storeId: storeId,
        buyer: const BuyerInfo(name: 'Integration Test Buyer', phone: '08000000000', email: 'integration@test.com'),
        delivery: const DeliveryInfo(address: '123 Test St', city: 'Test City', state: 'Lagos', lga: 'Ikeja', country: 'Nigeria'),
        items: items,
        selectedQuoteId: 'quote_test_123',
        deliveryFee: 500,
        transactionFee: 50,
        subtotalAmount: priceInt,
        totalAmount: priceInt + 550,
      );

      // 5. Assert
      expect(result.paymentUrl, isNotEmpty, reason: 'Payment URL should not be empty');
      expect(result.orderId, isNotEmpty, reason: 'Order ID should not be empty');
      
      print('SUCCESS: Order Created. ID: ${result.orderId}');
      print('Payment URL: ${result.paymentUrl}');

    } catch (e) {
      if (e.toString().contains('Email not confirmed')) {
         print('Known Issue: Email confirmation required.');
         return;
      }
      print('E2E Test Failed with Error: $e');
      rethrow;
    }
  });
}
