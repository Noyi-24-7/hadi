import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/features/storefront/presentation/widgets/product_grid.dart';
import '/features/storefront/presentation/widgets/store_header.dart';
import '/features/cart/presentation/pages/cart_page.dart';

class StorefrontPage extends ConsumerWidget {
  const StorefrontPage({super.key, required this.storeSlug});

  final String storeSlug;

  static const routeName = 'Storefront_Page';
  static const routePath = '/s/:slug';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(storeProvider(storeSlug));

    return storeAsync.when(
      data: (store) {
        final productsAsync = ref.watch(storeProductsProvider(store.id));

        return Scaffold(
          appBar: AppBar(
            title: Text(store.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => context.pushNamed(CartPage.routeName),
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Share storefront link
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share feature coming soon')),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Store header with banner, logo, description
              StoreHeader(store: store),

              // Products grid
              Expanded(
                child: productsAsync.when(
                  data: (products) {
                    if (products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No products available',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Check back later for new products',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      );
                    }
                    return ProductGrid(
                      products: products,
                      storeSlug: storeSlug,
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 16),
                        Text('Error loading products: $error'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Store Not Found')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Store not found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'The store you\'re looking for doesn\'t exist or is inactive',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
