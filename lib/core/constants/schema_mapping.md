# Supabase Schema to Domain Mapping

Public schema tables used by the app: profiles, stores, products, product_variants, product_media, orders, order_items, order_delivery_quotes, deliveries, pickup_addresses, bank_accounts, preorder_requests, preorder_events, delivery_tickets, delivery_ticket_items, transactions, payouts.

## product_variants ↔ ProductVariant entity

| DB column     | Entity field  | Notes                    |
|---------------|---------------|--------------------------|
| id            | id            | uuid                     |
| product_id    | productId     | uuid                     |
| size          | size          | nullable text            |
| color         | color         | nullable text            |
| price_amount  | priceAmount   | bigint (minor units)      |
| quantity      | quantity      | stock                     |
| is_active     | isActive      | bool                      |
| created_at    | (optional)    | timestamptz              |

## order_items ↔ OrderItem entity

| DB column          | Entity field   | Notes                              |
|--------------------|----------------|------------------------------------|
| id                 | id             | uuid                               |
| order_id           | orderId        | uuid                               |
| product_id         | productId      | uuid                               |
| variant_id         | variantId      | nullable; use product_variant_id   |
| product_variant_id | variantId      | preferred FK to product_variants   |
| quantity           | quantity       | smallint                           |
| unit_price         | unitPrice      | numeric                            |
| line_total_amount  | lineTotalAmount| nullable numeric                   |

Use `product_variant_id` consistently when writing order items (both columns exist; align on one).

## orders ↔ Order entity (Safe Haven / checkout)

| DB column                  | Entity field             | Notes                    |
|----------------------------|--------------------------|--------------------------|
| id                         | id                       | uuid                     |
| store_id                   | storeId                  | uuid                     |
| buyer_id                   | buyerId                  | nullable uuid            |
| status                     | status                   | e.g. pending_payment     |
| total_amount               | totalAmount              | numeric                  |
| currency                   | currency                 | text                     |
| safehaven_reference        | safehavenReference       | nullable; set by Edge Fn |
| selected_delivery_quote_id| selectedDeliveryQuoteId  | nullable uuid            |
| subtotal_amount            | subtotalAmount           | bigint nullable          |
| delivery_fee                | deliveryFee              | bigint nullable          |
| transaction_fee            | transactionFee           | bigint nullable          |
| buyer_*, delivery_*         | (contact/delivery)       | denormalized on order    |

Safe Haven: client never calls Safe Haven API; Edge Function `orders-create` initializes payment and stores safehaven_reference; webhook updates order status.
