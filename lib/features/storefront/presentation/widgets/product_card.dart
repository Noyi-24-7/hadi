import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../products/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.storeSlug,
  });

  final Product product;
  final String storeSlug;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.pushNamed(
            'Store_Product_Details_Page',
            pathParameters: {
              'slug': storeSlug,
              'productId': product.id,
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image (placeholder for now)
            Container(
              height: 150,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NGN ${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  if (product.stockQuantity != null &&
                      product.stockQuantity! > 0) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${product.stockQuantity} in stock',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
