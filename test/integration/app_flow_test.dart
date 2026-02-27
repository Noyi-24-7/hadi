
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hadi/features/cart/domain/entities/cart_item.dart';
import 'package:hadi/features/cart/presentation/providers/cart_providers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hadi/features/cart/domain/usecases/add_to_cart.dart';
import 'package:hadi/features/cart/domain/usecases/get_cart_items.dart'; // Corrected import
import 'package:hadi/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:hadi/features/cart/domain/usecases/update_cart_quantity.dart'; // Corrected import
import 'package:hadi/features/cart/domain/usecases/clear_cart.dart';
import 'package:hadi/features/cart/domain/usecases/get_cart_summary.dart';
import 'package:fpdart/fpdart.dart';

// Mock UseCases
class MockAddToCart extends Mock implements AddToCart {}
class MockGetCartItems extends Mock implements GetCartItems {} // Corrected name
class MockRemoveFromCart extends Mock implements RemoveFromCart {}
class MockUpdateCartQuantity extends Mock implements UpdateCartQuantity {} // Corrected name
class MockClearCart extends Mock implements ClearCart {}
class MockGetCartSummary extends Mock implements GetCartSummary {}

// Fake CartItem for mocktail
class FakeCartItem extends Fake implements CartItem {}

void main() {
  late MockAddToCart mockAddToCart;
  late MockGetCartItems mockGetCartItems;
  late MockRemoveFromCart mockRemoveFromCart;
  late MockUpdateCartQuantity mockUpdateCartQuantity;
  late MockClearCart mockClearCart;
  late MockGetCartSummary mockGetCartSummary;

  setUpAll(() {
    registerFallbackValue(FakeCartItem());
  });

  setUp(() {
    mockAddToCart = MockAddToCart();
    mockGetCartItems = MockGetCartItems();
    mockRemoveFromCart = MockRemoveFromCart();
    mockUpdateCartQuantity = MockUpdateCartQuantity();
    mockClearCart = MockClearCart();
    mockGetCartSummary = MockGetCartSummary();
  });

  test('Cart Flow: Add Item to Cart UseCase Integration', () async {
    // Arrange
    final container = ProviderContainer(
      overrides: [
        addToCartProvider.overrideWith((ref) => mockAddToCart),
        getCartItemsProvider.overrideWith((ref) => mockGetCartItems),
        removeFromCartProvider.overrideWith((ref) => mockRemoveFromCart),
        updateCartQuantityProvider.overrideWith((ref) => mockUpdateCartQuantity),
        clearCartProvider.overrideWith((ref) => mockClearCart),
        getCartSummaryProvider.overrideWith((ref) => mockGetCartSummary),
      ],
    );
    addTearDown(container.dispose);

    const tProductId = 'prod_1';
    final tItem = CartItem(
      productId: tProductId,
      productName: 'Test Product',
      quantity: 2,
      unitPrice: 100.0,
      availableStock: 10,
    );

    when(() => mockAddToCart.call(any())).thenAnswer((_) async => const Right(unit));

    // Act
    // Simulate UI interaction: obtain useCase from provider and call it
    final addToCartUseCase = await container.read(addToCartProvider.future);
    await addToCartUseCase.call(tItem);

    // Assert
    verify(() => mockAddToCart.call(any())).called(1);
  });
}
