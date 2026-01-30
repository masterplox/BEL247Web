import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

/// Account model for managing multiple accounts per user
@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String accountNumber,
    required String customerNumber, // Added customer number field
    required String accountType, // 'residential' or 'commercial'
    required String address,
    required double balance,
    required AccountStatus status, // 'Paid', 'Due', 'Overdue'
    required DateTime? lastPaymentDate,
    required DateTime? nextDueDate,
    @Default(true) bool isActive,
    String? meterNumber,
    String? serviceArea,
    String? nickname, // Account nickname
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  const Account._();

  /// Get formatted account ID (e.g., "00083630: 00066014")
  /// Format: customerNumber: accountNumber
  String get formattedAccountNumber {
    return '$customerNumber: $accountNumber';
  }

  /// Get display address (short format)
  String get displayAddress {
    // Take first part of address (street) or truncate
    if (address.length > 30) {
      return '${address.substring(0, 27)}...';
    }
    return address;
  }

  /// Get account type icon
  String get typeIcon {
    switch (accountType.toLowerCase()) {
      case 'commercial':
      case 'business':
        return 'business';
      case 'residential':
      default:
        return 'home';
    }
  }

  /// Check if account has outstanding balance
  bool get hasBalance => balance > 0;

  /// Get status color based on status
  int get statusColor {
    switch (status) {
      case AccountStatus.paid:
        return 0xFF10B981; // Green
      case AccountStatus.due:
      case AccountStatus.overdue:
        return 0xFFEF4444; // Red
    }
  }
}

enum AccountStatus {
  paid,
  due,
  overdue,
}

/// Account type enum
enum AccountType {
  residential,
  commercial,
}

