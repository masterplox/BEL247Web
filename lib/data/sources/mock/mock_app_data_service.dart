import '../../../core/utils/logger.dart';
import '../../models/user.dart' show AccountBalance, UsageSummary, UsagePeriod;
import 'data_loader.dart';

class MockAppDataService {
  static const String _path = 'assets/data/mock_app_data.json';

  static Future<Map<String, dynamic>?> _getAccountJson(String accountId) async {
    print('[MockAppDataService] _getAccountJson path=$_path accountId=$accountId');
    final data = await DataLoader.loadJsonFromAssets(_path);
    final accounts = data['accounts'] as List<dynamic>?;
    if (accounts == null) {
      print('[MockAppDataService] accounts key missing in json path=$_path');
      return null;
    }
    final result = accounts.cast<Map<String, dynamic>?>().firstWhere(
      (a) => a != null && a['id'] == accountId,
      orElse: () => null,
    );
    if (result == null) {
      print('[MockAppDataService] no account match for accountId=$accountId in path=$_path');
    }
    return result;
  }

  static Future<AccountBalance?> getAccountBalance(String accountId) async {
    try {
      final account = await _getAccountJson(accountId);
      if (account == null) return null;
      final bal = account['accountBalance'] as Map<String, dynamic>?;
      if (bal == null) {
        print('[MockAppDataService] accountBalance missing for accountId=$accountId');
        return null;
      }
      final balance = AccountBalance(
        currentBalance: (bal['currentBalance'] as num).toDouble(),
        lastPaymentDate: DateTime.parse(bal['lastPaymentDate'] as String),
        lastPaymentAmount: (bal['lastPaymentAmount'] as num).toDouble(),
        nextDueDate: DateTime.parse(bal['nextDueDate'] as String),
        paymentMethod: bal['paymentMethod'] as String,
      );
      print('[MockAppDataService] getAccountBalance ok balance=\$${balance.currentBalance.toStringAsFixed(2)} accountId=$accountId');
      return balance;
    } catch (e, st) {
      Logger.error('MockAppDataService.getAccountBalance failed', error: e, stackTrace: st);
      print('[MockAppDataService][ERROR] getAccountBalance accountId=$accountId error=$e');
      return null;
    }
  }

  static Future<UsageSummary?> getUsageSummary(String accountId) async {
    try {
      final account = await _getAccountJson(accountId);
      if (account == null) return null;
      final usage = account['usageSummary'] as Map<String, dynamic>?;
      if (usage == null) {
        print('[MockAppDataService] usageSummary missing for accountId=$accountId');
        return null;
      }
      UsagePeriod p(Map<String, dynamic> j) => UsagePeriod(
        kwh: (j['kwh'] as num).toDouble(),
        cost: (j['cost'] as num).toDouble(),
        averageDaily: (j['averageDaily'] as num).toDouble(),
      );
      final summary = UsageSummary(
        currentMonth: p(usage['currentMonth'] as Map<String, dynamic>),
        lastMonth: p(usage['lastMonth'] as Map<String, dynamic>),
        yearToDate: p(usage['yearToDate'] as Map<String, dynamic>),
      );
      print('[MockAppDataService] getUsageSummary ok currentMonth=${summary.currentMonth.kwh}kwh cost=\$${summary.currentMonth.cost} accountId=$accountId');
      return summary;
    } catch (e, st) {
      Logger.error('MockAppDataService.getUsageSummary failed', error: e, stackTrace: st);
      print('[MockAppDataService][ERROR] getUsageSummary accountId=$accountId error=$e');
      return null;
    }
  }
}


