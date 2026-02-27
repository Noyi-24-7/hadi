# Hadi Product Documentation

------------------------------------------------------------------------

## 🔎 What The Product Is

This is a merchant-focused e-commerce + logistics infrastructure
platform that allows:

### Small Businesses / Sellers to:

-   Create a storefront\
-   Add and manage products\
-   Accept orders\
-   Handle pre-orders\
-   Receive bank payments (via Safe Haven)\
-   Verify bank accounts before payout (via Mono)\
-   Verify users via OTP (via Termii)\
-   Request deliveries (via Terminal Africa)\
-   Track shipments\
-   Manage payouts\
-   Create delivery-only shipments

### Buyers to:

-   Visit a merchant's public store via link\
-   Browse products\
-   Select size/color variations\
-   Add to cart or buy instantly\
-   Choose delivery option (rates powered by Terminal)\
-   Pay via bank rails (Safe Haven)\
-   Receive confirmation & track order

### Merchants (Also) to:

-   Create delivery tickets for items\
-   Track logistics\
-   Handle "Delivery Only" shipments (even outside store purchases)

------------------------------------------------------------------------

**In short:**

> Shopify-lite + Embedded Banking + Logistics Coordination

Designed for local merchants (Nigeria-focused, given state/LGA structure
and local bank verification).

------------------------------------------------------------------------

## 👥 User Types

1.  Seller / Merchant\
2.  Buyer / Customer\
3.  Merchant using Delivery-Only (logistics without storefront sales)

------------------------------------------------------------------------

# 🧭 User Journeys

------------------------------------------------------------------------

# 1️⃣ Seller / Merchant Journey

## 🟢 A. Onboarding Journey

**Goal:** Get merchant verified and ready to sell.

1.  Create account (Phone number)\
2.  OTP verification (via Termii)\
3.  Enter email + password\
4.  Supabase creates authenticated user\
5.  Land on Home (Incomplete Info state)\
6.  Complete required setup tasks:
    -   Business info\
    -   RC number (if registered)\
    -   Bank account (verified via Mono)\
    -   Pickup address\
    -   Setup storefront

**Behind the scenes:**

-   OTP handled via Termii\
-   User + business data stored in Supabase\
-   Bank account verified via Mono before enabling payouts

------------------------------------------------------------------------

## 🟢 B. Store Setup Journey

**Goal:** Make store publicly usable.

Merchant:

-   Uploads header/banner image\
-   Gets shareable storefront link\
-   Adds products

Navigation includes:

-   Storefront\
-   Orders\
-   Pre-orders\
-   Deliveries\
-   Account\
-   FAQs\
-   Support

All product and store data stored in Supabase.

------------------------------------------------------------------------

## 🟢 C. Add Product Journey

**Goal:** Create structured product listing with inventory logic.

Merchant:

-   Clicks "Add Product"\
-   Inputs:
    -   Name\
    -   Category\
    -   Description\
    -   Weight\
    -   Price\
    -   Quantity\
    -   Pickup location

Optional:

-   Enable sizes\
-   Add size-based pricing & quantities\
-   Add colors tied to sizes\
-   System calculates total quantity

Upload media:

-   File name\
-   File size\
-   Upload progress\
-   Cancel option

Product appears in store grid.

Actions available:

-   Edit product\
-   Remove product\
-   Share product link

Managed via Supabase tables (products, variants, media, inventory).

------------------------------------------------------------------------

## 🟢 D. Order & Revenue Management

Seller can:

-   View total revenue\
-   View total items sold\
-   Filter transactions (All / Payouts / Orders)\
-   See payout records\
-   See payment records

Payments processed via Safe Haven and verified through Supabase Edge
Function webhooks.

------------------------------------------------------------------------

## 🟢 E. Pre-Order Management

If product is marked as Pre-order:

Tabs:

-   Pending\
-   Requested\
-   Tracking

Merchant can:

-   Request item pickup\
-   Resend request\
-   Track delivery status (via Terminal tracking updates)

Shipment creation may be delayed until merchant triggers pickup.

------------------------------------------------------------------------

## 🟢 F. Delivery-Only (Logistics Use Case)

Merchant can:

-   Create delivery ticket\
-   Upload item image\
-   Add item details (name, weight, quantity)\
-   Enter delivery details\
-   Choose shipping option (rates fetched from Terminal)\
-   Pay (via Safe Haven)\
-   Track shipment (via Terminal tracking)

Functions independently of storefront purchases.

------------------------------------------------------------------------

# 2️⃣ Buyer Journey

Buyers do not create an account.

## 🟢 A. Discover Store

-   Click merchant's shared link\
-   View banner and product grid

------------------------------------------------------------------------

## 🟢 B. Browse Product

Product page shows:

-   Images (with selector)\
-   Title\
-   Description\
-   Sizes\
-   Colors\
-   Weight\
-   Similar products

------------------------------------------------------------------------

## 🟢 C. Purchase Flow

-   Click "Buy Now" or "Add to Cart"\
-   Select size and color\
-   Dynamic price update\
-   Out-of-stock disabled state\
-   Proceed to checkout

Inventory enforced in Supabase.

------------------------------------------------------------------------

## 🟢 D. Checkout Flow

### Checkout Page 1

-   Quantity\
-   Contact details\
-   Delivery address

### Checkout Page 2

-   Review order\
-   Choose shipping option (High Priority / Standard)\
-   Shipping rates from Terminal\
-   Amount breakdown:
    -   Product price\
    -   Delivery fee\
    -   Transaction fee\
    -   Total

Place order.

------------------------------------------------------------------------

## 🟢 E. Payment States

Handled via Safe Haven.

Possible states:

-   Payment successful\
-   Shipment not created\
-   Payment cancelled\
-   Retry payment

After success:

-   Webhook hits Supabase Edge Function\
-   Order marked as paid\
-   Shipment created via Terminal

Each state shows:

-   Order number\
-   Company email\
-   Clear status

------------------------------------------------------------------------

# 3️⃣ Merchant as Delivery Customer

Merchant can:

-   Create delivery ticket\
-   Use saved pickup address\
-   Enter receiver details\
-   Choose shipping provider\
-   Pay via Safe Haven\
-   Track shipment via Terminal

Tabs:

-   Ongoing deliveries\
-   Completed deliveries

Tracking includes:

-   Picked up\
-   In transit\
-   Delivered / failed

------------------------------------------------------------------------

# 🔑 Core Expected Functionalities

## 🏪 Merchant Core Functionalities

-   Account creation & OTP verification (Termii)\
-   Business profile management\
-   Bank account linking & verification (Mono)\
-   Storefront creation\
-   Product creation (sizes, colors, inventory logic, media)\
-   Pre-order system\
-   Order tracking\
-   Revenue & payout tracking (Safe Haven)\
-   Delivery ticket creation (Terminal)\
-   Shipment tracking (Terminal)\
-   Password reset & profile editing\
-   Subscription management\
-   Webhook-driven state updates via Supabase Edge Functions

------------------------------------------------------------------------

## 🛒 Buyer Core Functionalities

-   View storefront\
-   View product details\
-   Select variations\
-   Dynamic pricing\
-   Add to cart\
-   Checkout\
-   Delivery selection (Terminal rates)\
-   Payment handling (Safe Haven)\
-   Order confirmation\
-   Error handling states

------------------------------------------------------------------------

## 🚚 Logistics Core Functionalities

-   Create shipment (Terminal API)\
-   Pickup & delivery address management\
-   Shipping option selection\
-   Fee breakdown calculation\
-   Payment processing\
-   Live tracking\
-   Delivery state updates\
-   Delivery ticket system

------------------------------------------------------------------------

# 🧠 Strategic Positioning

This is essentially:

-   A mini Shopify\
-   With embedded banking rails (Safe Haven)\
-   With bank verification (Mono)\
-   With OTP identity verification (Termii)\
-   With logistics orchestration (Terminal Africa)\
-   Controlled entirely via Supabase backend & Edge Functions

It removes the need for:

-   Separate store builders\
-   Separate payment gateway integrations\
-   Separate bank verification providers\
-   Separate logistics dashboards

Everything is centralized into one merchant operating system.
