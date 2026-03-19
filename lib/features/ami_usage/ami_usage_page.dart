import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/feature_providers.dart';
import '../../core/utils/account_connection_utils.dart';
import '../../core/widgets/app_empty_state.dart';
import '../../data/models/ami_data.dart';
import '../../data/models/api_response_dtos.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'ami_usage_date_limits.dart';
import 'state/ami_usage_providers.dart' show amiDailyIntervalsProvider, amiDailyRangeProvider, amiMonthlyTotalsProvider, amiTouRangeDataProvider, DayTou;
import 'widgets/ami_day_chart.dart';
import 'widgets/ami_detail_cards.dart'
    show AmiDetail, AmiDetailCard, HourlyDetail, DayDetail, MonthDetail;
import 'widgets/ami_filter_controls.dart';
import 'widgets/ami_period_chart.dart';
import 'widgets/ami_summary_cards.dart';

enum FilterType { day, week, month, year }

enum ViewMode { kwh, cost }

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
  DateTime _monthDate = DateTime.now();
  DateTime _yearDate = DateTime.now();
  int? _selectedIndex;
  ViewMode _viewMode = ViewMode.kwh;

  /// User-selected week range (any span up to 7 days). Null = use getWeekRange(_weekDate).
  DateTime? _weekRangeStart;
  DateTime? _weekRangeEnd;

  void _handleFilterChange(FilterType filter) {
    setState(() {
      _filterType = filter;
      _selectedIndex = null;
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
    });
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

    // For week/month: fetch TOU breakdown for stacked chart and consumption section
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
    final touTotal = touRangeAsync?.whenOrNull(data: (v) => v.total);
    final touPerDay = touRangeAsync?.whenOrNull(data: (v) => v.perDay) ?? const <DayTou>[];
    // TOU is considered "loading" for the UI when we expect a range (week/month)
    // but the async value has not yet produced data for total consumption.
    final isTouLoading = (rangeStart != null && rangeEnd != null) && touTotal == null;

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

              // Data loading/error handling
              dataAsync.when(
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filter Controls
                    AmiFilterControls(
                      filterType: _filterType,
                      onFilterChange: _handleFilterChange,
                      currentDate: _currentFilterDate,
                      onDateChange: _handleDateChange,
                      dateLabel: data.dateLabel,
                      lastSelectableDate: AmiUsageDateLimits.lastSelectableDate,
                      weekRange: _filterType == FilterType.week
                          ? DateTimeRange(
                              start: _getWeekRange().start,
                              end: _getWeekRange().end,
                            )
                          : null,
                      onWeekRangeChange: _filterType == FilterType.week ? _handleWeekRangeChange : null,
                    ),
                    const SizedBox(height: AppTheme.spacing16),

                    // Summary Cards
                    AmiSummaryCards(
                      totalKWh: _getSummaryTotalKwh(
                        data.stats,
                        filterType: _filterType,
                        touPerDay: touPerDay,
                      ),
                      estimatedCost: _getSummaryEstimatedCost(
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
                    /*
                    // View Mode Toggle (kWh / Cost) - temporarily disabled
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildViewModeButton(
                                context,
                                ViewMode.kwh,
                                Icons.bolt_outlined,
                                'kWh',
                              ),
                              const SizedBox(width: 4),
                              _buildViewModeButton(
                                context,
                                ViewMode.cost,
                                Icons.attach_money_outlined,
                                'Cost',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    */
                    // Chart
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getChartTitle(),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                            Text(
                              'Tap a point for details',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        if (_filterType == FilterType.day)
                          AmiDayChart(
                            data: data.hourlyData,
                            selectedHour: _selectedIndex,
                            onSelectHour: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            viewMode: _viewMode,
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
                            viewMode: _viewMode,
                            touPerDay: touPerDay.isNotEmpty ? touPerDay : null,
                            showLoading: isTouLoading,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing20),

                    // Selected Detail Card
                    if (_selectedIndex != null && data.selectedDetail != null)
                      AmiDetailCard(
                        detail: data.selectedDetail!,
                        onClose: () {
                          setState(() {
                            _selectedIndex = null;
                          });
                        },
                      ),
                    // Time of Use Consumption (day: from hourlyData; week/month: from provider)
                    if (_filterType != FilterType.year) ...[
                      const SizedBox(height: AppTheme.spacing20),
                      _buildTimeOfUseSection(
                        context,
                        filterType: _filterType,
                        dayTou: _filterType == FilterType.day
                            ? computeTouFromHourly(data.hourlyData)
                            : null,
                        rangeTou: touTotal,
                      ),
                    ],
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => const Center(
                  child: AppEmptyState(
                    title: 'Error Loading Data',
                    message:
                        'Failed to load smart meter data. Please try again.',
                    icon: Icons.error_outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildViewModeButton(
    BuildContext context,
    ViewMode mode,
    IconData icon,
    String label,
  ) {
    final isSelected = _viewMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _viewMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (mode == ViewMode.kwh ? AppColors.primary : AppColors.chart2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeOfUseSection(
    BuildContext context, {
    required FilterType filterType,
    TouConsumption? dayTou,
    TouConsumption? rangeTou,
  }) {
    final tou = dayTou ?? rangeTou;
    final isMobile = MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint;
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
          if (tou == null)
            const Padding(
              padding: EdgeInsets.all(AppTheme.spacing12),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (isMobile)
            Column(
              children: [
                _buildTimeOfUsePeriod(
                  context,
                  'Off-Peak',
                  '12:00 AM - 10:00 AM',
                  AppColors.primary,
                  tou.offPeakKwh,
                ),
                const SizedBox(height: AppTheme.spacing12),
                _buildTimeOfUsePeriod(
                  context,
                  'Peak',
                  '11:00 AM - 8:00 PM',
                  AppColors.chart4,
                  tou.peakKwh,
                ),
                const SizedBox(height: AppTheme.spacing12),
                _buildTimeOfUsePeriod(
                  context,
                  'Mid-Peak',
                  '9:00 PM - 11:00 PM',
                  AppColors.chart3,
                  tou.midPeakKwh,
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _buildTimeOfUsePeriod(
                    context,
                    'Off-Peak',
                    '12:00 AM - 10:00 AM',
                    AppColors.primary,
                    tou.offPeakKwh,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _buildTimeOfUsePeriod(
                    context,
                    'Peak',
                    '11:00 AM - 8:00 PM',
                    AppColors.chart4,
                    tou.peakKwh,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _buildTimeOfUsePeriod(
                    context,
                    'Mid-Peak',
                    '9:00 PM - 11:00 PM',
                    AppColors.chart3,
                    tou.midPeakKwh,
                  ),
                ),
              ],
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
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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

  double _getSummaryEstimatedCost(
    dynamic stats, {
    required FilterType filterType,
    required List<DayTou> touPerDay,
  }) {
    if (filterType == FilterType.day) {
      return (stats as HourlyStats).estimatedCost;
    }
    final dailyStats = stats as DailyStats;
    if ((filterType == FilterType.week || filterType == FilterType.month) &&
        dailyStats.totalKWh == 0 &&
        touPerDay.isNotEmpty) {
      final totalKwh = _getSummaryTotalKwh(
        stats,
        filterType: filterType,
        touPerDay: touPerDay,
      );
      final cost = totalKwh * ratePerKwh;
      return double.parse(cost.toStringAsFixed(2));
    }
    return dailyStats.estimatedCost;
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
          // If the API returns no intervals, treat this as "no data" for day view.
          // This prevents charts/summary from showing misleading 0-values and avoids edge cases.
          if (intervals.isEmpty) {
            final dateLabel = _formatDateLong(_dayDate);
            final stats = calculateHourlyStats(const <HourlyData>[]);
            return AsyncValue.data((
              dailyData: <DailyReading>[],
              hourlyData: <HourlyData>[],
              stats: stats,
              dateLabel: dateLabel,
              selectedDetail: null,
            ));
          }

          // Transform DTOs to IntervalReading
          final intervalData = intervals.map(_dtoToIntervalReading).toList();
          final hourlyData = aggregateToHourly(intervalData);
          final stats = calculateHourlyStats(hourlyData);
          final dateLabel = _formatDateLong(_dayDate);

          HourlyDetail? selectedDetail;
          if (_selectedIndex != null && _selectedIndex! < hourlyData.length) {
            final hour = hourlyData[_selectedIndex!];
            selectedDetail = HourlyDetail(
              hour: hour.hour,
              time: hour.time,
              kWh: hour.kWh,
            );
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
        amiDailyRangeProvider((
          meterId: meterId,
          startDate: range.start,
          endDate: range.end,
        )),
      );

      return dailyAsync.when(
        data: (dailyUsages) {
          // Transform DTOs to DailyReading and keep only this week's range (7 days)
          final startDay = DateTime(range.start.year, range.start.month, range.start.day);
          final endDay = DateTime(range.end.year, range.end.month, range.end.day);
          final dailyData = dailyUsages
              .map((dto) => _dtoToDailyReading(dto, meterIdStr))
              .where((r) {
                final d = DateTime.tryParse(r.readDate.trim().split(RegExp('[T ]')).first);
                if (d == null) return false;
                final entryDay = DateTime(d.year, d.month, d.day);
                return !entryDay.isBefore(startDay) && !entryDay.isAfter(endDay);
              })
              .toList()
            ..sort((a, b) {
                final da = DateTime.tryParse(a.readDate.split(' ')[0]) ?? DateTime(0);
                final db = DateTime.tryParse(b.readDate.split(' ')[0]) ?? DateTime(0);
                return da.compareTo(db);
              });
          final stats = calculateDailyStats(dailyData);
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
        amiDailyRangeProvider((
          meterId: meterId,
          startDate: monthRange.start,
          endDate: monthRange.end,
        )),
      );

      return dailyAsync.when(
        data: (dailyUsages) {
          // Transform DTOs to DailyReading
          final dailyData = dailyUsages
              .map((dto) => _dtoToDailyReading(dto, meterIdStr))
              .toList();
          final stats = calculateDailyStats(dailyData);
          final dateLabel = _formatMonthYear(_monthDate);

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

    // Year view - use MonthlyTotals endpoint
    final monthlyAsync = ref.watch(
      amiMonthlyTotalsProvider((meterId: meterId, year: _yearDate.year)),
    );

    return monthlyAsync.when(
      data: (monthlyUsages) {
        if (monthlyUsages.isEmpty) {
          // Avoid reduce/firstWhere on empty; show empty chart state upstream.
          final stats = DailyStats(
            totalKWh: 0,
            estimatedCost: 0,
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

        // Transform MonthlyUsageEntryDto to DailyReading for chart
        final monthlyData = monthlyUsages
            .map((dto) => _monthlyDtoToDailyReading(dto, meterIdStr))
            .toList();

        // Calculate stats from monthly data
        final monthlyTotals = <int, double>{};
        for (final dto in monthlyUsages) {
          monthlyTotals[dto.month - 1] = dto.monthlyUsageKwh;
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

        final totalKWh = monthlyTotals.values.fold<double>(0, (a, b) => a + b);
        final avgKWh = monthlyTotals.isEmpty ? 0.0 : totalKWh / monthlyTotals.length;
        final peakMonth = monthlyTotals.entries.reduce(
          (max, entry) => entry.value > max.value ? entry : max,
        );

        final stats = DailyStats(
          totalKWh: double.parse(totalKWh.toStringAsFixed(2)),
          estimatedCost: double.parse(
            (totalKWh * ratePerKwh).toStringAsFixed(2),
          ),
          avgKWh: double.parse(avgKWh.toStringAsFixed(2)),
          peakKWh: double.parse(peakMonth.value.toStringAsFixed(2)),
          peakDate: monthNames[peakMonth.key],
        );

          MonthDetail? selectedDetail;
          if (_selectedIndex != null && _selectedIndex! < monthlyData.length) {
            final monthIndex = _selectedIndex!;
            final monthDto = monthlyUsages.firstWhere(
              (dto) => dto.month - 1 == monthIndex,
              orElse: () => monthlyUsages.first,
            );
            selectedDetail = MonthDetail(
              month: monthNames[monthIndex],
              year: _yearDate.year,
              kWh: monthDto.monthlyUsageKwh,
            );
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
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
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
    // Dart's DateTime.weekday is 1 (Monday) to 7 (Sunday),
    // so map directly with index = weekday - 1.
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
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
