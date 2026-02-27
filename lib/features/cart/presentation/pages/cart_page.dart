import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/features/cart/presentation/providers/cart_providers.dart';
import '../../domain/entities/cart_item.dart';
import '/pages/deliveryonly_page/checkout_1_page/checkout1_page_widget.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  static const routeName = 'Cart_Page';
  static const routePath = '/cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsync = ref.watch(cartItemsProvider);
    final subtotal = ref.watch(cartSubtotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Cart?'),
                  content: const Text('Are you sure you want to remove all items?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Clear', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(clearCartProvider.future).then((useCase) => useCase.call());
                // Refresh is automatic via Riverpod
              }
            },
          ),
        ],
      ),
      body: cartItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                   SizedBox(height: 16),
                   Text('Your cart is empty'),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _CartItemTile(item: item);
                  },
                ),
              ),
              _CartSummarySection(subtotal: subtotal),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _CartItemTile extends ConsumerWidget {
  const _CartItemTile({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            image: item.imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(item.imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: item.imageUrl == null
              ? const Icon(Icons.image, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 16),
        
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (item.variantId != null) // Show variant details if available
                Text(
                  'Variant', // Ideally show real variant name if stored in CartItem
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: 4),
              Text(
                'NGN ${item.unitPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),

        // Controls
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () async {
                     final update = await ref.read(updateCartQuantityProvider.future);
                     if (item.quantity > 1) {
                         update(productId: item.productId, variantId: item.variantId, quantity: item.quantity - 1);
                     } else {
                         final remove = await ref.read(removeFromCartProvider.future);
                         remove(productId: item.productId, variantId: item.variantId);
                     }
                  },
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () async {
                     final update = await ref.read(updateCartQuantityProvider.future);
                     update(productId: item.productId, variantId: item.variantId, quantity: item.quantity + 1);
                  },
                ),
              ],
            ),
             IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () async {
                      final remove = await ref.read(removeFromCartProvider.future);
                      remove(productId: item.productId, variantId: item.variantId);
                  },
             ),
          ],
        ),
      ],
    );
  }
}

class _CartSummarySection extends StatelessWidget {
  const _CartSummarySection({required this.subtotal});

  final double subtotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16)),
              Text(
                'NGN ${subtotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Delivery fee calculated at checkout',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Checkout Page (Checkout1PageWidget)
                context.pushNamed(Checkout1PageWidget.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
