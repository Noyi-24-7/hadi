import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/products/domain/entities/product_variant.dart';
import '../../../../features/cart/domain/entities/cart_item.dart';
import '../../../../features/cart/presentation/providers/cart_providers.dart';
// Assuming these providers are available essentially as in the merchant page
import '/pages/product_details_page/product_details_providers.dart'; 
import '/features/cart/presentation/pages/cart_page.dart'; 

class StoreProductDetailsPage extends ConsumerStatefulWidget {
  const StoreProductDetailsPage({
    super.key,
    required this.productId,
    required this.storeSlug,
  });

  final String productId;
  final String storeSlug;

  static const routeName = 'Store_Product_Details_Page';
  static const routePath = '/store/:slug/product/:productId';

  @override
  ConsumerState<StoreProductDetailsPage> createState() => _StoreProductDetailsPageState();
}

class _StoreProductDetailsPageState extends ConsumerState<StoreProductDetailsPage> {
  String? _selectedSize;
  String? _selectedColor;
  ProductVariant? _selectedVariant;
  int _quantity = 1;

  void _onSizeSelected(String size, List<ProductVariant> variants) {
    setState(() {
      if (_selectedSize == size) {
        // Deselect
        _selectedSize = null;
        _selectedColor = null;
        _selectedVariant = null;
      } else {
        // Select new size
        _selectedSize = size;
        // Check if previously selected color is valid for new size
        final availableColors = variants
            .where((v) => v.size == size)
            .map((v) => v.color)
            .toSet();

        if (_selectedColor != null && !availableColors.contains(_selectedColor)) {
          _selectedColor = null; // Auto-deselect invalid color
        }
        _updateSelectedVariant(variants);
      }
    });
  }

  void _onColorSelected(String color, List<ProductVariant> variants) {
    setState(() {
      if (_selectedColor == color) {
        _selectedColor = null;
      } else {
        _selectedColor = color;
      }
      _updateSelectedVariant(variants);
    });
  }

  void _updateSelectedVariant(List<ProductVariant> variants) {
    if (_selectedSize != null && _selectedColor != null) {
      try {
        _selectedVariant = variants.firstWhere(
          (v) => v.size == _selectedSize && v.color == _selectedColor,
        );
      } catch (e) {
        _selectedVariant = null;
      }
    } else {
      _selectedVariant = null;
    }
  }

  double _getCurrentPrice(double basePrice) {
    if (_selectedVariant != null) {
      return _selectedVariant!.priceAmount / 100.0;
    }
    return basePrice;
  }

  int _getMaxQuantity(int baseStock) {
    return _selectedVariant?.quantity ?? baseStock;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productId.isEmpty) {
      return const Scaffold(body: Center(child: Text('Product ID Required')));
    }

    final productAsync = ref.watch(productByIdProvider(widget.productId));
    final mediaAsync = ref.watch(productMediaProvider(widget.productId));
    final variantsAsync = ref.watch(productVariantsProvider(widget.productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.pushNamed(CartPage.routeName), // Navigate to Cart
          ),
        ],
      ),
      body: productAsync.when(
        data: (product) => SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Media
              SizedBox(
                height: 300,
                child: mediaAsync.when(
                  data: (media) {
                     if (media.isEmpty) return Container(color: Colors.grey[200], child: const Icon(Icons.image, size: 64));
                     return PageView.builder(
                       itemCount: media.length,
                       itemBuilder: (context, index) => Image.network(
                         media[index].publicUrl ?? '',
                         fit: BoxFit.cover,
                         errorBuilder: (_,__,___) => const Icon(Icons.broken_image),
                       ),
                     );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_,__) => const Center(child: Icon(Icons.error)),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'NGN ${_getCurrentPrice(product.price).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 16),
                    Text(product.description ?? 'No description available', style: Theme.of(context).textTheme.bodyMedium),
                    
                    const SizedBox(height: 24),
                    
                    // Variants
                    variantsAsync.when(
                      data: (variants) {
                        if (variants.isEmpty) return const SizedBox.shrink();

                        // Get unique sizes
                        final uniqueSizes = variants
                            .map((v) => v.size)
                            .where((s) => s != null && s.isNotEmpty)
                            .cast<String>()
                            .toSet()
                            .toList();

                        // Get available colors for selected size (or empty if no size selected)
                        final availableColors = _selectedSize != null
                            ? variants
                                .where((v) => v.size == _selectedSize)
                                .map((v) => v.color)
                                .where((c) => c != null && c.isNotEmpty)
                                .cast<String>()
                                .toSet()
                                .toList()
                            : <String>[];

                        // If size is selected but no color selected, show all available colors for that size
                        // If no size selected, don't show colors yet (guide user flow: Size -> Color)

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Select Size', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: uniqueSizes.map((size) {
                                final isSelected = _selectedSize == size;
                                return ChoiceChip(
                                  label: Text(size),
                                  selected: isSelected,
                                  onSelected: (_) => _onSizeSelected(size, variants),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),

                            if (_selectedSize != null && availableColors.isNotEmpty) ...[
                              const Text('Select Color', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: availableColors.map((color) {
                                  final isSelected = _selectedColor == color;
                                  return ChoiceChip(
                                    label: Text(color),
                                    selected: isSelected,
                                    onSelected: (_) => _onColorSelected(color, variants),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                            ],

                            if (_selectedVariant != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  '${_selectedVariant!.quantity} items available',
                                  style: TextStyle(
                                    color: _selectedVariant!.quantity > 0 ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (_,__) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: SpinKitWanderingCubes(color: Colors.blue, size: 50)),
        error: (e, __) => Center(child: Text('Error: $e')),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0,-5))],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                    ),
                    Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                         final maxQty = productAsync.valueOrNull != null
                             ? _getMaxQuantity(productAsync.value!.stockQuantity ?? 0)
                             : 0;
                         if (_quantity < maxQty) {
                           setState(() => _quantity++);
                         } else {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Max quantity reached')));
                         }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Add to Cart
              Expanded(
                child: productAsync.when(
                  data: (product) => ElevatedButton(
                    onPressed: () async {
                       // Validation
                       final variants = variantsAsync.valueOrNull ?? [];
                       final hasVariants = variants.isNotEmpty;

                       if (hasVariants) {
                         if (_selectedSize == null) {
                           ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Please select a Size')));
                           return;
                         }
                         if (_selectedColor == null) {
                           // Check if there are colors available for this size
                           final colorsForSize = variants
                               .where((v) => v.size == _selectedSize)
                               .map((v) => v.color)
                               .where((c) => c != null && c.isNotEmpty)
                               .cast<String>()
                               .toSet();
                            if (colorsForSize.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please select a Color')));
                              return;
                           }
                         }
                       }

                       try {
                         final addToCart = await ref.read(addToCartProvider.future);
                         final item = CartItem(
                           productId: product.id,
                           productName: product.name,
                           quantity: _quantity,
                           unitPrice: _selectedVariant != null 
                               ? _selectedVariant!.priceAmount / 100.0 
                               : product.price,
                           availableStock: _selectedVariant?.quantity ?? product.stockQuantity ?? 0,
                           variantId: _selectedVariant?.id,
                           variantDescription: _selectedVariant != null ? '${_selectedVariant!.size ?? ""} ${_selectedVariant!.color ?? ""}' : null,
                           imageUrl: mediaAsync.valueOrNull?.firstOrNull?.publicUrl,
                         );
                         
                         await addToCart(item);
                         
                         if (mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Cart')));
                         }
                       } catch (e) {
                         if (mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add: $e')));
                         }
                       }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add to Cart'),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_,__) => const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
