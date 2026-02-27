import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_provider.g.dart';

/// Single Supabase client provider. All data sources should depend on this.
/// Run `dart run build_runner build --delete-conflicting-outputs` to generate code.
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}
