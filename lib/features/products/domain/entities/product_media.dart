class ProductMedia {
  final String? id;
  final String productId;
  final String storagePath;
  final String publicUrl;
  final String fileName;
  final int? fileSize;
  final int sortOrder;
  final bool isVideo;
  final DateTime? createdAt;

  const ProductMedia({
    this.id,
    required this.productId,
    required this.storagePath,
    required this.publicUrl,
    required this.fileName,
    this.fileSize,
    required this.sortOrder,
    required this.isVideo,
    this.createdAt,
  });
}
