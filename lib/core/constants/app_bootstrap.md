# App Bootstrap and State Management

## App Initialization

The app initializes in the following order:

1. **Flutter Bindings**: `WidgetsFlutterBinding.ensureInitialized()`
2. **GoRouter Configuration**: `GoRouter.optionURLReflectsImperativeAPIs = true`
3. **URL Strategy**: `usePathUrlStrategy()` (removes # from URLs)
4. **Supabase**: `await SupaFlow.initialize()`
5. **FFAppState**: `final appState = FFAppState(); await appState.initializePersistedState()`
6. **App Launch**: `runApp(ProviderScope(...))`

## State Management

The app uses **dual state management**:

### Riverpod (Recommended for New Features)

Used for:
- Feature modules (products, orders, cart, checkout, etc.)
- Domain logic
- Data fetching
- Business logic

**Example**:
```dart
@riverpod
Future<List<Product>> products(ProductsRef ref, String storeId) async {
  final result = await ref.watch(getProductsProvider).call(storeId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
}

// Usage
final productsAsync = ref.watch(productsProvider(storeId));
```

### Provider (FFAppState) - Legacy

Used for:
- Temporary state during flows (verification, onboarding)
- Global constants (qtyBase, productCategories)
- FlutterFlow-generated pages

**Fields**:
- `tmpphone` - Temporary phone number during verification
- `tmpheardabout` - How user heard about platform
- `tmpotpchannel` - OTP channel (sms/whatsapp)
- `timeractive` - OTP timer state
- `tmpphoneverified` - Phone verification status
- `onboardingcomplete` - Onboarding completion status
- `qtyBase` - Quantity options (1-50)
- `productCategories` - Product category list

**Example**:
```dart
// Access
context.watch<FFAppState>();
final phone = FFAppState().tmpphone;

// Update
FFAppState().tmpphone = '1234567890';
```

## Navigation

The app uses **GoRouter** for navigation:

- Router created via `createRouter(appStateNotifier)`
- AppStateNotifier manages auth state
- Routes defined in FlutterFlow
- Supports deep linking

## ProviderScope

The entire app is wrapped in `ProviderScope`:

```dart
runApp(
  ProviderScope(
    child: ChangeNotifierProvider(
      create: (context) => appState,
      child: MyApp(),
    ),
  ),
);
```

This enables:
- ✅ All Riverpod providers accessible throughout app
- ✅ Provider overrides for testing
- ✅ Scoped providers

## Best Practices

### For New Features

1. **Use Riverpod** for all new state management
2. **Create providers** in feature modules
3. **Follow Clean Architecture** (domain, data, presentation)
4. **Use @riverpod** annotation for code generation

### For Legacy Code

1. **Keep FFAppState** for existing functionality
2. **Migrate to Riverpod** only when refactoring
3. **Don't mix** FFAppState and Riverpod in same feature

## Migration Path (Optional)

To migrate FFAppState fields to Riverpod:

1. Create StateProvider for each field
2. Update pages to use ref.watch() instead of context.watch<FFAppState>()
3. Update setters to use ref.read().state = value
4. Remove field from FFAppState

**Example**:
```dart
// Before (FFAppState)
FFAppState().tmpphone = '1234567890';
final phone = FFAppState().tmpphone;

// After (Riverpod)
@riverpod
class TmpPhone extends _$TmpPhone {
  @override
  String build() => '';
}

// Usage
ref.read(tmpPhoneProvider.notifier).state = '1234567890';
final phone = ref.watch(tmpPhoneProvider);
```
