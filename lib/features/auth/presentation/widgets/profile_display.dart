import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';

/// Example ConsumerWidget using auth providers instead of auth_util.
/// Use ref.watch(currentProfileProvider) for profile data.
class ProfileDisplay extends ConsumerWidget {
  const ProfileDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return const Text('Not signed in');
        }
        final name = profile.fullName ??
            [profile.firstName, profile.lastName].whereType<String>().join(' ').trim();
        return Text(name.isEmpty ? profile.email ?? profile.id : name);
      },
      loading: () => const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (err, _) => Text('Error: ${err.toString()}', style: const TextStyle(color: Colors.red)),
    );
  }
}
