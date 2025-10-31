import '../../../core/utils/logger.dart';
import '../../models/user.dart' show AccountBalance, UsageSummary, UsagePeriod;
import 'data_loader.dart';

class MockAppDataService {
  static const String _path = 'assets/data/mock_app_data.json';

  static Future<Map<String, dynamic>?> _getAccountJson(String accountId) async {
    print('[MockAppDataService] _getAccountJson path=$_path');
    final data = await DataLoader.loadJsonFromAssets(_path);
    final accounts = data['accounts'] as List<dynamic>?;
    if (accounts == null) return null;
    return accounts.cast<Map<String, dynamic>?>().firstWhere(
      (a) => a != null && a['id'] == accountId,
      orElse: () => null,
    );
  }

  static Future<AccountBalance?> getAccountBalance(String accountId) async {
    try {
      final account = await _getAccountJson(accountId);
      if (account == null) return null;
      final bal = account['accountBalance'] as Map<String, dynamic>?;
      if (bal == null) return null;
      return AccountBalance(
        currentBalance: (bal['currentBalance'] as num).toDouble(),
        lastPaymentDate: DateTime.parse(bal['lastPaymentDate'] as String),
        lastPaymentAmount: (bal['lastPaymentAmount'] as num).toDouble(),
        nextDueDate: DateTime.parse(bal['nextDueDate'] as String),
        paymentMethod: bal['paymentMethod'] as String,
      );
    } catch (e, st) {
      Logger.error('MockAppDataService.getAccountBalance failed', error: e, stackTrace: st);
      return null;
    }
  }

  static Future<UsageSummary?> getUsageSummary(String accountId) async {
    try {
      final account = await _getAccountJson(accountId);
      if (account == null) return null;
      final usage = account['usageSummary'] as Map<String, dynamic>?;
      if (usage == null) return null;
      UsagePeriod p(Map<String, dynamic> j) => UsagePeriod(
        kwh: (j['kwh'] as num).toDouble(),
        cost: (j['cost'] as num).toDouble(),
        averageDaily: (j['averageDaily'] as num).toDouble(),
      );
      return UsageSummary(
        currentMonth: p(usage['currentMonth'] as Map<String, dynamic>),
        lastMonth: p(usage['lastMonth'] as Map<String, dynamic>),
        yearToDate: p(usage['yearToDate'] as Map<String, dynamic>),
      );
    } catch (e, st) {
      Logger.error('MockAppDataService.getUsageSummary failed', error: e, stackTrace: st);
      return null;
    }
  }
}


