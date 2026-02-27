/// Extension methods for String.
extension StringExtensions on String {
  /// Check if string is a valid email.
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid Nigerian phone number.
  /// Accepts formats: 08012345678, +2348012345678, 2348012345678
  bool get isValidNigerianPhone {
    final cleaned = replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    // Check for +234 format
    if (cleaned.startsWith('+234')) {
      return cleaned.length == 14 && cleaned.substring(4).isNumeric;
    }
    
    // Check for 234 format
    if (cleaned.startsWith('234')) {
      return cleaned.length == 13 && cleaned.substring(3).isNumeric;
    }
    
    // Check for 0 format
    if (cleaned.startsWith('0')) {
      return cleaned.length == 11 && cleaned.isNumeric;
    }
    
    return false;
  }

  /// Check if string contains only digits.
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Capitalize first letter of string.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word.
  String get titleCase {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty ? word : word.capitalize)
        .join(' ');
  }

  /// Truncate string to specified length with ellipsis.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Remove all whitespace from string.
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Format Nigerian phone number to +234 format.
  /// Input: 08012345678 -> Output: +2348012345678
  String toInternationalPhone() {
    final cleaned = replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (cleaned.startsWith('+234')) {
      return cleaned;
    } else if (cleaned.startsWith('234')) {
      return '+$cleaned';
    } else if (cleaned.startsWith('0')) {
      return '+234${cleaned.substring(1)}';
    }
    
    return this;
  }

  /// Format amount in kobo to Naira string.
  /// Input: 150000 -> Output: ₦1,500.00
  String formatKoboToNaira() {
    final amount = int.tryParse(this);
    if (amount == null) return this;
    
    final naira = amount / 100;
    return '₦${naira.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }
}
