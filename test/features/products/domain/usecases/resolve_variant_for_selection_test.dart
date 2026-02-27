
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hadi/core/error/failure.dart';
import 'package:hadi/features/products/domain/entities/product_variant.dart';
import 'package:hadi/features/products/domain/repositories/product_repository.dart';
import 'package:hadi/features/products/domain/usecases/resolve_variant_for_selection.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ResolveVariantForSelection useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = ResolveVariantForSelection(mockRepository);
  });

  const tProductId = 'prod_1';
  const tVariantId = 'var_1';
  
  const tVariantRedL = ProductVariant(
    id: tVariantId,
    productId: tProductId,
    size: 'L',
    color: 'Red',
    priceAmount: 100,
    quantity: 10,
    isActive: true,
  );

  const tVariantBlueM = ProductVariant(
    id: 'var_2',
    productId: tProductId,
    size: 'M',
    color: 'Blue',
    priceAmount: 100,
    quantity: 5,
    isActive: true,
  );

  const tVariantOutOfStock = ProductVariant(
    id: 'var_3',
    productId: tProductId,
    size: 'S',
    color: 'Green',
    priceAmount: 100,
    quantity: 0,
    isActive: true,
  );

  final tVariants = [tVariantRedL, tVariantBlueM, tVariantOutOfStock];

  test('should return matching variant when size and color match', () async {
    // Arrange
    when(() => mockRepository.getVariantsByProductId(any()))
        .thenAnswer((_) async => Right(tVariants));

    // Act
    final result = await useCase(
      productId: tProductId,
      size: 'L',
      color: 'Red',
    );

    // Assert
    expect(result, const Right(tVariantRedL));
    verify(() => mockRepository.getVariantsByProductId(tProductId)).called(1);
  });

  test('should return Failure when variant not found', () async {
    // Arrange
    when(() => mockRepository.getVariantsByProductId(any()))
        .thenAnswer((_) async => Right(tVariants));

    // Act
    final result = await useCase(
      productId: tProductId,
      size: 'XL',
      color: 'Red',
    );

    // Assert
    expect(result, const Left(ValidationFailure('Variant not found')));
    verify(() => mockRepository.getVariantsByProductId(tProductId)).called(1);
  });

  test('should return Failure when variant is out of stock', () async {
    // Arrange
    when(() => mockRepository.getVariantsByProductId(any()))
        .thenAnswer((_) async => Right(tVariants));

    // Act
    final result = await useCase(
      productId: tProductId,
      size: 'S',
      color: 'Green',
    );

    // Assert
    expect(result, const Left(ValidationFailure('Variant out of stock')));
    verify(() => mockRepository.getVariantsByProductId(tProductId)).called(1);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    const tFailure = ServerFailure('Server Error');
    when(() => mockRepository.getVariantsByProductId(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(
      productId: tProductId,
      size: 'L',
      color: 'Red',
    );

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getVariantsByProductId(tProductId)).called(1);
  });
}
