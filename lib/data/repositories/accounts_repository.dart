import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/account.dart';

class AccountsRepository {
  const AccountsRepository();

  /// Fetch accounts for the given user. Replace mock with real API call.
  Future<List<Account>> fetchUserAccounts(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return [
      Account(
        id: 'account_1',
        accountNumber: '20241234',
        accountType: 'residential',
        address: '42 Marine Parade, Belize City',
        balance: 245.50,
        status: AccountStatus.due,
        lastPaymentDate: DateTime(2025, 9, 15),
        nextDueDate: DateTime(2025, 10, 15),
        meterNumber: 'MTR-001234',
      ),
      Account(
        id: 'account_2',
        accountNumber: '20245678',
        accountType: 'commercial',
        address: '15 Queen Street, Belmopan',
        balance: 1450,
        status: AccountStatus.due,
        lastPaymentDate: DateTime(2025, 9, 10),
        nextDueDate: DateTime(2025, 10, 10),
        meterNumber: 'MTR-005678',
      ),
      Account(
        id: 'account_3',
        accountNumber: '20249012',
        accountType: 'residential',
        address: '8 Coconut Drive, San Pedro',
        balance: 0,
        status: AccountStatus.paid,
        lastPaymentDate: DateTime(2025, 9, 28),
        nextDueDate: DateTime(2025, 10, 28),
        meterNumber: 'MTR-009012',
      ),
    ];
  }
}
// Provider can be added in a providers file if preferred; using inline for simplicity
final accountsRepositoryProvider = Provider<AccountsRepository>((ref) => const AccountsRepository());


