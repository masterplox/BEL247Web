import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers/account_verification_providers.dart';
import '../../core/providers/feature_providers.dart';
import '../../core/utils/account_connection_utils.dart';
import '../../core/widgets/app_empty_state.dart';
import '../../data/models/ami_bucket_parser.dart';
import '../../data/models/ami_data.dart';
import '../../data/models/api_response_dtos.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'ami_usage_date_limits.dart';
import 'state/ami_usage_providers.dart' show amiDailyIntervalsProvider, amiDailyRangeRowsProvider, amiMonthlyTotalsProvider, amiMonthlyTotalsResultProvider, amiTouRangeDataProvider, dayTouFromMonthlyRows, touTotalFromMonthlyRows, DayTou;
import 'widgets/ami_day_chart.dart';
import 'widgets/ami_detail_cards.dart'
    show AmiDetail, AmiDetailCard, HourlyDetail, DayDetail, MonthDetail;
import 'widgets/ami_filter_controls.dart';
import 'widgets/ami_period_chart.dart';
import 'widgets/ami_summary_cards.dart';

enum FilterType { day, week, month, year }

/// BEL rate schedule (standard energy rate).
const String _kStandardEnergyRateScheduleUrl =
    'https://www.bel.com.bz/Rate_Schedule.aspx';

class AmiUsagePage extends ConsumerStatefulWidget {
  const AmiUsagePage({super.key});

  @override
  ConsumerState<AmiUsagePage> createState() => _AmiUsagePageState();
}

class _AmiUsagePageState extends ConsumerState<AmiUsagePage> {
  FilterType _filterType = FilterType.day;
  // Independent anchor dates per filter so changing one does not affect others.
  DateTime _dayDate = AmiUsageDateLimits.lastSelectableDate;
  DateTime _weekDate = AmiUsageDateLimits.lastSelectableDate;
  DateTime _monthDate = AmiUsageDateLimits.lastSelectableDate;
  DateTime _yearDate = AmiUsageDateLimits.lastSelectableDate;
  int? _selectedIndex;

  /// User-selected week range (any span up to 7 days). Null = use getWeekRange(_weekDate).
  DateTime? _weekRangeStart;
  DateTime? _weekRangeEnd;

  /// Tracks when data for the current view was last fetched (page open, filter/date change, or manual refresh).
  DateTime _lastRefreshed = DateTime.now();

  late final TapGestureRecognizer _standardEnergyRateLinkTap;

  @override
  void initState() {
    super.initState();
    _standardEnergyRateLinkTap = TapGestureRecognizer()
      ..onTap = _openStandardEnergyRateSchedule;
  }

  Future<void> _openStandardEnergyRateSchedule() async {
    final uri = Uri.parse(_kStandardEnergyRateScheduleUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _standardEnergyRateLinkTap.dispose();
    super.dispose();
  }

  void _handleFilterChange(FilterType filter) {
    setState(() {
      _filterType = filter;
      _selectedIndex = null;
      _lastRefreshed = DateTime.now();
    });
  }

  void _handleDateChange(DateTime date) {
    setState(() {
      switch (_filterType) {
        case FilterType.day:
          _dayDate = date;
          break;
        case FilterType.week:
          _weekDate = date;
          break;
        case FilterType.month:
          _monthDate = date;
          break;
        case FilterType.year:
          _yearDate = date;
          break;
      }
      _selectedIndex = null;
      _lastRefreshed = DateTime.now();
      if (_filterType == FilterType.week) {
        final startDay = DateTime(date.year, date.month, date.day);
        _weekRangeStart = startDay;
        _weekRangeEnd = startDay.add(const Duration(days: 6));
      }
    });
  }

  /// Apply user-selected week range (max 7 days). Used when they pick a range in the calendar.
  void _handleWeekRangeChange(DateTime start, DateTime end) {
    final startDay = DateTime(start.year, start.month, start.day);
    var endDay = DateTime(end.year, end.month, end.day);
    final days = endDay.difference(startDay).inDays + 1;
    if (days > 7) {
      endDay = startDay.add(const Duration(days: 6));
    }
    setState(() {
      _weekRangeStart = startDay;
      _weekRangeEnd = endDay;
      _weekDate = startDay;
      _selectedIndex = null;
      _lastRefreshed = DateTime.now();
    });
  }

  /// Forces a fresh fetch of the current view's data and updates the refresh timestamp.
  void _handleRefresh(int meterId) {
    setState(() {
      _lastRefreshed = DateTime.now();
      _selectedIndex = null;
    });
    switch (_filterType) {
      case FilterType.day:
        ref.invalidate(amiDailyIntervalsProvider((meterId: meterId, targetDate: _dayDate)));
        break;
      case FilterType.week:
        final range = _getWeekRange();
        ref.invalidate(amiDailyRangeRowsProvider((
          meterId: meterId,
          startDate: range.start,
          endDate: range.end,
        )));
        break;
      case FilterType.month:
        final monthRange = getMonthRange(_monthDate);
        ref.invalidate(amiDailyRangeRowsProvider((
          meterId: meterId,
          startDate: monthRange.start,
          endDate: monthRange.end,
        )));
        break;
      case FilterType.year:
        ref.invalidate(amiMonthlyTotalsResultProvider((meterId: meterId, year: _yearDate.year)));
        break;
    }
  }

  /// Formats the last-refreshed timestamp as "Last refreshed at 3:45 PM".
  String _formatRefreshTime(DateTime t) {
    final h = t.hour;
    final m = t.minute.toString().padLeft(2, '0');
    final period = h < 12 ? 'AM' : 'PM';
    final displayHour = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return 'Last refreshed at $displayHour:$m $period';
  }

  /// Current week range for display and data: user selection or default week containing _weekDate.
  ({DateTime start, DateTime end}) _getWeekRange() {
    if (_weekRangeStart != null && _weekRangeEnd != null) {
      return (start: _weekRangeStart!, end: _weekRangeEnd!);
    }
    final r = getWeekRange(_weekDate);
    return (start: r.start, end: r.end);
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountSwitcherProvider);
    final accounts = accountState.accounts;

    // Show loading indicator while accounts are being fetched
    if (!accountState.isInitialized) {
      return const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Smart Meter Data'),
        //   centerTitle: false,
        //   elevation: 0,
        // ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show empty state only after accounts have been fetched and confirmed empty
    if (accounts.isEmpty) {
      return Scaffold(
        body: Center(
          child: AppEmptyState(
            title: 'No Connected Accounts',
            message:
                'You don\'t have any accounts connected yet. Connect an account to view your smart meter data and energy consumption.',
            icon: Icons.electric_meter_outlined,
            actionLabel: 'Connect Account',
            onAction: () => showConnectAccountDialogAndRefresh(context, ref),
          ),
        ),
      );
    }

    final hasPremiumAccess =
        ref.watch(accountVerificationStatusProvider).valueOrNull ?? false;
    final Set<FilterType>? allowedFilters =
        hasPremiumAccess ? null : {FilterType.year};
    if (!hasPremiumAccess && _filterType != FilterType.year) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _filterType = FilterType.year);
        }
      });
    }

    // Get active account and meter ID
    final activeAccount = accountState.activeAccount;
    if (activeAccount == null || activeAccount.meterNumber == null) {
      return const Scaffold(
        body: Center(
          child: AppEmptyState(
            title: 'No Meter Information',
            message:
                'Your account does not have meter information. Please contact appsupport@bel.com.bz',
            icon: Icons.electric_meter_outlined,
          ),
        ),
      );
    }

    // Convert meterNumber string to int (handle potential parsing errors)
    final meterId = int.tryParse(activeAccount.meterNumber!) ?? 0;
    if (meterId == 0) {
      return const Scaffold(
        body: Center(
          child: AppEmptyState(
            title: 'Invalid Meter Number',
            message:
                'Your account has an invalid meter number. Please contact appsupport@bel.com.bz',
            icon: Icons.electric_meter_outlined,
          ),
        ),
      );
    }

    // Watch the appropriate provider based on filter type
    final dataAsync = _watchDataProvider(meterId);

    // Week/month: TOU comes from DailyRangeBucket. Year: MonthlyTotalsBucket.
    DateTime? rangeStart;
    DateTime? rangeEnd;
    if (_filterType == FilterType.week) {
      final r = _getWeekRange();
      rangeStart = r.start;
      rangeEnd = r.end;
    } else if (_filterType == FilterType.month) {
      final r = getMonthRange(_monthDate);
      rangeStart = r.start;
      rangeEnd = r.end;
    }
    final touRangeAsync = (rangeStart != null && rangeEnd != null)
        ? ref.watch(amiTouRangeDataProvider((
            meterId: meterId,
            startDate: rangeStart,
            endDate: rangeEnd,
          )))
        : null;
    final yearTouAsync = _filterType == FilterType.year
        ? ref.watch(amiMonthlyTotalsProvider((meterId: meterId, year: _yearDate.year)))
        : null;
    final touTotal = touRangeAsync?.whenOrNull(data: (v) => v.total) ??
        yearTouAsync?.whenOrNull(data: touTotalFromMonthlyRows);
    final touPerDay = touRangeAsync?.whenOrNull(data: (v) => v.perDay) ??
        yearTouAsync?.whenOrNull(data: dayTouFromMonthlyRows) ??
        const <DayTou>[];
    final isTouLoading = (rangeStart != null && rangeEnd != null) &&
        touRangeAsync?.whenOrNull(data: (v) => v.total) == null;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Smart Meter Data'),
      //   centerTitle: false,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint
                ? AppTheme.spacing16
                : AppTheme.spacing24,
          ),
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header
              Text(
                'Usage History',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: AppTheme.spacing4),
              Text(
                'View your detailed energy consumption by hour, day, week, month, or year',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: AppTheme.spacing20),

              if (!hasPremiumAccess) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'Basic access includes yearly usage history only. '
                    'Upgrade to Premium Level to unlock day, week, and month views.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing12),
              ],
              AmiFilterControls(
                filterType: _filterType,
                onFilterChange: _handleFilterChange,
                currentDate: _currentFilterDate,
                onDateChange: _handleDateChange,
                dateLabel: _filterDateLabel,
                lastSelectableDate: AmiUsageDateLimits.lastSelectableDate,
                weekRange: _filterType == FilterType.week
                    ? DateTimeRange(
                        start: _getWeekRange().start,
                        end: _getWeekRange().end,
                      )
                    : null,
                onWeekRangeChange:
                    _filterType == FilterType.week ? _handleWeekRangeChange : null,
                allowedFilters: allowedFilters,
              ),
              const SizedBox(height: AppTheme.spacing16),

              dataAsync.when(
                data: (data) => _buildLoadedContent(
                  context,
                  data: data,
                  meterId: meterId,
                  touPerDay: touPerDay,
                  touTotal: touTotal,
                  isTouLoading: isTouLoading,
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 80),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: AppEmptyState(
                      title: 'Error Loading Data',
                      message:
                          'Failed to load smart meter data. Please try again.',
                      icon: Icons.error_outline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _filterDateLabel {
    switch (_filterType) {
      case FilterType.day:
        return _formatDateLong(_dayDate);
      case FilterType.week:
        final range = _getWeekRange();
        return formatDateRange(range.start, range.end);
      case FilterType.month:
        return _formatMonthYear(_monthDate);
      case FilterType.year:
        return _yearDate.year.toString();
    }
  }

  Widget _buildLoadedContent(
    BuildContext context, {
    required ({
      List<DailyReading> dailyData,
      List<HourlyData> hourlyData,
      dynamic stats,
      String dateLabel,
      AmiDetail? selectedDetail,
    }) data,
    required int meterId,
    required List<DayTou> touPerDay,
    required TouConsumption? touTotal,
    required bool isTouLoading,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmiSummaryCards(
            totalKWh: _getSummaryTotalKwh(
              data.stats,
              filterType: _filterType,
              touPerDay: touPerDay,
            ),
            peakKWh: _getSummaryPeakKwh(
              data.stats,
              filterType: _filterType,
              touPerDay: touPerDay,
            ),
            peakTime: _getSummaryPeakLabel(
              data.stats,
              filterType: _filterType,
              touPerDay: touPerDay,
            ),
            avgKWh: _getSummaryAvgKwh(
              data.stats,
              filterType: _filterType,
              touPerDay: touPerDay,
            ),
            filterType: _filterType,
          ),
          const SizedBox(height: AppTheme.spacing20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    _getChartTitle(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: 0.5,
                          color: AppColors.textSecondary,
                        ),
                  ),
                  Text(
                    'Tap a point for details',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    size: 11,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    _formatRefreshTime(_lastRefreshed),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(width: 2),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      onPressed: () => _handleRefresh(meterId),
                      padding: EdgeInsets.zero,
                      tooltip: 'Refresh data',
                      icon: const Icon(
                        Icons.refresh_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_filterType == FilterType.day)
                AmiDayChart(
                  data: data.hourlyData,
                  selectedHour: _selectedIndex,
                  onSelectHour: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                )
              else
                AmiPeriodChart(
                  data: data.dailyData,
                  filterType: _filterType,
                  selectedIndex: _selectedIndex,
                  onSelectIndex: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  touPerDay: touPerDay.isNotEmpty ? touPerDay : null,
                  showLoading: isTouLoading,
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing20),
          if (_selectedIndex != null && data.selectedDetail != null)
            AmiDetailCard(
              detail: data.selectedDetail!,
              onClose: () {
                setState(() {
                  _selectedIndex = null;
                });
              },
            ),
          const SizedBox(height: AppTheme.spacing20),
          _buildTimeOfUseSection(
            context,
            filterType: _filterType,
            dayTou: _filterType == FilterType.day
                ? computeTouFromHourly(data.hourlyData)
                : null,
            rangeTou: _filterType == FilterType.day ? null : touTotal,
          ),
        ],
      );

  Widget _buildTimeOfUseSection(
    BuildContext context, {
    required FilterType filterType,
    TouConsumption? dayTou,
    TouConsumption? rangeTou,
  }) {
    final tou = dayTou ?? rangeTou;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time of Use Consumption',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.info.withValues(alpha: 0.4),
              ),
            ),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                children: [
                  const TextSpan(
                    text:
                        'Use this view to explore how energy use changes throughout the day.\n'
                        'Your current bill is calculated using a ',
                  ),
                  TextSpan(
                    text: 'standard energy rate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                    recognizer: _standardEnergyRateLinkTap,
                  ),
                  const TextSpan(
                    text: ', regardless of time of day.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          if (tou == null)
            const Padding(
              padding: EdgeInsets.all(AppTheme.spacing12),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final useColumn = constraints.maxWidth < 640;
                final periods = [
                  _buildTimeOfUsePeriod(
                    context,
                    'Off-Peak',
                    '12:00 AM - 10:00 AM',
                    AppColors.primary,
                    tou.offPeakKwh,
                  ),
                  _buildTimeOfUsePeriod(
                    context,
                    'Peak',
                    '11:00 AM - 8:00 PM',
                    AppColors.info,
                    tou.peakKwh,
                  ),
                  _buildTimeOfUsePeriod(
                    context,
                    'Mid-Peak',
                    '9:00 PM - 11:00 PM',
                    AppColors.chart3,
                    tou.midPeakKwh,
                  ),
                ];
                if (useColumn) {
                  return Column(
                    children: [
                      periods[0],
                      const SizedBox(height: AppTheme.spacing12),
                      periods[1],
                      const SizedBox(height: AppTheme.spacing12),
                      periods[2],
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: periods[0]),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(child: periods[1]),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(child: periods[2]),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTimeOfUsePeriod(
    BuildContext context,
    String label,
    String time,
    Color color,
    double kwh,
  ) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              '${kwh.toStringAsFixed(1)} kWh',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
            ),
          ],
        ),
      );

  String _getChartTitle() {
    switch (_filterType) {
      case FilterType.day:
        return 'HOURLY CONSUMPTION (kWh)';
      case FilterType.week:
      case FilterType.month:
        return 'DAILY CONSUMPTION (kWh)';
      case FilterType.year:
        return 'MONTHLY CONSUMPTION (kWh)';
    }
  }

  /// Current anchor date for the active filter, used by the shared date picker.
  DateTime get _currentFilterDate {
    switch (_filterType) {
      case FilterType.day:
        return _dayDate;
      case FilterType.week:
        // Use the start of the current week range as the anchor.
        return _getWeekRange().start;
      case FilterType.month:
        return _monthDate;
      case FilterType.year:
        return _yearDate;
    }
  }

  // ---- Summary helpers ------------------------------------------------------

  double _getSummaryTotalKwh(
    dynamic stats, {
    required FilterType filterType,
    required List<DayTou> touPerDay,
  }) {
    if (filterType == FilterType.day) {
      return (stats as HourlyStats).totalKWh;
    }
    final dailyStats = stats as DailyStats;
    if ((filterType == FilterType.week || filterType == FilterType.month) &&
        dailyStats.totalKWh == 0 &&
        touPerDay.isNotEmpty) {
      final totals = touPerDay
          .map((d) => d.offKwh + d.peakKwh + d.midPeakKwh)
          .toList();
      final total = totals.fold<double>(0, (a, b) => a + b);
      return double.parse(total.toStringAsFixed(2));
    }
    return dailyStats.totalKWh;
  }

  double _getSummaryAvgKwh(
    dynamic stats, {
    required FilterType filterType,
    required List<DayTou> touPerDay,
  }) {
    if (filterType == FilterType.day) {
      return (stats as HourlyStats).avgKWh;
    }
    final dailyStats = stats as DailyStats;
    if ((filterType == FilterType.week || filterType == FilterType.month) &&
        dailyStats.totalKWh == 0 &&
        touPerDay.isNotEmpty) {
      final totals = touPerDay
          .map((d) => d.offKwh + d.peakKwh + d.midPeakKwh)
          .toList();
      if (totals.isEmpty) return 0;
      final total = totals.fold<double>(0, (a, b) => a + b);
      final avg = total / totals.length;
      return double.parse(avg.toStringAsFixed(2));
    }
    return dailyStats.avgKWh;
  }

  double _getSummaryPeakKwh(
    dynamic stats, {
    required FilterType filterType,
    required List<DayTou> touPerDay,
  }) {
    if (filterType == FilterType.day) {
      return (stats as HourlyStats).peakKWh;
    }
    final dailyStats = stats as DailyStats;
    if ((filterType == FilterType.week || filterType == FilterType.month) &&
        dailyStats.totalKWh == 0 &&
        touPerDay.isNotEmpty) {
      final totals = touPerDay
          .map((d) => d.offKwh + d.peakKwh + d.midPeakKwh)
          .toList();
      if (totals.isEmpty) return 0;
      final peak = totals.reduce((a, b) => a > b ? a : b);
      return double.parse(peak.toStringAsFixed(2));
    }
    return dailyStats.peakKWh;
  }

  String _getSummaryPeakLabel(
    dynamic stats, {
    required FilterType filterType,
    required List<DayTou> touPerDay,
  }) {
    if (filterType == FilterType.day) {
      return (stats as HourlyStats).peakTime;
    }
    final dailyStats = stats as DailyStats;
    if ((filterType == FilterType.week || filterType == FilterType.month) &&
        dailyStats.totalKWh == 0 &&
        touPerDay.isNotEmpty) {
      final totals = touPerDay
          .map((d) => d.offKwh + d.peakKwh + d.midPeakKwh)
          .toList();
      if (totals.isEmpty) return '-';
      final peak = totals.reduce((a, b) => a > b ? a : b);
      final peakIndex = totals.indexOf(peak);
      final peakDate = touPerDay[peakIndex].date;
      return _formatShortDateForSummary(peakDate);
    }
    return dailyStats.peakDate;
  }

  String _formatShortDateForSummary(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  DailyStats _applyBucketSummary(
    DailyStats computed,
    AmiBucketSummary summary, {
    List<String>? monthNames,
  }) {
    var peakDate = computed.peakDate;
    if (summary.peakDate != null) {
      peakDate = formatAmiPeakDate(summary.peakDate!);
    } else if (summary.peakMonth != null &&
        monthNames != null &&
        summary.peakMonth! >= 1 &&
        summary.peakMonth! <= 12) {
      peakDate = monthNames[summary.peakMonth! - 1];
    }
    return DailyStats(
      totalKWh: summary.totalKwh ?? computed.totalKWh,
      estimatedCost: computed.estimatedCost,
      avgKWh: summary.avgKwh ?? computed.avgKWh,
      peakKWh: summary.peakKwh ?? computed.peakKWh,
      peakDate: peakDate,
    );
  }

  /// Transform IntervalUsageEntryDto to IntervalReading
  IntervalReading _dtoToIntervalReading(IntervalUsageEntryDto dto) =>
      IntervalReading(
        readDate: dto.readDate,
        meterId: dto.meterId,
        firstIntervalDateTime: dto.firstIntervalDateTime,
        intervalDateTime: dto.intervalDateTime,
        intervalNumber: dto.intervalNumber,
        value: dto.kWh.toStringAsFixed(4),
      );

  /// Transform DailyUsageEntryDto to DailyReading
  DailyReading _dtoToDailyReading(DailyUsageEntryDto dto, String meterId) =>
      DailyReading(
        meter: meterId,
        readDate: dto.usageDate,
        kWhUsed: dto.dailyUsageKwh.toStringAsFixed(3),
      );

  /// Transform MonthlyUsageEntryDto to DailyReading (for year view chart)
  DailyReading _monthlyDtoToDailyReading(
    MonthlyUsageEntryDto dto,
    String meterId,
  ) {
    final monthDate = DateTime(dto.year, dto.month, 1);
    return DailyReading(
      meter: meterId,
      readDate: '${monthDate.toIso8601String().split('T')[0]} 00:00:00.000',
      kWhUsed: dto.monthlyUsageKwh.toStringAsFixed(3),
    );
  }

  /// Watch the appropriate provider and transform data based on filter type
  AsyncValue<
    ({
      List<DailyReading> dailyData,
      List<HourlyData> hourlyData,
      dynamic stats,
      String dateLabel,
      AmiDetail? selectedDetail,
    })
  >
  _watchDataProvider(int meterId) {
    final meterIdStr = meterId.toString();

    if (_filterType == FilterType.day) {
      final intervalsAsync = ref.watch(
        amiDailyIntervalsProvider((meterId: meterId, targetDate: _dayDate)),
      );

      return intervalsAsync.when(
        data: (intervals) {
          // aggregateToHourly always returns all 24 hours; hours with no
          // interval data are automatically marked missing: true.
          final intervalData = intervals.map(_dtoToIntervalReading).toList();
          final hourlyData = aggregateToHourly(intervalData);

          final stats = calculateHourlyStats(hourlyData);
          final dateLabel = _formatDateLong(_dayDate);

          HourlyDetail? selectedDetail;
          if (_selectedIndex != null && _selectedIndex! < hourlyData.length) {
            final hour = hourlyData[_selectedIndex!];
            if (!hour.missing) {
              selectedDetail = HourlyDetail(
                hour: hour.hour,
                time: hour.time,
                kWh: hour.kWh,
              );
            }
          }

          return AsyncValue.data((
            dailyData: [],
            hourlyData: hourlyData,
            stats: stats,
            dateLabel: dateLabel,
            selectedDetail: selectedDetail,
          ));
        },
        loading: () => const AsyncValue.loading(),
        error: AsyncValue.error,
      );
    }

    if (_filterType == FilterType.week) {
      final range = _getWeekRange();
      final dailyAsync = ref.watch(
        amiDailyRangeRowsProvider((
          meterId: meterId,
          startDate: range.start,
          endDate: range.end,
        )),
      );

      return dailyAsync.when(
        data: (result) {
          // Transform DTOs to DailyReading and normalize into a fixed 7-day week.
          final startDay = DateTime(range.start.year, range.start.month, range.start.day);
          final endDay = DateTime(range.end.year, range.end.month, range.end.day);
          final byDay = <String, DailyReading>{};
          for (final dto in result.days.map((row) => row.toDto())) {
            final reading = _dtoToDailyReading(dto, meterIdStr);
            final parsed =
                DateTime.tryParse(reading.readDate.trim().split(RegExp('[T ]')).first);
            if (parsed == null) continue;
            final entryDay = DateTime(parsed.year, parsed.month, parsed.day);
            if (entryDay.isBefore(startDay) || entryDay.isAfter(endDay)) continue;
            final key = '${entryDay.year}-${entryDay.month.toString().padLeft(2, '0')}-${entryDay.day.toString().padLeft(2, '0')}';
            byDay[key] = reading;
          }

          final dailyData = <DailyReading>[];
          for (int i = 0; i <= 6; i++) {
            final day = startDay.add(Duration(days: i));
            final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
            dailyData.add(
              byDay[key] ??
                  DailyReading(
                    meter: meterIdStr,
                    readDate: '${key} 00:00:00.000',
                    kWhUsed: '0',
                    missing: true,
                  ),
            );
          }
          final stats = _applyBucketSummary(
            calculateDailyStats(dailyData),
            result.summary,
          );
          final dateLabel = formatDateRange(range.start, range.end);

          DayDetail? selectedDetail;
          if (_selectedIndex != null && _selectedIndex! < dailyData.length) {
            final reading = dailyData[_selectedIndex!];
            final date =
                DateTime.tryParse(reading.readDate.split(' ')[0]) ??
                DateTime.now();
            selectedDetail = DayDetail(
              date: date,
              kWh: double.tryParse(reading.kWhUsed) ?? 0.0,
            );
          }

          return AsyncValue.data((
            dailyData: dailyData,
            hourlyData: [],
            stats: stats,
            dateLabel: dateLabel,
            selectedDetail: selectedDetail,
          ));
        },
        loading: () => const AsyncValue.loading(),
        error: AsyncValue.error,
      );
    }

    if (_filterType == FilterType.month) {
      final monthRange = getMonthRange(_monthDate);
      final dailyAsync = ref.watch(
        amiDailyRangeRowsProvider((
          meterId: meterId,
          startDate: monthRange.start,
          endDate: monthRange.end,
        )),
      );

      return dailyAsync.when(
        data: (result) {
          // Normalize to a full month, marking days with no reads as missing.
          final monthStart = DateTime(monthRange.start.year, monthRange.start.month, monthRange.start.day);
          final monthEnd = DateTime(monthRange.end.year, monthRange.end.month, monthRange.end.day);
          final byDayMap = <String, DailyReading>{};
          for (final dto in result.days.map((row) => row.toDto())) {
            final reading = _dtoToDailyReading(dto, meterIdStr);
            final parsed = DateTime.tryParse(reading.readDate.trim().split(RegExp(r'[\sT]')).first);
            if (parsed == null) continue;
            final entryDay = DateTime(parsed.year, parsed.month, parsed.day);
            if (entryDay.isBefore(monthStart) || entryDay.isAfter(monthEnd)) continue;
            final key = '${entryDay.year}-${entryDay.month.toString().padLeft(2, '0')}-${entryDay.day.toString().padLeft(2, '0')}';
            byDayMap[key] = reading;
          }
          final daysInRange = monthEnd.difference(monthStart).inDays + 1;
          final dailyData = <DailyReading>[];
          for (int i = 0; i < daysInRange; i++) {
            final day = monthStart.add(Duration(days: i));
            final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
            dailyData.add(
              byDayMap[key] ??
                  DailyReading(
                    meter: meterIdStr,
                    readDate: '${key} 00:00:00.000',
                    kWhUsed: '0',
                    missing: true,
                  ),
            );
          }

          final stats = _applyBucketSummary(
            calculateDailyStats(dailyData),
            result.summary,
          );
          final dateLabel = _formatMonthYear(_monthDate);

          DayDetail? selectedDetail;
          if (_selectedIndex != null && _selectedIndex! < dailyData.length) {
            final reading = dailyData[_selectedIndex!];
            if (!reading.missing) {
              final date =
                  DateTime.tryParse(reading.readDate.split(' ')[0]) ??
                  DateTime.now();
              selectedDetail = DayDetail(
                date: date,
                kWh: double.tryParse(reading.kWhUsed) ?? 0.0,
              );
            }
          }

          return AsyncValue.data((
            dailyData: dailyData,
            hourlyData: [],
            stats: stats,
            dateLabel: dateLabel,
            selectedDetail: selectedDetail,
          ));
        },
        loading: () => const AsyncValue.loading(),
        error: AsyncValue.error,
      );
    }

    // Year view - use MonthlyTotals endpoint
    final monthlyAsync = ref.watch(
      amiMonthlyTotalsResultProvider((meterId: meterId, year: _yearDate.year)),
    );

    return monthlyAsync.when(
      data: (result) {
        final monthlyRows = result.months;
        final monthlyUsages = monthlyRows.map((row) => row.toDto()).toList();
        if (monthlyUsages.isEmpty) {
          // Avoid reduce/firstWhere on empty; show empty chart state upstream.
          final stats = DailyStats(
            totalKWh: 0,
            estimatedCost: 0, // kept in model; intentionally not shown in UI
            avgKWh: 0,
            peakKWh: 0,
            peakDate: '-',
          );
          return AsyncValue.data((
            dailyData: <DailyReading>[],
            hourlyData: <HourlyData>[],
            stats: stats,
            dateLabel: _yearDate.year.toString(),
            selectedDetail: null,
          ));
        }

        // Transform monthly totals into a fixed 12-bar year chart.
        final byMonth = <int, MonthlyUsageEntryDto>{};
        for (final dto in monthlyUsages) {
          if (dto.month >= 1 && dto.month <= 12) {
            byMonth[dto.month] = dto;
          }
        }

        const monthNames = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];

        final lastSelectable = AmiUsageDateLimits.lastSelectableDate;
        final cutoffMonth = DateTime(lastSelectable.year, lastSelectable.month, 1);
        final monthlyData = <DailyReading>[];
        for (var month = 1; month <= 12; month++) {
          final dto = byMonth[month];
          final monthDate = DateTime(_yearDate.year, month, 1);
          if (dto == null) {
            monthlyData.add(
              DailyReading(
                meter: meterIdStr,
                readDate:
                    '${_yearDate.year}-${month.toString().padLeft(2, '0')}-01 00:00:00.000',
                kWhUsed: '0',
                missing: !monthDate.isBefore(cutoffMonth),
              ),
            );
          } else {
            monthlyData.add(_monthlyDtoToDailyReading(dto, meterIdStr));
          }
        }

        final monthsWithUsage = byMonth.values
            .where((dto) => dto.monthlyUsageKwh > 0)
            .toList();
        if (monthsWithUsage.isEmpty) {
          final stats = DailyStats(
            totalKWh: 0,
            estimatedCost: 0,
            avgKWh: 0,
            peakKWh: 0,
            peakDate: '-',
          );
          return AsyncValue.data((
            dailyData: monthlyData,
            hourlyData: <HourlyData>[],
            stats: stats,
            dateLabel: _yearDate.year.toString(),
            selectedDetail: null,
          ));
        }

        final totalKWh =
            monthsWithUsage.fold<double>(0, (sum, dto) => sum + dto.monthlyUsageKwh);
        final avgKWh = totalKWh / monthsWithUsage.length;
        final peak = monthsWithUsage.reduce(
          (a, b) => a.monthlyUsageKwh > b.monthlyUsageKwh ? a : b,
        );

        final stats = _applyBucketSummary(
          DailyStats(
            totalKWh: double.parse(totalKWh.toStringAsFixed(2)),
            estimatedCost: 0,
            avgKWh: double.parse(avgKWh.toStringAsFixed(2)),
            peakKWh: double.parse(peak.monthlyUsageKwh.toStringAsFixed(2)),
            peakDate: monthNames[peak.month - 1],
          ),
          result.summary,
          monthNames: monthNames,
        );

        MonthDetail? selectedDetail;
        if (_selectedIndex != null && _selectedIndex! < monthlyData.length) {
          final monthIndex = _selectedIndex!;
          final monthDto = byMonth[monthIndex + 1];
          if (monthDto != null && !monthlyData[monthIndex].missing) {
            selectedDetail = MonthDetail(
              month: monthNames[monthIndex],
              year: _yearDate.year,
              kWh: monthDto.monthlyUsageKwh,
            );
          }
        }

        return AsyncValue.data((
          dailyData: monthlyData,
          hourlyData: [],
          stats: stats,
          dateLabel: _yearDate.year.toString(),
          selectedDetail: selectedDetail,
        ));
      },
      loading: () => const AsyncValue.loading(),
      error: AsyncValue.error,
    );
  }

  String _formatDateLong(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    // Omit weekday — full "Tuesday, March 31, 2026" overflows on narrow screens.
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatMonthYear(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
