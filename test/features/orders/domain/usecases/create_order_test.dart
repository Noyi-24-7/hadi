
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hadi/core/error/failure.dart';
import 'package:hadi/features/orders/domain/entities/order.dart';
import 'package:hadi/features/orders/domain/entities/order_item.dart';
import 'package:hadi/features/orders/domain/repositories/order_repository.dart';
import 'package:hadi/features/orders/domain/usecases/create_order.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late CreateOrder useCase;
  late MockOrderRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(
      const BuyerInfo(name: '', phone: '', email: ''),
    );
    registerFallbackValue(
      const DeliveryInfo(address: '', city: '', state: '', lga: '', country: ''),
    );
    registerFallbackValue(<OrderItem>[]);
  });

  setUp(() {
    mockRepository = MockOrderRepository();
    useCase = CreateOrder(mockRepository);
  });

  const tStoreId = 'store_123';
  const tBuyer = BuyerInfo(
    email: 'test@example.com',
    name: 'Test Buyer',
    phone: '1234567890',
  );
  const tDelivery = DeliveryInfo(
    address: '123 Test St',
    city: 'Test City',
    state: 'Test State',
    lga: 'Test LGA',
    country: 'Test Country',
  );
  const List<OrderItem> tItems = [
    OrderItem(
      productId: 'prod_1',
      variantId: 'var_1',
      quantity: 1,
      unitPrice: 100,
      lineTotalAmount: 100,
    )
  ];
  const tSelectedQuoteId = 'quote_123';
  const tDeliveryFee = 50;
  const tTransactionFee = 10;
  const tSubtotalAmount = 100;
  const tTotalAmount = 160;

  final tResult = CreateOrderResult(orderId: 'order_123', paymentUrl: 'https://payment.url');

  test('should call createOrder on repository and return success result', () async {
    // Arrange
    when(() => mockRepository.createOrder(
          storeId: tStoreId,
          buyer: tBuyer,
          delivery: tDelivery,
          items: tItems,
          selectedQuoteId: tSelectedQuoteId,
          deliveryFee: tDeliveryFee,
          transactionFee: tTransactionFee,
          subtotalAmount: tSubtotalAmount,
          totalAmount: tTotalAmount,
        )).thenAnswer((_) async => Right(tResult));

    // Act
    final result = await useCase(
      storeId: tStoreId,
      buyer: tBuyer,
      delivery: tDelivery,
      items: tItems,
      selectedQuoteId: tSelectedQuoteId,
      deliveryFee: tDeliveryFee,
      transactionFee: tTransactionFee,
      subtotalAmount: tSubtotalAmount,
      totalAmount: tTotalAmount,
    );

    // Assert
    expect(result, Right(tResult));
    verify(() => mockRepository.createOrder(
          storeId: tStoreId,
          buyer: tBuyer,
          delivery: tDelivery,
          items: tItems,
          selectedQuoteId: tSelectedQuoteId,
          deliveryFee: tDeliveryFee,
          transactionFee: tTransactionFee,
          subtotalAmount: tSubtotalAmount,
          totalAmount: tTotalAmount,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository call fails', () async {
    // Arrange
    const tFailure = ServerFailure('Server Error');
    when(() => mockRepository.createOrder(
          storeId: tStoreId,
          buyer: tBuyer,
          delivery: tDelivery,
          items: tItems,
          selectedQuoteId: tSelectedQuoteId,
          deliveryFee: tDeliveryFee,
          transactionFee: tTransactionFee,
          subtotalAmount: tSubtotalAmount,
          totalAmount: tTotalAmount,
        )).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(
      storeId: tStoreId,
      buyer: tBuyer,
      delivery: tDelivery,
      items: tItems,
      selectedQuoteId: tSelectedQuoteId,
      deliveryFee: tDeliveryFee,
      transactionFee: tTransactionFee,
      subtotalAmount: tSubtotalAmount,
      totalAmount: tTotalAmount,
    );

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.createOrder(
          storeId: tStoreId,
          buyer: tBuyer,
          delivery: tDelivery,
          items: tItems,
          selectedQuoteId: tSelectedQuoteId,
          deliveryFee: tDeliveryFee,
          transactionFee: tTransactionFee,
          subtotalAmount: tSubtotalAmount,
          totalAmount: tTotalAmount,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
