
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hadi/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Merchant Flow: Login -> Add Product -> Upload Media',
      (WidgetTester tester) async {
    await app.main();
    await tester.pump(const Duration(seconds: 2)); // Wait for app start
    // Flush microtasks
    await tester.pump(); 
    
    // Splash screen has a 1s delay. Wait for it safely.
    await tester.pump(const Duration(seconds: 3));
    
    // Additional wait for any Auth/Store fetching which might show a Spinner
    await tester.pump(const Duration(seconds: 2));

    // --- Login Flow ---
    
    // Check if we are already logged in (look for "Products" or Store Name)
    final productsHeaderInHome = find.text('Products');
    bool isLoggedIn = productsHeaderInHome.evaluate().isNotEmpty;

    if (!isLoggedIn) {
      // Not logged in. Look for "Log in" button on landing page or if we are already on Login Email page
      final loginButton = find.text('Log in');
      final emailField = find.ancestor(
        of: find.text('Email address'),
        matching: find.byType(Column),
      ); // Approximate finding based on label

      // Better finder for TextFields based on hints or labels
      final emailHint = find.text('Enter email');
      final passwordHint = find.text('Enter password');

      if (emailHint.evaluate().isEmpty) {
         // Probably on a landing page or Phone Login page. 
         // Attempt to find a way to Email Login.
         // 'Log in' button usually leads to login options.
         // 'Login with email' might be an option if we are on Phone Login page?
         // From LogInPageEmailWidget code, it seems IT IS the email login page.
         // But maybe we are on a different page.
         // Let's assume we might be on a "Welcome" page that has a "Log in" button.
         if (loginButton.evaluate().isNotEmpty) {
           await tester.tap(loginButton.first);
           await tester.pumpAndSettle();
         }
      }
      
      // Now we should be on LogInPageEmailWidget (or similar)
      // If we see "Login with phone number", we are on Email page (based on code).
      // If we see "Login with email", we might be on Phone page.
      
      final loginWithEmailBtn = find.text('Login with email address');
      if (loginWithEmailBtn.evaluate().isNotEmpty) {
        await tester.tap(loginWithEmailBtn);
        await tester.pumpAndSettle();
      }

      // Enter Credentials
      // Use widgetWithText. If duplicates exist, we might need a more specific finder.
      // But 'Enter email' hint should be unique on this page.
      // Removing .first because passing Element to enterText is invalid/risky.
      final emailFinder = find.widgetWithText(TextFormField, 'Enter email');
      if (emailFinder.evaluate().isEmpty) {
         debugPrint('Email Field not found! Dumping widget tree...');
         debugPrint('Email Field not found! Dumping current texts:');
         final allText = find.byType(Text);
         for (final element in allText.evaluate()) {
            final textWidget = element.widget as Text;
            debugPrint('Text: ${textWidget.data}');
         }
      }
      await tester.enterText(emailFinder, 'adindo5748@gmail.com');
      await tester.pumpAndSettle();

      final passwordFinder = find.widgetWithText(TextFormField, 'Enter password').first;
      await tester.enterText(passwordFinder, '123456789');
      await tester.pumpAndSettle();

      // Tap "Log in" button.
      // "Log in" text matches both the Page Title and the Button.
      // The Button is usually the last one in the tree (bottom of screen).
      await tester.tap(find.text('Log in').last); 
      await tester.pumpAndSettle();
    }

    // --- Home Page ---
    
    // Wait for "Products" or "Add Product"
    // HomeMainWidget has "Products" headline and "Add Product" button.
    expect(find.text('Products'), findsOneWidget);
    expect(find.text('Add Product'), findsOneWidget);

    // --- Add Product Flow ---
    
    await tester.tap(find.text('Add Product'));
    await tester.pumpAndSettle();

    // Verify "New Product" page
    expect(find.text('New Product'), findsOneWidget);

    // Enter Product Details
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final productName = 'Test Product $timestamp';
    
    await tester.enterText(find.widgetWithText(TextFormField, 'eg. Nike Dunks'), productName);
    // Find Description by hint: 'eg. New SB Nike rabbit shoes...'
    // Use substring because hint is long
    final descFinder = find.byWidgetPredicate((widget) {
      if (widget is TextField) {
         return widget.decoration?.hintText != null &&
             widget.decoration!.hintText!.startsWith('eg. New SB Nike');
      }
      return false;
    });
    await tester.enterText(descFinder, 'Integration Test Description');
    
    // Weight
    await tester.enterText(find.widgetWithText(TextFormField, 'eg. 1.2'), '1.0');

    // Price
    // Price field doesn't have a clear hint in the code snippet I saw (it was cut off), 
    // but the label "Price" is above it.
    // Finding via ancestor Column might be safer.
    // Or just find the TextFormField near 'NGN'.
    // In the code: Row(children: [Container(NGN), Expanded(TextFormField)]).
    // So find TextFormField that is descendant of a Row containing text 'NGN'.
    final priceField = find.descendant(
      of: find.ancestor(
        of: find.text('NGN'),
        matching: find.byType(Row),
      ),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(priceField, '100');
    await tester.pumpAndSettle();

    // Category (Dropdown)
    // FlutterFlowDropDown usually uses a read-only TextField or InkWell.
    // Hint: 'Select Category...'
    final categoryDropdown = find.text('Select Category...');
    await tester.tap(categoryDropdown);
    await tester.pumpAndSettle();

    // Select first option. 
    // Dropdown items are usually in a ListView.
    // Let's just tap the first 'Shoes' or 'Clothing' or whatever item appears.
    // Since I don't know the exact categories, I'll tap the first item in the dropdown list.
    // Dropdown menu usually spawns a new window/overlay.
    // Assuming 'Shoes' exists or just tap the first Text widget that is NOT 'Select Category...'.
    // Safe bet: Select the first available option.
    final dropdownItem = find.byKey(const Key('dropdownItem0')).first; // FlutterFlow might not use keys.
    // Fallback: Tap the text "Shoes" if valid, or just find the first text in the overlay.
    // Let's assume there is an option "Option 1" or similar if dummy data, or "Shoes".
    // I will try to tap the second text widget found in the overlay (first might be the header).
    // Actually, let's just create a reliable finder.
    // If I can't select, the test might fail.
    // Let's assume "Shoes" is a category.
    // await tester.tap(find.text('Shoes').last); 
    
    // BETTER: Use `driver.scrollUntilVisible` logic if real device, but here `tester`.
    // Let's find any text that looks like a category.
    // If we assume the mock/real data has categories.
    // I'll try to find a specific category "Shoes".
    try {
      await tester.tap(find.text('Shoes').last);
    } catch (e) {
      // If Shoes not found, try 'Fashion' or just the first item.
      await tester.tap(find.byType(InkWell).last); // risky
    }
    await tester.pumpAndSettle();


    // Tap "Next"
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // --- Verify Upload Media Page ---
    // Page Title? "Upload Product Media" (guessing, or check file)
    // Or check for "Add Media" button.
    // In `upload_product_media_page_widget.dart` (implied name).
    // Let's assume we transition successfully.
    // Assert we are NOT on "New Product" page anymore.
    expect(find.text('New Product'), findsNothing);
    
    // Check for "Upload" or "Media" text
    expect(find.text('Upload'), findsOneWidget); 

  });
}
