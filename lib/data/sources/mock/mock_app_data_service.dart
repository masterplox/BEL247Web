import '../../../core/utils/logger.dart';
import '../../models/api_dtos.dart';
import '../../models/user.dart' show AccountBalance, UsageSummary, UsagePeriod;
import 'data_loader.dart';
import 'mock_asset_paths.dart';

class MockAppDataService {
  static const String _path = MockAssetPaths.appData;
  static const String _energyPricesPath = MockAssetPaths.energyPrices;

  static Future<Map<String, dynamic>?> _getAccountJson(String accountId) async {
    final data = await DataLoader.loadJsonFromAssets(_path);
    final accounts = data['accounts'] as List<dynamic>?;
    if (accounts == null) {
      return null;
    }
    final result = accounts.cast<Map<String, dynamic>?>().firstWhere(
      (a) => a != null && a['id'] == accountId,
      orElse: () => null,
    );
    if (result == null) {
    }
    return result;
  }

  static Future<List<EnergyPricePoint>?> getEnergyPrices() async {
    try {
      final data = await DataLoader.loadJsonFromAssets(_energyPricesPath);
      
      final prices = data['energyPrices'] as List<dynamic>?;
      if (prices == null) {
        return null;
      }
      
      final result = prices
          .cast<Map<String, dynamic>?>()
          .where((p) => p != null)
          .map((p) => EnergyPricePoint.fromJson(p!))
          .toList();
      return result;
    } catch (e, st) {
      Logger.error('MockAppDataService.getEnergyPrices failed', error: e, stackTrace: st);
      return null;
    }
  }

  static Future<DashboardData?> getDashboardData(String accountId) async {
    try {
      final data = await DataLoader.loadJsonFromAssets(_path);
      if (data['dashboard'] == null) {
        return null;
      }
      final dashboardData = DashboardData.fromJson(data['dashboard'] as Map<String, dynamic>);
      return dashboardData;
    } catch (e, st) {
      Logger.error('MockAppDataService.getDashboardData failed', error: e, stackTrace: st);
      return null;
    }
  }

  static Future<AccountBalance?> getAccountBalance(String accountId) async {
    try {
      final account = await _getAccountJson(accountId);
      if (account == null) return null;
      final bal = account['accountBalance'] as Map<String, dynamic>?;
      if (bal == null) {
        return null;
      }
      final balance = AccountBalance(
        currentBalance: (bal['currentBalance'] as num).toDouble(),
        lastPaymentDate: DateTime.parse(bal['lastPaymentDate'] as String),
        lastPaymentAmount: (bal['lastPaymentAmount'] as num).toDouble(),
        nextDueDate: DateTime.parse(bal['nextDueDate'] as String),
        paymentMethod: bal['paymentMethod'] as String,
      );
      return balance;
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
      if (usage == null) {
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
      return summary;
    } catch (e, st) {
      Logger.error('MockAppDataService.getUsageSummary failed', error: e, stackTrace: st);
      return null;
    }
  }
}


