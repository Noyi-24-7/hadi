// Default FlutterFlow smoke test — disabled because MyApp() requires
// Supabase initialization (SupaFlow.client) which is not available in unit tests.
// Use the individual widget tests in test/pages/ instead.
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Smoke test removed — MyApp requires Supabase.initialize() before pump.
  // All merchant & product flows are covered in test/pages/ widget tests.
  test('placeholder — see test/pages/ for real widget tests', () {
    expect(true, isTrue);
  });
}
