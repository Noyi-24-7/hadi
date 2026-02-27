# Safe Haven Integration Boundary

- **Client (Flutter):** Only calls Supabase Edge Function `orders-create`. Never calls Safe Haven API directly. No Safe Haven API keys in the app.
- **Edge Function `orders-create`:** Validates request, inserts order with status `pending_payment`, initializes payment with Safe Haven, stores `safehaven_reference` on the order, returns `order_id` and `payment_url` to the client.
- **Client:** Stores order id and opens `payment_url` (e.g. via url_launcher). User completes payment on Safe Haven.
- **Webhook `webhooks-safehaven`:** Server-side only. Safe Haven sends payment events to the Edge Function; signature is verified; order status is updated to `paid`; shipment creation is triggered. No Flutter code for webhook handling.
- **Payouts:** Merchant payout status and `safehaven_reference` are read from the `payouts` table via repository; no client-side payout init unless through an Edge Function.
