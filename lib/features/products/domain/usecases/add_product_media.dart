import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_media.dart';
import '../repositories/product_repository.dart';

class AddProductMedia {
  final ProductRepository _repository;

  AddProductMedia(this._repository);

  Future<Either<Failure, ProductMedia>> call({
    required String productId,
    required String storagePath,
    required String publicUrl,
    required String fileName,
    int? fileSize,
    required int sortOrder,
    required bool isVideo,
  }) {
    return _repository.addProductMedia(
      productId: productId,
      storagePath: storagePath,
      publicUrl: publicUrl,
      fileName: fileName,
      fileSize: fileSize,
      sortOrder: sortOrder,
      isVideo: isVideo,
    );
  }
}
