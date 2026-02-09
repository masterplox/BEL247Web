import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/meter_data_config.dart';
import 'feature_providers.dart' show accountSwitcherProvider;

/// Resolved data source for the currently active account's meter.
final meterDataSourceProvider = Provider<MeterDataSource>((ref) {
  final meterNumber = ref.watch(accountSwitcherProvider).activeAccount?.meterNumber;
  return MeterDataResolver.resolve(meterNumber);
});

final isAmiMeterProvider = Provider<bool>(
  (ref) => ref.watch(meterDataSourceProvider) == MeterDataSource.ami,
);

