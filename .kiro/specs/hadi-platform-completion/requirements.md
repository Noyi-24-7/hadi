# Requirements Document: Hadi Platform Completion

## Introduction

This document specifies the requirements for completing the Hadi platform - a merchant-focused e-commerce + logistics infrastructure platform. The platform currently has merchant authentication, product management UI, and basic data structures, but is missing critical integration logic for payments (Safe Haven), shipping (Terminal Africa), and the complete buyer-facing storefront experience.

The completion work focuses on implementing the missing "logic gates" that connect existing UI components to third-party services and enable the full buyer journey from product discovery through payment and delivery tracking.

## Glossary

- **Hadi_Platform**: The complete e-commerce and logistics platform system
- **Merchant**: A seller who creates a storefront and manages products
- **Buyer**: A customer who browses and purchases from merchant storefronts
- **Safe_Haven**: The payment processing provider for bank-based payments
- **Terminal_Africa**: The logistics provider for shipping rates, shipment creation, and tracking
- **Mono**: The bank account verification provider
- **Termii**: The OTP verification provider
- **Storefront**: A merchant's public-facing store accessible via shareable link
- **Delivery_Ticket**: A standalone shipment request not tied to a store purchase
- **Pre_Order**: A product marked for future fulfillment with delayed shipment creation
- **Order**: A buyer's purchase transaction including products and delivery
- **Shipment**: A logistics delivery created via Terminal Africa
- **Webhook**: An HTTP callback endpoint that receives event notifications from external services
- **Cart**: A buyer's collection of products selected for purchase
- **Checkout**: The multi-step process where buyers provide delivery details and complete payment
- **Payment_Reference**: A unique identifier for a payment transaction from Safe Haven
- **Shipment_ID**: A unique identifier for a shipment from Terminal Africa
- **Inventory**: The available stock quantity for products and variants
- **Variant**: A product variation based on size and/or color
- **Quote**: A shipping rate estimate from Terminal Africa
- **Edge_Function**: A Supabase serverless function that handles API integrations and webhooks

## Requirements

### Requirement 1: Buyer Storefront Discovery and Browsing

**User Story:** As a buyer, I want to discover and browse merchant storefronts via shareable links, so that I can view available products without creating an account.

#### Acceptance Criteria

1. WHEN a buyer visits a storefront URL with a valid store slug, THE Hadi_Platform SHALL display the merchant's storefront page with banner and product grid
2. WHEN a storefront page loads, THE Hadi_Platform SHALL fetch and display all active products for that store
3. WHEN a buyer clicks on a product in the grid, THE Hadi_Platform SHALL navigate to the product detail page
4. WHEN a storefront URL contains an invalid store slug, THE Hadi_Platform SHALL display an error message indicating the store was not found
5. THE Hadi_Platform SHALL display product images, names, and prices in the storefront grid

### Requirement 2: Product Detail Viewing

**User Story:** As a buyer, I want to view detailed product information including variants, so that I can make informed purchase decisions.

#### Acceptance Criteria

1. WHEN a buyer views a product detail page, THE Hadi_Platform SHALL display product name, description, price, weight, images, and available variants
2. WHEN a product has size variants, THE Hadi_Platform SHALL display all available sizes with their respective prices
3. WHEN a product has color variants, THE Hadi_Platform SHALL display all available colors for the selected size
4. WHEN a buyer selects a size variant, THE Hadi_Platform SHALL update the displayed price to match the variant price
5. WHEN a buyer selects a color variant, THE Hadi_Platform SHALL update the displayed price if the color has a different price
6. WHEN a variant is out of stock, THE Hadi_Platform SHALL disable the selection and display an out-of-stock indicator
7. THE Hadi_Platform SHALL display similar products from the same store at the bottom of the product detail page

### Requirement 3: Shopping Cart Management

**User Story:** As a buyer, I want to add products to a cart and manage quantities, so that I can purchase multiple items in a single transaction.

#### Acceptance Criteria

1. WHEN a buyer clicks "Add to Cart" with a valid product selection, THE Hadi_Platform SHALL add the product with selected variant and quantity to the cart
2. WHEN a buyer adds a product already in the cart, THE Hadi_Platform SHALL increment the quantity for that cart item
3. WHEN a buyer views the cart, THE Hadi_Platform SHALL display all cart items with product names, variant details, quantities, and individual prices
4. WHEN a buyer updates a cart item quantity, THE Hadi_Platform SHALL recalculate the cart subtotal
5. WHEN a buyer removes a cart item, THE Hadi_Platform SHALL update the cart and recalculate the subtotal
6. WHEN a buyer adds a quantity that exceeds available stock, THE Hadi_Platform SHALL prevent the addition and display an error message
7. THE Hadi_Platform SHALL persist cart data in local storage to maintain cart state across page refreshes

### Requirement 4: Buyer Checkout Process

**User Story:** As a buyer, I want to complete a checkout process with delivery details and shipping options, so that I can finalize my purchase.

#### Acceptance Criteria

1. WHEN a buyer initiates checkout, THE Hadi_Platform SHALL navigate to the checkout page displaying cart items and a form for contact and delivery details
2. WHEN a buyer submits valid contact and delivery information, THE Hadi_Platform SHALL proceed to the shipping selection page
3. WHEN the shipping selection page loads, THE Hadi_Platform SHALL fetch shipping rate quotes from Terminal Africa based on delivery address and package weight
4. WHEN Terminal Africa returns shipping quotes, THE Hadi_Platform SHALL display available shipping options with delivery times and costs
5. WHEN a buyer selects a shipping option, THE Hadi_Platform SHALL calculate and display the order breakdown including subtotal, delivery fee, transaction fee, and total amount
6. WHEN a buyer confirms the order, THE Hadi_Platform SHALL create an order record in the database with status "pending_payment"
7. WHEN checkout form validation fails, THE Hadi_Platform SHALL display specific error messages for invalid fields
8. THE Hadi_Platform SHALL validate that delivery address includes required fields: address line, city, state, LGA, and country

### Requirement 5: Terminal Africa Shipping Rate Integration

**User Story:** As a developer, I want to integrate Terminal Africa's rate quote API, so that buyers can see accurate shipping costs during checkout.

#### Acceptance Criteria

1. WHEN the checkout process requests shipping rates, THE Hadi_Platform SHALL call the Terminal Africa rate quote API with pickup address, delivery address, and package details
2. WHEN Terminal Africa returns rate quotes, THE Hadi_Platform SHALL parse and store the quotes in the order_delivery_quotes table
3. WHEN Terminal Africa API returns an error, THE Hadi_Platform SHALL log the error and display a user-friendly message to the buyer
4. THE Hadi_Platform SHALL include package weight calculated from product weights in the rate quote request
5. THE Hadi_Platform SHALL send pickup address from the merchant's default pickup location
6. THE Hadi_Platform SHALL send delivery address from the buyer's checkout form input
7. WHEN multiple shipping options are available, THE Hadi_Platform SHALL display both standard and priority shipping rates

### Requirement 6: Safe Haven Payment Initialization

**User Story:** As a buyer, I want to pay for my order using bank payment rails, so that I can complete my purchase securely.

#### Acceptance Criteria

1. WHEN a buyer confirms an order, THE Hadi_Platform SHALL initialize a payment with Safe Haven including order total, buyer details, and callback URL
2. WHEN Safe Haven returns a payment link, THE Hadi_Platform SHALL redirect the buyer to the Safe Haven payment page
3. WHEN payment initialization succeeds, THE Hadi_Platform SHALL store the Safe Haven payment reference in the order record
4. WHEN payment initialization fails, THE Hadi_Platform SHALL display an error message and allow the buyer to retry
5. THE Hadi_Platform SHALL include the order ID in the payment metadata for reconciliation
6. THE Hadi_Platform SHALL set the payment callback URL to the platform's webhook endpoint
7. THE Hadi_Platform SHALL calculate transaction fees as a percentage of the order total and include them in the payment amount

### Requirement 7: Safe Haven Payment Webhook Handling

**User Story:** As a developer, I want to handle Safe Haven payment webhooks, so that order status updates automatically when payments are confirmed.

#### Acceptance Criteria

1. WHEN Safe Haven sends a payment success webhook, THE Hadi_Platform SHALL verify the webhook signature for authenticity
2. WHEN a payment success webhook is verified, THE Hadi_Platform SHALL update the order status to "paid"
3. WHEN a payment success webhook is verified, THE Hadi_Platform SHALL trigger shipment creation via Terminal Africa
4. WHEN Safe Haven sends a payment failed webhook, THE Hadi_Platform SHALL update the order status to "payment_failed"
5. WHEN Safe Haven sends a payment cancelled webhook, THE Hadi_Platform SHALL update the order status to "cancelled"
6. WHEN a webhook contains an invalid signature, THE Hadi_Platform SHALL reject the webhook and log a security warning
7. THE Hadi_Platform SHALL respond to webhook requests with appropriate HTTP status codes (200 for success, 400 for invalid requests)
8. WHEN webhook processing fails, THE Hadi_Platform SHALL log the error details for debugging

### Requirement 8: Terminal Africa Shipment Creation

**User Story:** As a developer, I want to create shipments via Terminal Africa after successful payment, so that orders are automatically sent to the logistics provider.

#### Acceptance Criteria

1. WHEN an order payment is confirmed, THE Hadi_Platform SHALL create a shipment via Terminal Africa API with pickup details, delivery details, and package information
2. WHEN Terminal Africa returns a shipment ID, THE Hadi_Platform SHALL store the shipment ID in the deliveries table
3. WHEN Terminal Africa returns a tracking URL, THE Hadi_Platform SHALL store the tracking URL in the deliveries table
4. WHEN shipment creation succeeds, THE Hadi_Platform SHALL update the delivery status to "shipment_created"
5. WHEN shipment creation fails, THE Hadi_Platform SHALL log the error and update the order status to "shipment_creation_failed"
6. THE Hadi_Platform SHALL include the selected shipping quote ID when creating the shipment
7. THE Hadi_Platform SHALL send package contents including product names and quantities to Terminal Africa
8. WHEN a shipment is created, THE Hadi_Platform SHALL deduct the ordered quantities from product inventory

### Requirement 9: Terminal Africa Tracking Webhook Handling

**User Story:** As a developer, I want to handle Terminal Africa tracking webhooks, so that delivery status updates automatically as shipments progress.

#### Acceptance Criteria

1. WHEN Terminal Africa sends a tracking update webhook, THE Hadi_Platform SHALL verify the webhook authenticity
2. WHEN a tracking webhook indicates "picked_up" status, THE Hadi_Platform SHALL update the delivery status to "picked_up"
3. WHEN a tracking webhook indicates "in_transit" status, THE Hadi_Platform SHALL update the delivery status to "in_transit"
4. WHEN a tracking webhook indicates "delivered" status, THE Hadi_Platform SHALL update the delivery status to "delivered" and the order status to "completed"
5. WHEN a tracking webhook indicates "failed" status, THE Hadi_Platform SHALL update the delivery status to "failed"
6. THE Hadi_Platform SHALL append tracking events to the tracking_events JSON field in the deliveries table
7. THE Hadi_Platform SHALL respond to tracking webhooks with appropriate HTTP status codes
8. WHEN webhook processing fails, THE Hadi_Platform SHALL log the error details for debugging

### Requirement 10: Inventory Management

**User Story:** As a merchant, I want inventory to be automatically managed, so that buyers cannot purchase out-of-stock items and my stock levels stay accurate.

#### Acceptance Criteria

1. WHEN a shipment is created for an order, THE Hadi_Platform SHALL deduct ordered quantities from product stock_quantity
2. WHEN a product variant is ordered, THE Hadi_Platform SHALL deduct the quantity from the variant's stock_quantity
3. WHEN a product's stock_quantity reaches zero, THE Hadi_Platform SHALL prevent buyers from adding it to cart
4. WHEN a variant's stock_quantity reaches zero, THE Hadi_Platform SHALL disable that variant in the product detail page
5. WHEN an order is cancelled before shipment, THE Hadi_Platform SHALL restore the deducted quantities to inventory
6. THE Hadi_Platform SHALL enforce stock validation during cart operations to prevent overselling
7. THE Hadi_Platform SHALL display current stock levels to merchants in the product management interface

### Requirement 11: Delivery Ticket Payment Integration

**User Story:** As a merchant, I want to pay for delivery-only tickets via Safe Haven, so that I can create standalone shipments outside of store purchases.

#### Acceptance Criteria

1. WHEN a merchant creates a delivery ticket and confirms payment, THE Hadi_Platform SHALL initialize a Safe Haven payment with the delivery cost
2. WHEN Safe Haven returns a payment link for a delivery ticket, THE Hadi_Platform SHALL redirect the merchant to the payment page
3. WHEN a delivery ticket payment succeeds, THE Hadi_Platform SHALL update the delivery ticket payment_status to "paid"
4. WHEN a delivery ticket payment succeeds, THE Hadi_Platform SHALL create a shipment via Terminal Africa
5. WHEN a delivery ticket payment fails, THE Hadi_Platform SHALL update the payment_status to "failed" and allow retry
6. THE Hadi_Platform SHALL store the Safe Haven payment reference in the delivery ticket record
7. THE Hadi_Platform SHALL handle delivery ticket payment webhooks separately from order payment webhooks

### Requirement 12: Pre-Order Shipment Creation

**User Story:** As a merchant, I want to manually trigger shipment creation for pre-orders, so that I can control when pre-ordered items are sent to logistics.

#### Acceptance Criteria

1. WHEN a merchant requests pickup for a pre-order, THE Hadi_Platform SHALL create a shipment via Terminal Africa with the pre-order details
2. WHEN pre-order shipment creation succeeds, THE Hadi_Platform SHALL update the preorder_requests status to "shipment_created"
3. WHEN pre-order shipment creation succeeds, THE Hadi_Platform SHALL store the Terminal shipment ID in the preorder_requests table
4. WHEN a merchant resends a pre-order request, THE Hadi_Platform SHALL update the last_resent_at timestamp
5. THE Hadi_Platform SHALL display tracking information for pre-orders with created shipments
6. WHEN Terminal Africa sends tracking updates for pre-orders, THE Hadi_Platform SHALL update the tracking_events in preorder_requests
7. THE Hadi_Platform SHALL allow merchants to view pre-orders in tabs: Pending, Requested, and Tracking

### Requirement 13: Order Status Transitions

**User Story:** As a developer, I want clear order status transitions, so that the system maintains data integrity and users see accurate order states.

#### Acceptance Criteria

1. WHEN an order is created, THE Hadi_Platform SHALL set the initial status to "pending_payment"
2. WHEN payment is confirmed, THE Hadi_Platform SHALL transition the order status from "pending_payment" to "paid"
3. WHEN shipment creation succeeds, THE Hadi_Platform SHALL transition the order status from "paid" to "shipped"
4. WHEN delivery is confirmed, THE Hadi_Platform SHALL transition the order status from "shipped" to "completed"
5. WHEN payment fails, THE Hadi_Platform SHALL transition the order status to "payment_failed"
6. WHEN payment is cancelled, THE Hadi_Platform SHALL transition the order status to "cancelled"
7. WHEN shipment creation fails, THE Hadi_Platform SHALL transition the order status to "shipment_creation_failed"
8. THE Hadi_Platform SHALL prevent invalid status transitions and log attempts to make them

### Requirement 14: Buyer Order Confirmation and Tracking

**User Story:** As a buyer, I want to see order confirmation and track my delivery, so that I know my purchase was successful and can monitor its progress.

#### Acceptance Criteria

1. WHEN payment succeeds, THE Hadi_Platform SHALL display an order confirmation page with order number and merchant contact details
2. WHEN payment fails, THE Hadi_Platform SHALL display a payment failed page with retry option
3. WHEN payment is cancelled, THE Hadi_Platform SHALL display a cancellation confirmation page
4. WHEN a shipment is created, THE Hadi_Platform SHALL display the tracking URL to the buyer
5. THE Hadi_Platform SHALL allow buyers to view order status without authentication using order number and email
6. WHEN a buyer views order tracking, THE Hadi_Platform SHALL display current delivery status and tracking events
7. THE Hadi_Platform SHALL send order confirmation details to the buyer's email address

### Requirement 15: Error Handling and Retry Logic

**User Story:** As a developer, I want robust error handling for external API failures, so that the system gracefully handles integration issues.

#### Acceptance Criteria

1. WHEN Terminal Africa API is unavailable, THE Hadi_Platform SHALL display an error message and allow users to retry
2. WHEN Safe Haven API is unavailable, THE Hadi_Platform SHALL display an error message and allow users to retry
3. WHEN shipment creation fails due to API error, THE Hadi_Platform SHALL log the error and mark the order for manual review
4. WHEN webhook processing fails, THE Hadi_Platform SHALL log the error and support manual retry
5. THE Hadi_Platform SHALL implement exponential backoff for retrying failed API calls
6. THE Hadi_Platform SHALL set appropriate timeout values for external API calls
7. WHEN API rate limits are exceeded, THE Hadi_Platform SHALL queue requests and retry after the rate limit window

### Requirement 16: Webhook Security

**User Story:** As a developer, I want secure webhook handling, so that only legitimate requests from Safe Haven and Terminal Africa are processed.

#### Acceptance Criteria

1. WHEN a webhook is received, THE Hadi_Platform SHALL verify the request signature using the provider's secret key
2. WHEN a webhook signature is invalid, THE Hadi_Platform SHALL reject the request with HTTP 401 status
3. THE Hadi_Platform SHALL validate that webhook payloads contain required fields before processing
4. THE Hadi_Platform SHALL implement idempotency checks to prevent duplicate webhook processing
5. THE Hadi_Platform SHALL log all webhook requests including headers and payload for audit purposes
6. THE Hadi_Platform SHALL use HTTPS for all webhook endpoints
7. WHEN a webhook contains unexpected data, THE Hadi_Platform SHALL log the anomaly and reject the request

### Requirement 17: Payment Amount Calculation

**User Story:** As a buyer, I want transparent pricing breakdown, so that I understand all costs before completing payment.

#### Acceptance Criteria

1. WHEN checkout displays the order summary, THE Hadi_Platform SHALL show subtotal as the sum of all product prices
2. WHEN a shipping option is selected, THE Hadi_Platform SHALL add the delivery fee to the order total
3. THE Hadi_Platform SHALL calculate transaction fee as a percentage of the subtotal plus delivery fee
4. THE Hadi_Platform SHALL display the final total as subtotal + delivery fee + transaction fee
5. THE Hadi_Platform SHALL store subtotal_amount, delivery_fee, transaction_fee, and total_amount separately in the orders table
6. WHEN product prices include variant pricing, THE Hadi_Platform SHALL use the variant price in calculations
7. THE Hadi_Platform SHALL round all monetary amounts to two decimal places

### Requirement 18: Merchant Revenue and Payout Tracking

**User Story:** As a merchant, I want to track revenue and payouts, so that I can monitor my earnings and financial transactions.

#### Acceptance Criteria

1. WHEN an order is completed, THE Hadi_Platform SHALL include the order amount in the merchant's total revenue calculation
2. WHEN a payout is initiated, THE Hadi_Platform SHALL create a payout record with status "pending"
3. WHEN Safe Haven confirms a payout, THE Hadi_Platform SHALL update the payout status to "completed"
4. THE Hadi_Platform SHALL display total revenue and total items sold on the merchant dashboard
5. THE Hadi_Platform SHALL allow merchants to filter transactions by type: All, Payouts, Orders
6. THE Hadi_Platform SHALL display payout history with dates, amounts, and statuses
7. THE Hadi_Platform SHALL calculate available balance as total revenue minus completed payouts and pending orders

### Requirement 19: Supabase Edge Functions for API Integration

**User Story:** As a developer, I want Supabase Edge Functions to handle external API calls, so that API keys remain secure and integration logic is centralized.

#### Acceptance Criteria

1. THE Hadi_Platform SHALL implement an Edge Function for Terminal Africa rate quote requests
2. THE Hadi_Platform SHALL implement an Edge Function for Terminal Africa shipment creation
3. THE Hadi_Platform SHALL implement an Edge Function for Safe Haven payment initialization
4. THE Hadi_Platform SHALL implement an Edge Function for Safe Haven payment webhook handling
5. THE Hadi_Platform SHALL implement an Edge Function for Terminal Africa tracking webhook handling
6. THE Hadi_Platform SHALL store API keys and secrets as environment variables in Supabase
7. THE Hadi_Platform SHALL implement proper error handling and logging in all Edge Functions
8. THE Hadi_Platform SHALL use Supabase authentication to secure Edge Function endpoints where appropriate

### Requirement 20: Database Schema Updates

**User Story:** As a developer, I want database schema updates to support new functionality, so that all required data can be stored and queried efficiently.

#### Acceptance Criteria

1. THE Hadi_Platform SHALL add a cart_items table to store buyer cart data with columns: id, session_id, product_id, variant_id, quantity, created_at
2. THE Hadi_Platform SHALL add webhook_logs table to store webhook events with columns: id, provider, event_type, payload, signature, processed, created_at
3. THE Hadi_Platform SHALL add shipping_quotes table to store Terminal Africa rate quotes with columns: id, order_id, provider, service_type, rate, currency, estimated_days, created_at
4. THE Hadi_Platform SHALL ensure orders table has columns for safehaven_reference, selected_delivery_quote_id, and all address fields
5. THE Hadi_Platform SHALL ensure deliveries table has columns for terminal_shipment_id, tracking_url, and tracking_events
6. THE Hadi_Platform SHALL ensure delivery_tickets table has columns for terminal_shipment_id, payment_reference, and payment_status
7. THE Hadi_Platform SHALL ensure preorder_requests table has columns for terminal_shipment_id and tracking_events
8. THE Hadi_Platform SHALL add indexes on frequently queried fields: order status, store_id, payment_reference, shipment_id
