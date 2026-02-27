
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hadi/core/error/failure.dart';
import 'package:hadi/features/cart/domain/entities/cart_item.dart';
import 'package:hadi/features/cart/domain/repositories/cart_repository.dart';
import 'package:hadi/features/cart/domain/usecases/get_cart_summary.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late GetCartSummary useCase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    useCase = GetCartSummary(mockRepository);
  });

  const tCartItem1 = CartItem(
    productId: 'p1',
    productName: 'Product 1',
    unitPrice: 100,
    quantity: 2,
    availableStock: 10,
    imageUrl: 'url1',
  );

  const tCartItem2 = CartItem(
    productId: 'p2',
    productName: 'Product 2',
    unitPrice: 50,
    quantity: 1,
    availableStock: 5,
    imageUrl: 'url2',
  );

  const tItems = [tCartItem1, tCartItem2];
  // Item 1: 100 * 2 = 200
  // Item 2: 50 * 1 = 50
  // Subtotal = 250
  // Total Items = 3
  const tCartSummary = CartSummary(
    items: tItems,
    subtotal: 250,
    totalItems: 3,
  );

  test('should return correct CartSummary when repository returns items', () async {
    // Arrange
    when(() => mockRepository.getItems()).thenAnswer((_) async => const Right(tItems));

    // Act
    final result = await useCase();

    // Assert
    expect(result, const Right(tCartSummary));
    verify(() => mockRepository.getItems()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return empty CartSummary when repository returns empty list', () async {
    // Arrange
    when(() => mockRepository.getItems()).thenAnswer((_) async => const Right([]));
    
    const tEmptySummary = CartSummary(
      items: [],
      subtotal: 0,
      totalItems: 0,
    );

    // Act
    final result = await useCase();

    // Assert
    expect(result, const Right(tEmptySummary));
    verify(() => mockRepository.getItems()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    const tFailure = ServerFailure('Server Error');
    when(() => mockRepository.getItems()).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase();

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getItems()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
