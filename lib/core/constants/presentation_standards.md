# Presentation Layer Standards

## Overview

This document defines best practices for building presentation layer components in the Hadi Platform. Follow these standards when creating **new pages and widgets**.

---

## Widget Types

### Use HookConsumerWidget for Stateful Pages

**DO** ✅:
```dart
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPageWidget extends HookConsumerWidget {
  const MyPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final selectedFilter = useState<String>('all');
    final dataAsync = ref.watch(myDataProvider);

    return dataAsync.when(
      data: (data) => /* UI */,
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

**DON'T** ❌:
```dart
class MyPageWidget extends StatefulWidget {
  const MyPageWidget({super.key});

  @override
  State<MyPageWidget> createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  late MyPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

### Use ConsumerWidget for Stateless Pages

**DO** ✅:
```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myProvider);
    return Text(data);
  }
}
```

**DON'T** ❌:
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // No Riverpod integration
    return Text('...');
  }
}
```

---

## State Management

### Use Riverpod Providers Instead of FlutterFlowModel

**DO** ✅:
```dart
// In feature providers file
@riverpod
Future<List<Product>> products(ProductsRef ref, String storeId) async {
  final result = await ref.watch(getProductsProvider).call(storeId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
}

// In page
class ProductsPage extends HookConsumerWidget {
  const ProductsPage({super.key, required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider(storeId));

    return productsAsync.when(
      data: (products) => ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
```

**DON'T** ❌:
```dart
class ProductsPage extends StatefulWidget {
  // ...
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductsPageModel());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsRow>>(
      future: ProductsTable().queryRows(/* ... */),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        // ...
      },
    );
  }
}
```

---

## Async Data Handling

### Use AsyncValue Instead of FutureBuilder

**DO** ✅:
```dart
final dataAsync = ref.watch(myDataProvider);

return dataAsync.when(
  data: (data) => MyDataWidget(data: data),
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stack) => Center(child: Text('Error: $error')),
);

// Or use map/maybeWhen for partial handling
return dataAsync.map(
  data: (data) => MyDataWidget(data: data.value),
  loading: (_) => const CircularProgressIndicator(),
  error: (error) => Text('Error: ${error.error}'),
);
```

**DON'T** ❌:
```dart
return FutureBuilder<MyData>(
  future: fetchMyData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    if (!snapshot.hasData) {
      return const Text('No data');
    }
    return MyDataWidget(data: snapshot.data!);
  },
);
```

---

## Form State

### Use flutter_hooks for Form State

**DO** ✅:
```dart
class MyFormPage extends HookConsumerWidget {
  const MyFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final isLoading = useState(false);

    Future<void> handleSubmit() async {
      isLoading.value = true;
      try {
        await submitForm(nameController.text, emailController.text);
      } finally {
        isLoading.value = false;
      }
    }

    return Column(
      children: [
        TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
        ElevatedButton(
          onPressed: isLoading.value ? null : handleSubmit,
          child: isLoading.value ? const CircularProgressIndicator() : const Text('Submit'),
        ),
      ],
    );
  }
}
```

**DON'T** ❌:
```dart
class MyFormPage extends StatefulWidget {
  // ...
}

class _MyFormPageState extends State<MyFormPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // ...
}
```

---

## Data Fetching

### Never Call Supabase Directly in Pages

**DO** ✅:
```dart
// Use providers from features
class MyPage extends HookConsumerWidget {
  const MyPage({super.key, required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(storeProvider(storeId));

    return storeAsync.when(
      data: (store) => StoreWidget(store: store),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}
```

**DON'T** ❌:
```dart
class MyPage extends StatefulWidget {
  // ...
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StoresRow>>(
      future: StoresTable().querySingleRow(
        queryFn: (q) => q.eq('id', widget.storeId),
      ),
      builder: (context, snapshot) {
        // ...
      },
    );
  }
}
```

---

## Summary Checklist

### ✅ DO

- Use `HookConsumerWidget` for stateful pages
- Use `ConsumerWidget` for stateless pages
- Use Riverpod providers from features
- Use `AsyncValue.when()` for async data
- Use `flutter_hooks` for form state (useTextEditingController, useState)
- Keep business logic in use cases and providers
- Handle loading and error states explicitly

### ❌ DON'T

- Use `StatefulWidget` for new pages
- Use `FlutterFlowModel`
- Call Supabase directly in pages (use providers)
- Use `FutureBuilder` or `StreamBuilder`
- Manage TextEditingController lifecycle manually
- Put business logic in widgets

---

## Migration Guide

### Refactoring Existing Pages

When refactoring FlutterFlow-generated pages:

1. **Replace StatefulWidget with HookConsumerWidget**
   - Remove `State` class
   - Change `build` signature to include `WidgetRef ref`
   - Remove `initState` and `dispose`

2. **Replace FlutterFlowModel with Riverpod Providers**
   - Remove `_model` field
   - Remove `createModel()` call
   - Use `ref.watch()` to access providers

3. **Replace FutureBuilder with AsyncValue**
   - Remove `FutureBuilder` widget
   - Use `ref.watch(myProvider)` to get `AsyncValue`
   - Use `.when()` method for loading/error/data states

4. **Replace TextEditingController with useTextEditingController**
   - Remove manual controller initialization
   - Use `useTextEditingController()` hook
   - Remove manual disposal

5. **Replace setState with useState**
   - Remove `setState()` calls
   - Use `useState()` hook
   - Update values with `.value =`

---

## Example: Before and After

### Before (FlutterFlow Pattern)

```dart
class MyPageWidget extends StatefulWidget {
  const MyPageWidget({super.key});

  @override
  State<MyPageWidget> createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  late MyPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsRow>>(
      future: ProductsTable().queryRows(
        queryFn: (q) => q.eq('store_id', 'store-123'),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final products = snapshot.data!;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => Text(products[index].name),
        );
      },
    );
  }
}
```

### After (Riverpod Pattern)

```dart
class MyPage extends HookConsumerWidget {
  const MyPage({super.key, required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider(storeId));

    return productsAsync.when(
      data: (products) => ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => Text(products[index].name),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
```

**Benefits**:
- ✅ 50% less boilerplate code
- ✅ No manual lifecycle management
- ✅ Type-safe state management
- ✅ Automatic loading/error handling
- ✅ No direct database calls
- ✅ Testable and maintainable
