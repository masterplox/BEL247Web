/// Central configuration for deciding which data source to use per meter.
///
/// Goal: keep this easily configurable as meter types evolve without
/// scattering prefix checks across the UI.
library;

enum MeterDataSource {
  /// Legacy monthly readings model (CustomerAccounts/V3/Readings*)
  legacyMonthlyReadings,

  /// AMI endpoints (amiDailyRange / amiMonthlyTotals / amiDailyIntervals)
  ami,
}

class MeterDataRule {
  const MeterDataRule({
    required this.meterNumberPrefix,
    required this.source,
  });

  /// Prefix match against the raw `meterNumber` string.
  final String meterNumberPrefix;
  final MeterDataSource source;
}

class MeterDataResolver {
  const MeterDataResolver._();

  /// Add new meter types here.
  ///
  /// The first matching rule wins.
  static const List<MeterDataRule> rules = <MeterDataRule>[
    // AMI meters (prefix match; first rule wins)
    MeterDataRule(meterNumberPrefix: '0225', source: MeterDataSource.ami),
    MeterDataRule(meterNumberPrefix: '0226', source: MeterDataSource.ami),
    MeterDataRule(meterNumberPrefix: '0425', source: MeterDataSource.ami),
    MeterDataRule(meterNumberPrefix: '0525', source: MeterDataSource.ami),
    MeterDataRule(meterNumberPrefix: '0925', source: MeterDataSource.ami),
    MeterDataRule(meterNumberPrefix: '1225', source: MeterDataSource.ami),
    MeterDataRule(meterNumberPrefix: '1625', source: MeterDataSource.ami),
  ];

  static MeterDataSource resolve(String? meterNumber) {
    final m = (meterNumber ?? '').trim();
    for (final rule in rules) {
      if (m.startsWith(rule.meterNumberPrefix)) return rule.source;
    }
    return MeterDataSource.legacyMonthlyReadings;
  }

  static bool isAmiMeter(String? meterNumber) =>
      resolve(meterNumber) == MeterDataSource.ami;
}

