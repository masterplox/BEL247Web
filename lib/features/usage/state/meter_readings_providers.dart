import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../data/repositories/meter_readings_repository.dart';

// Repository provider
final meterReadingsRepositoryProvider = Provider<MeterReadingsRepository>((ref) => const MeterReadingsRepository());

// Meter readings provider for this year
final meterReadingsThisYearProvider = FutureProvider<List<MeterReadingDto>>((ref) async {
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccount = accountState.activeAccount;
  
  if (activeAccount == null) {
    return [];
  }

  final repository = ref.watch(meterReadingsRepositoryProvider);
  final readings = await repository.fetchMeterReadingsThisYear(
    customerNumber: activeAccount.customerNumber,
    accountNumber: activeAccount.accountNumber,
  );
  return readings;
});

// Meter readings provider for last year
final meterReadingsLastYearProvider = FutureProvider<List<MeterReadingDto>>((ref) async {
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccount = accountState.activeAccount;
  
  if (activeAccount == null) {
    return [];
  }

  final repository = ref.watch(meterReadingsRepositoryProvider);
  final readings = await repository.fetchMeterReadingsLastYear(
    customerNumber: activeAccount.customerNumber,
    accountNumber: activeAccount.accountNumber,
  );
  return readings;
});
