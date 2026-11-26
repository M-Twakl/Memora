import 'package:memora/core/constants/app_strings.dart';

/// Centralized validator utility class for validating user input across the app.
abstract class AppValidators {
  // Regex Patterns
  static final RegExp nationalIdRegex = RegExp(r'^\d{14}$');
  static final RegExp egyptianPhoneRegex = RegExp(r'^01[0125]\d{8}$');
  static final RegExp gmailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
    caseSensitive: false,
  );
  static final RegExp uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp digitRegex = RegExp(r'[0-9]');
  static final RegExp specialCharRegex = RegExp(r'[^a-zA-Z0-9]');

  /// Validates Egyptian National ID:
  /// - Exactly 14 digits
  /// - Numeric only
  static String? validateNationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterNationalId;
    }
    final trimmed = value.trim();
    if (!nationalIdRegex.hasMatch(trimmed)) {
      return AppStrings.invalidNationalId;
    }
    return null;
  }

  /// Validates Email or Phone Number field:
  /// - If phone: must be exactly 11 digits, begins with 01 followed by {0, 1, 2, 5}
  /// - If email: must end with "@gmail.com" and be a valid format
  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterEmailOrPhone;
    }
    final trimmed = value.trim();

    // If contains only digits, validate as Egyptian phone number
    if (RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
      if (trimmed.length != 11) {
        return AppStrings.invalidPhoneLength;
      }
      if (!egyptianPhoneRegex.hasMatch(trimmed)) {
        return AppStrings.invalidPhonePrefix;
      }
      return null;
    }

    // If it contains '@', validate as Gmail address
    if (trimmed.contains('@')) {
      if (!trimmed.toLowerCase().endsWith('@gmail.com')) {
        return AppStrings.invalidGmailDomain;
      }
      if (!gmailRegex.hasMatch(trimmed)) {
        return AppStrings.invalidGmail;
      }
      return null;
    }

    return AppStrings.invalidEmailOrPhone;
  }

  /// Validates Egyptian Phone Number:
  /// - Exactly 11 digits
  /// - Starts with 010, 011, 012, or 015
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterEmailOrPhone;
    }
    final trimmed = value.trim();
    if (!RegExp(r'^[0-9]+$').hasMatch(trimmed) || trimmed.length != 11) {
      return AppStrings.invalidPhoneLength;
    }
    if (!egyptianPhoneRegex.hasMatch(trimmed)) {
      return AppStrings.invalidPhonePrefix;
    }
    return null;
  }

  /// Validates Gmail Address:
  /// - Must end with "@gmail.com"
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.enterEmailOrPhone;
    }
    final trimmed = value.trim();
    if (!trimmed.toLowerCase().endsWith('@gmail.com')) {
      return AppStrings.invalidGmailDomain;
    }
    if (!gmailRegex.hasMatch(trimmed)) {
      return AppStrings.invalidGmail;
    }
    return null;
  }

  /// Validates Password:
  /// - Between 6 and 10 characters long
  /// - Must include numbers
  /// - Must include lowercase letters
  /// - Must include uppercase letters
  /// - Must include special characters
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterPassword;
    }
    if (value.length < 6 || value.length > 10) {
      return AppStrings.passwordLength;
    }
    if (!uppercaseRegex.hasMatch(value)) {
      return AppStrings.passwordUppercase;
    }
    if (!lowercaseRegex.hasMatch(value)) {
      return AppStrings.passwordLowercase;
    }
    if (!digitRegex.hasMatch(value)) {
      return AppStrings.passwordNumber;
    }
    if (!specialCharRegex.hasMatch(value)) {
      return AppStrings.passwordSpecialChar;
    }
    return null;
  }

  /// Validates New Password (matching Figma Frame 1:1157):
  /// - Minimum 6 characters (up to 10 characters)
  /// - Dynamic length notice: "Use at least 6 characters. You’ve entered X."
  /// - Requires uppercase, lowercase, number, and special character
  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterPassword;
    }
    if (value.length < 6) {
      return 'Use at least 6 characters. You’ve entered ${value.length}.';
    }
    if (value.length > 10) {
      return AppStrings.passwordLength;
    }
    if (!uppercaseRegex.hasMatch(value)) {
      return AppStrings.passwordUppercase;
    }
    if (!lowercaseRegex.hasMatch(value)) {
      return AppStrings.passwordLowercase;
    }
    if (!digitRegex.hasMatch(value)) {
      return AppStrings.passwordNumber;
    }
    if (!specialCharRegex.hasMatch(value)) {
      return AppStrings.passwordSpecialChar;
    }
    return null;
  }

  /// Validates Confirm Password (matching Figma Frame 1:1157):
  /// - Must not be empty
  /// - Must exactly match originalPassword
  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterConfirmPassword;
    }
    if (value != originalPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}

/// Convenience alias for [AppValidators].
typedef Validators = AppValidators;
