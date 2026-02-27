import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hadi/features/storefront/domain/repositories/storefront_repository.dart';
import 'package:hadi/features/storefront/domain/usecases/get_product_variants.dart';
import 'package:hadi/features/products/domain/entities/product_variant.dart';

class MockStorefrontRepository extends Mock implements StorefrontRepository {}

void main() {
  late GetProductVariantsUseCase usecase;
  late MockStorefrontRepository mockRepository;

  setUp(() {
    mockRepository = MockStorefrontRepository();
    usecase = GetProductVariantsUseCase(mockRepository);
  });

  const tProductId = 'product_1';
  const tVariants = [
    ProductVariant(
        id: '1',
        productId: tProductId,
        size: 'M',
        color: 'Red',
        priceAmount: 10000, // 100.00
        quantity: 10,
        isActive: true)
  ];

  test('should get variants from the repository', () async {
    // arrange
    when(() => mockRepository.getProductVariants(any()))
        .thenAnswer((_) async => const Right(tVariants));

    // act
    final result = await usecase(tProductId);

    // assert
    expect(result, const Right(tVariants));
    verify(() => mockRepository.getProductVariants(tProductId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
