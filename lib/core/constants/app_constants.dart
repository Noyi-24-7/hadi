/// App-wide business and configuration constants.
/// Use these instead of magic numbers or hardcoded values.
class AppConstants {
  AppConstants._();

  // Currency
  static const String defaultCurrency = 'NGN';
  static const String currencySymbol = '₦';

  // Location
  static const String defaultCountry = 'Nigeria';

  // Business Logic
  /// Transaction fee as a percentage (e.g., 0.015 = 1.5%)
  static const double transactionFeePercentage = 0.015;

  /// Minimum order amount in kobo (NGN)
  static const int minOrderAmountKobo = 10000; // 100 NGN

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // API Timeouts (in seconds)
  static const int defaultTimeoutSeconds = 30;
  static const int longTimeoutSeconds = 60;

  // Validation
  static const int minProductNameLength = 2;
  static const int maxProductNameLength = 100;
  static const int minProductDescriptionLength = 10;
  static const int maxProductDescriptionLength = 1000;
  static const int minPasswordLength = 8;

  // Phone Number
  static const String nigerianPhonePrefix = '+234';
  static const int nigerianPhoneLength = 11; // Without country code

  // File Upload
  static const int maxImageSizeMB = 5;
  static const int maxVideoSizeMB = 50;
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedVideoExtensions = ['mp4', 'mov'];

  // Cache Duration
  static const Duration shortCacheDuration = Duration(minutes: 5);
  static const Duration mediumCacheDuration = Duration(minutes: 30);
  static const Duration longCacheDuration = Duration(hours: 24);

  // Order Status
  static const String orderStatusPendingPayment = 'pending_payment';
  static const String orderStatusPaid = 'paid';
  static const String orderStatusShipped = 'shipped';
  static const String orderStatusCompleted = 'completed';
  static const String orderStatusPaymentFailed = 'payment_failed';
  static const String orderStatusCancelled = 'cancelled';
  static const String orderStatusShipmentCreationFailed = 'shipment_creation_failed';

  // Delivery Status
  static const String deliveryStatusPendingPickup = 'pending_pickup';
  static const String deliveryStatusPickedUp = 'picked_up';
  static const String deliveryStatusInTransit = 'in_transit';
  static const String deliveryStatusDelivered = 'delivered';
  static const String deliveryStatusFailed = 'failed';

  // Payment Status
  static const String paymentStatusUnpaid = 'unpaid';
  static const String paymentStatusPending = 'pending';
  static const String paymentStatusPaid = 'paid';
  static const String paymentStatusFailed = 'failed';
  static const String paymentStatusRefunded = 'refunded';

  // Preorder Status
  static const String preorderStatusPending = 'pending';
  static const String preorderStatusRequested = 'requested';
  static const String preorderStatusTracking = 'tracking';
  static const String preorderStatusDelivered = 'delivered';
  static const String preorderStatusCancelled = 'cancelled';
  static const String preorderStatusFailed = 'failed';
}
