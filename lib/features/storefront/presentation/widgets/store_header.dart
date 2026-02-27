import 'package:flutter/material.dart';

import '../../domain/entities/store_entity.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key, required this.store});

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Banner image
        if (store.bannerUrl != null)
          Image.network(
            store.bannerUrl!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 48),
                ),
              );
            },
          ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Logo
              if (store.logoUrl != null)
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(store.logoUrl!),
                  onBackgroundImageError: (exception, stackTrace) {},
                  child: const Icon(Icons.store),
                )
              else
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    store.name.isNotEmpty ? store.name[0].toUpperCase() : 'S',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),

              const SizedBox(width: 16),

              // Store info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (store.description != null &&
                        store.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        store.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        const Divider(),
      ],
    );
  }
}
