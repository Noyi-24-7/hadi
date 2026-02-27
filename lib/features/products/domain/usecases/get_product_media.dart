import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_media.dart';
import '../repositories/product_repository.dart';

class GetProductMedia {
  final ProductRepository _repository;

  GetProductMedia(this._repository);

  Future<Either<Failure, List<ProductMedia>>> call(String productId) {
    return _repository.getProductMedia(productId);
  }
}
