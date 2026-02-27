import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error.dart';
import '../../../products/domain/entities/product_variant.dart';
import '../repositories/storefront_repository.dart';

class GetProductVariantsUseCase {
  final StorefrontRepository repository;

  GetProductVariantsUseCase(this.repository);

  Future<Either<Failure, List<ProductVariant>>> call(String productId) {
    return repository.getProductVariants(productId);
  }
}
