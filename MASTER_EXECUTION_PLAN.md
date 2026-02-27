# Master Execution Plan – Refactor to Clean Architecture + Riverpod

This plan aligns with [.kiro/specs/hadi-platform-completion/requirements.md](.kiro/specs/hadi-platform-completion/requirements.md), [.kiro/specs/hadi-platform-completion/design.md](.kiro/specs/hadi-platform-completion/design.md), and [STANDARD.md](STANDARD.md). Supabase schema and tables were verified via Supabase MCP; variant and Safe Haven touchpoints are derived from the current codebase and specs.

---

## 1. Foundation and Core

- [ ] **1.1** Add core dependencies: `flutter_riverpod`, `riverpod_annotation`, `freezed`, `freezed_annotation`, `dartz` (or `fpdart`), `json_annotation`, and run `build_runner` for code generation per STANDARD.md.
- [ ] **1.2** Create `lib/core/` with subfolders: `error/` (Failure hierarchy), `network/`, `utils/`, `theme/`, `constants/`, `di/`, `widgets/`.
- [ ] **1.3** Implement base `Failure` and concrete types (`ServerFailure`, `NetworkFailure`, `CacheFailure`, `ValidationFailure`, `AuthFailure`) in `core/error/` with `Equatable` and use in data layer as `Either<Failure, T>`.
- [ ] **1.4** Introduce a single `SupabaseClient` provider in `core/di/` (or core) and ensure no raw Supabase access from presentation; all access goes through data sources/repositories.
- [ ] **1.5** Define app-wide design tokens and `ThemeData` in `core/theme/` and migrate away from hardcoded colors/fonts in existing `flutter_flow` theme where applicable.

---

## 2. Supabase Schema Alignment and Data Contracts

- [ ] **2.1** Confirm public schema usage: `profiles`, `stores`, `products`, `product_variants`, `product_media`, `orders`, `order_items`, `order_delivery_quotes`, `deliveries`, `pickup_addresses`, `bank_accounts`, `preorder_requests`, `preorder_events`, `delivery_tickets`, `delivery_ticket_items`, `transactions`, `payouts` (already listed via MCP).
- [ ] **2.2** Add migrations for any missing design elements: e.g. `webhook_logs`, `cart_items` (if persisting cart in DB), and ensure `orders.safehaven_reference`, `orders.selected_delivery_quote_id`, `order_items.variant_id` / `order_items.product_variant_id` match design and current usage.
- [ ] **2.3** Document mapping: `product_variants` (size, color, price_amount, quantity) ↔ domain variant entity; `order_items` (product_id, variant_id/product_variant_id, quantity, unit_price, line_total_amount) ↔ order line item entity; `orders` (safehaven_reference, status, subtotal_amount, delivery_fee, transaction_fee) ↔ order entity for Safe Haven and checkout.

---

## 3. Feature: Auth and Profile (Extract First)

- [ ] **3.1** Create feature `lib/features/auth/` (or `profile/`) with `data/`, `domain/`, `presentation/` per STANDARD.md feature-first structure.
- [ ] **3.2** Domain: define `Profile` entity and `AuthRepository` (or `ProfileRepository`) interface; no Supabase types in domain.
- [ ] **3.3** Data: implement `AuthRemoteDataSource` (Supabase Auth + profiles table), `ProfileModel` with `toDomain()`, and `AuthRepositoryImpl` returning `Either<Failure, T>`.
- [ ] **3.4** Presentation: add Riverpod providers (`@riverpod`) for auth state and profile; migrate one existing auth/page to `ConsumerWidget` or `HookConsumerWidget` that uses these providers instead of FF model/auth util.
- [ ] **3.5** Replace direct `auth_util` and inline Supabase auth calls in that feature with repository use cases and providers.

---

## 4. Feature: Products and Variants (Domain and Data)

- [ ] **4.1** Create feature `lib/features/products/` with data, domain, presentation.
- [ ] **4.2** Domain: define `Product` and `ProductVariant` entities. Variant must include: size, color, priceAmount, quantity, isActive (and id, productId) to support dynamic size/color selection and pricing.
- [ ] **4.3** Domain: define `ProductRepository` interface (e.g. get product by id, get variants by product id, create/update product and variants) and use cases (e.g. `GetProduct`, `GetProductVariants`, `CreateProductWithVariants`).
- [ ] **4.4** Data: add `ProductModel` and `ProductVariantModel` with `@JsonSerializable(fieldRename: FieldRename.snake)`, `fromJson`/`toJson`, and `toDomain()`; map `product_variants` columns (size, color, price_amount, quantity) to model then entity.
- [ ] **4.5** Data: implement `ProductRemoteDataSource` (Supabase only; no Supabase in UI) and `ProductRepositoryImpl` returning `Either<Failure, T>`; register repository and data source via Riverpod in DI.

---

## 5. Dynamic Variant Logic (Sizes and Colors) – Mapping and Use Cases

- [ ] **5.1** Document current FF behavior: `SizeEntryStruct` (label, price, qty) and `ColorEntryStruct` (label, sizeLabel, qty) used in add-product flow; `priceForSizeLabel()` in custom_functions; product detail uses `ProductVariantsTable().queryRows` and displays sizes/colors with FutureBuilder.
- [ ] **5.2** Domain: add use case (e.g. `ResolveVariantForSelection`) that, given product id + optional size + optional color, returns the matching `ProductVariant` (or failure if not found/out of stock). Business rule: one variant per (product_id, size, color) as per DB.
- [ ] **5.3** Domain: add use case or pure function for "current price for selection": base product price vs variant price (variant takes precedence when selected); no UI or Supabase in domain.
- [ ] **5.4** Data: ensure variant list fetch and single-variant resolution go through repository/use case; repository uses `product_variants` table and maps to `ProductVariant` entity (size, color, priceAmount, quantity).
- [ ] **5.5** Presentation: introduce a "variant selector" state (e.g. selected size, selected color, resolved variant id, current price) held in a Riverpod notifier or passed as params; product detail page consumes variant provider/use case and displays sizes/colors, disables out-of-stock (quantity <= 0), updates price on selection (per Kiro Property 21 and 22).

---

## 6. Feature: Cart (Buyer)

- [ ] **6.1** Create feature `lib/features/cart/` with data, domain, presentation.
- [ ] **6.2** Domain: define `CartItem` entity (productId, variantId optional, productName, variantDescription optional, unitPrice, quantity, availableStock) and cart aggregate; define `CartRepository` interface (add, remove, update quantity, get items, clear, validate stock) and use cases.
- [ ] **6.3** Data: implement cart persistence per design—either local only (SharedPreferences) via `CartLocalDataSource` or hybrid with optional `cart_items` table; repository returns `Either<Failure, T>` and enforces idempotent add (increment quantity if same product+variant) and stock validation.
- [ ] **6.4** Presentation: single cart notifier/provider (e.g. `CartNotifier`) that uses cart repository; UI for cart page and "add to cart" uses provider only (no direct SharedPreferences or Supabase in widgets).
- [ ] **6.5** Connect "add to cart" on product detail to cart use case: pass product id, variant id (from variant selector), quantity; validate stock before add and show friendly error if over stock (Kiro Requirement 3.6).

---

## 7. Feature: Orders and Checkout (Safe Haven Integration Points)

- [ ] **7.1** Create feature `lib/features/orders/` (or split `checkout` and `orders`) with data, domain, presentation.
- [ ] **7.2** Domain: define `Order` entity including fields for Safe Haven: status, safehavenReference (optional), subtotalAmount, deliveryFee, transactionFee, totalAmount, selectedDeliveryQuoteId; define `OrderItem` (productId, variantId, quantity, unitPrice, lineTotalAmount).
- [ ] **7.3** Domain: define `OrderRepository` interface: create order (returns order id + payment url or failure), get order by id, get orders by store; and use cases `CreateOrder`, `GetOrder`, etc.
- [ ] **7.4** Data: implement `OrderRemoteDataSource` that calls Supabase Edge Function `orders-create` (not Safe Haven directly from client); map request to design (store_id, buyer, delivery, items with product_id, variant_id, quantity, unit_price, selected_quote_id, delivery_fee, transaction_fee, subtotal, total_amount); map response (order_id, payment_url) and store `safehaven_reference` on order when returned by Edge Function.
- [ ] **7.5** Data: ensure order_items insert uses `variant_id` or `product_variant_id` consistently with `order_items` table (both columns exist; align with one and document).
- [ ] **7.6** Presentation: checkout flow (step 1: contact/delivery; step 2: shipping quote selection, order summary, place order) uses order use case; on "place order" call create-order use case and redirect to payment_url (Safe Haven) when successful; handle errors with AsyncValue and user-friendly messages (no leaking Supabase/external errors).
- [ ] **7.7** Document Safe Haven integration boundary: client only calls Edge Function `orders-create`; Edge Function initializes payment with Safe Haven and stores `safehaven_reference`; webhook `webhooks-safehaven` updates order status and triggers shipment (server-side only). No Safe Haven API keys or direct payment init from Flutter.

---

## 8. Feature: Shipping and Delivery Quotes (Terminal)

- [ ] **8.1** Create feature `lib/features/shipping/` or under `orders`: domain entities for `DeliveryQuote` (id, serviceLevel, providerName, priceAmount, currency, etaText); repository interface and use case to fetch quotes.
- [ ] **8.2** Data: implement data source that calls Edge Function `terminal-get-quotes` with pickup/delivery/package; map response to `order_delivery_quotes` and to domain entities; repository returns `Either<Failure, List<DeliveryQuote>>`.
- [ ] **8.3** Presentation: checkout step 2 fetches quotes via provider/use case, displays options, stores selected quote id on order when creating order (selected_delivery_quote_id).

---

## 9. Feature: Delivery Tickets and Delivery-Only Flow

- [ ] **9.1** Create feature `lib/features/delivery_tickets/` with data, domain, presentation; domain entities for delivery ticket and ticket items; repository that calls Edge Function `delivery-tickets-create` (payment init via Safe Haven for delivery-only).
- [ ] **9.2** Migrate existing delivery-only pages (create ticket, checkout 1/2, after-checkout success/cancel/shipment-not-created) to use new repository and providers; keep payment redirect and status handling aligned with Safe Haven flow (same as orders: client only gets payment_url from Edge Function).

---

## 10. Feature: Pre-orders and Shipment Creation

- [ ] **10.1** Create feature `lib/features/preorders/` (or under merchant orders): domain and data for preorder requests; repository method to trigger shipment creation via Edge Function `preorders-create-shipment`.
- [ ] **10.2** Migrate preorder list and detail pages to use repository and Riverpod; track status and tracking from `preorder_requests` (terminal_shipment_id, tracking_events).

---

## 11. Merchant Revenue, Payouts, and Transactions

- [ ] **11.1** Create feature `lib/features/transactions/` or `revenue/`: domain entities for transaction and payout; repository to fetch transactions and payouts by store; map `payouts.safehaven_reference` and status for display.
- [ ] **11.2** Presentation: order/transaction history and payout history pages use repository via Riverpod; no direct Supabase in widgets; revenue/balance calculations in use case or repository (per Kiro Requirement 18).

---

## 12. Presentation Layer Consistency

- [ ] **12.1** Replace FlutterFlowModel state with Riverpod state: one feature at a time, convert page state (e.g. selected size/color, quantity, form fields) to notifiers or providers; use `ref.watch`/`ref.read` and `AsyncValue.when` for async flows.
- [ ] **12.2** Prefer `HookConsumerWidget` or `ConsumerWidget`; keep widgets under 200 lines; extract subwidgets; use const and ThemeData/textTheme per STANDARD.md.
- [ ] **12.3** Ensure every async flow (load product, load variants, add to cart, create order, fetch quotes) shows loading/error/data states and uses AsyncValue; empty and error states have explicit UI (no raw exception in UI).

---

## 13. Buyer Storefront (If Not Yet Present)

- [ ] **13.1** Add feature `lib/features/storefront/`: domain (Store, Product summary), repository to fetch store by slug and active products; data source uses Supabase (store + products) with RLS.
- [ ] **13.2** Storefront page and product grid use repository via Riverpod; product detail reuses products feature and variant logic; navigation to product detail by product id.

---

## 14. Navigation and App Bootstrap

- [ ] **14.1** Introduce `ProviderScope` at app root and register any global providers; use GoRouter or existing nav with type-safe routes; route guards for auth where needed.
- [ ] **14.2** Remove or wrap FlutterFlow-specific nav/util only where it conflicts with Riverpod; keep migration incremental so app runs after each feature slice.

---

## 15. Testing and Cleanup

- [ ] **15.1** Add unit tests for variant resolution use case, price calculation, and cart use cases (add, remove, stock validation); mock repositories/data sources.
- [ ] **15.2** Add widget tests for product detail variant selection and cart actions using ProviderContainer/override.
- [ ] **15.3** Remove deprecated FF-only code (old models, direct table access from widgets) only after corresponding feature is migrated and tests pass.
- [ ] **15.4** Run `flutter analyze` and fix lints; ensure no `dynamic`, no Supabase in presentation layer, and naming adheres to STANDARD.md (camelCase, PascalCase, underscores for files).

---

## 16. Safe Haven and Terminal – Summary Checklist

- [ ] **16.1** Client: only calls Edge Functions (`orders-create`, `delivery-tickets-create`, etc.); never calls Safe Haven or Terminal APIs directly.
- [ ] **16.2** Orders: create order use case returns payment_url and order id; client stores order id and opens payment_url; `safehaven_reference` is set by Edge Function and stored in `orders`/DB.
- [ ] **16.3** Webhooks: `webhooks-safehaven` and `webhooks-terminal` are server-side only; no Flutter code for webhook handling; document that payment success and tracking updates are handled in Edge Functions and DB.
- [ ] **16.4** Payouts: merchant payout status and `safehaven_reference` read from `payouts` table via repository; no client-side payout init unless via Edge Function.

---

## Reference: Key Files and Schemas

- **Variant logic today:** [lib/components/comp_size_qty_row/](lib/components/comp_size_qty_row/), [lib/components/comp_color_qty_row/](lib/components/comp_color_qty_row/), [lib/flutter_flow/custom_functions.dart](lib/flutter_flow/custom_functions.dart) (`priceForSizeLabel`, `totalQtyFromSizes`, `qtyOptionsForSizeLabel`), [lib/pages/personal_business_information/add_a_new_product_page/](lib/pages/personal_business_information/add_a_new_product_page/), [lib/pages/product_details_page/product_details_page_widget.dart](lib/pages/product_details_page/product_details_page_widget.dart) (FutureBuilder + ProductVariantsTable).
- **Safe Haven in app:** [lib/backend/api_requests/api_calls.dart](lib/backend/api_requests/api_calls.dart) (`CreateOrderAuthCall` → orders-create), [lib/backend/supabase/database/tables/orders.dart](lib/backend/supabase/database/tables/orders.dart) (safehaven_reference), [lib/backend/supabase/database/tables/payouts.dart](lib/backend/supabase/database/tables/payouts.dart) (safehaven_reference).
- **Supabase tables (public):** profiles, stores, products, product_variants (size, color, price_amount, quantity), product_media, orders, order_items (variant_id, product_variant_id), order_delivery_quotes, deliveries, pickup_addresses, bank_accounts, preorder_requests, delivery_tickets, delivery_ticket_items, transactions, payouts.
