# Dynamic Variant Logic – FF vs Clean

## Current FF behavior (to migrate)

- **Add product flow:** `SizeEntryStruct` (label, price, qty) and `ColorEntryStruct` (label, sizeLabel, qty) in add_a_new_product_page; `priceForSizeLabel()` in `lib/flutter_flow/custom_functions.dart`; variants inserted into `product_variants` with size, color, price_amount, quantity.
- **Product detail:** `ProductVariantsTable().queryRows` in widget with FutureBuilder; sizes/colors displayed; price from variant or base product.
- **Components:** `comp_size_qty_row`, `comp_color_qty_row` for merchant add-product UI.

## Domain rules

- One variant per (product_id, size, color) as per DB.
- Resolve variant by product id + optional size + optional color.
- Current price: variant price if variant selected, else product base price.
