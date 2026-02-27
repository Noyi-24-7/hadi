---
description: Hadi Project Integrity Audit & Testing Readiness Check
---

# Hadi Total-System Spec-Driven Workflow

## Step 1: Context Synchronization & Global Audit
- Load @HADI_PRODUCT_INFO.md, @STANDARD.md, and all files in @.kiro/specs/.
- Audit the current `lib/` directory. Identify the "Active Frontier" in @MASTER_EXECUTION_PLAN.md.
- **Verification**: Ensure all dependencies in `pubspec.yaml` match the latest library standards via **Context7**.

## Step 2: Strategic Module Refactor
- Refactor the code for the current module into Feature-First Clean Architecture.
- **Data Layer**: Use **Supabase MCP** to verify table schemas (merchants, products, variants, orders, delivery_tickets).
- **Domain Layer**: Implement `Either<Failure, Success>` for all repository calls.
- **Presentation**: Implement Riverpod `AsyncNotifier` for state.

## Step 3: Global Runtime Launch
- Initialize the headless testing environment: `dart-mcp-server-launch-app`.
- Start the app session and capture the **DTD (Dart Tooling Daemon) URI**.

## Step 4: Automated Widget Tree Inspection (The "Total Hadi Audit")
Use `dart-mcp-server-get-widget-tree` to verify the following flows across ALL screens:

### A. Merchant Experience Audit
- **Onboarding Flow**: Verify OTP input field masks, "Incomplete Info" state handling, and bank verification (Mono) modal transitions.
- **Dashboard Flow**: Check conditional rendering of the "Full Dashboard" vs. "Setup Tasks" based on business verification state.
- **Product Engine**: Inspect the "Add Product" widget tree. Verify that Size/Color variations dynamically generate price/quantity fields and update total inventory logic.
- **Financials**: Audit the Revenue/Order management screens for correct formatting of Safe Haven payout records.

### B. Buyer Experience Audit
- **Storefront Flow**: Verify the public storefront renders the Merchant banner and product grid dynamically from Supabase.
- **Product Details**: Verify the selector images, dynamic price updates when changing variants, and "Out of Stock" disabled states.
- **Checkout Pipeline**: Verify Page 1 (Contact/Address) validation and Page 2 (Terminal Shipping Rates) dynamic breakdown calculation.

### C. Logistics & Backend Audit
- **Delivery Flow**: Inspect the "Delivery Ticket" creation screen. Verify item image upload progress bars and Terminal Africa rate fetching.
- **Payment States**: Force-test UI for Success, "Shipment Not Created," Cancelled, and Retry states.

## Step 5: Final Verification & Evidence Artifacts
- Run `flutter analyze` to ensure zero linting errors.
- Use the **Browser Subagent** to execute a full Buyer journey (Select -> Checkout -> Pay) and a Merchant journey (Add Product -> Create Delivery).
- **Deliverable**: Provide a "Hadi System Health Report" with screenshots and widget tree logs for EVERY journey completed.