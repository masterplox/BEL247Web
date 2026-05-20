import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../ami_usage_date_limits.dart' show AmiUsageDateLimits;
import '../ami_usage_page.dart';

class AmiFilterControls extends StatelessWidget {
  const AmiFilterControls({
    super.key,
    required this.filterType,
    required this.onFilterChange,
    required this.currentDate,
    required this.onDateChange,
    required this.dateLabel,
    required this.lastSelectableDate,
    this.weekRange,
    this.onWeekRangeChange,
    this.allowedFilters,
  });

  final FilterType filterType;
  final Function(FilterType) onFilterChange;
  final DateTime currentDate;
  final Function(DateTime) onDateChange;
  final String dateLabel;
  /// Latest date the user can select (from [AmiUsageDateLimits.lastSelectableDate]).
  final DateTime lastSelectableDate;
  /// When filter is week, pass the current week's range so the range picker shows it.
  final DateTimeRange? weekRange;
  /// When filter is week, called with (start, end) when user picks a custom range (max 7 days).
  final void Function(DateTime start, DateTime end)? onWeekRangeChange;

  /// When set, only these filters are selectable (e.g. basic users: year only).
  final Set<FilterType>? allowedFilters;

  @override
  Widget build(BuildContext context) {
    final allowed = allowedFilters ?? FilterType.values.toSet();
    final filters = [
      {'value': FilterType.day, 'label': 'Day'},
      {'value': FilterType.week, 'label': 'Week'},
      {'value': FilterType.month, 'label': 'Month'},
      {'value': FilterType.year, 'label': 'Year'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter buttons - horizontally scrollable to avoid overflow on narrow screens
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...filters.map((filter) {
                final type = filter['value'] as FilterType;
                final isAllowed = allowed.contains(type);
                final isSelected = filterType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: AppTheme.spacing8),
                  child: FilterChip(
                    label: Text(filter['label'] as String),
                    selected: isSelected,
                    onSelected: isAllowed
                        ? (selected) {
                            if (selected) {
                              onFilterChange(type);
                            }
                          }
                        : null,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    checkmarkColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        // Date navigation
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _handlePrevious,
              tooltip: 'Previous',
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _showDatePicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing16,
                    vertical: AppTheme.spacing12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          dateLabel,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      const Icon(Icons.calendar_today, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _isNextDisabled() ? null : _handleNext,
              tooltip: 'Next',
            ),
          ],
        ),
      ],
    );
  }

  void _handlePrevious() {
    DateTime newDate;
    switch (filterType) {
      case FilterType.day:
        newDate = currentDate.subtract(const Duration(days: 1));
        break;
      case FilterType.week:
        newDate = currentDate.subtract(const Duration(days: 7));
        break;
      case FilterType.month:
        newDate = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
        break;
      case FilterType.year:
        newDate = DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
        break;
    }
    onDateChange(newDate);
  }

  void _handleNext() {
    DateTime newDate;
    switch (filterType) {
      case FilterType.day:
        newDate = currentDate.add(const Duration(days: 1));
        break;
      case FilterType.week:
        newDate = currentDate.add(const Duration(days: 7));
        break;
      case FilterType.month:
        newDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
        break;
      case FilterType.year:
        newDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
        break;
    }
    if (!_isAfterLastSelectable(newDate)) onDateChange(newDate);
  }

  bool _isNextDisabled() {
    DateTime newDate;
    switch (filterType) {
      case FilterType.day:
        newDate = currentDate.add(const Duration(days: 1));
        break;
      case FilterType.week:
        newDate = currentDate.add(const Duration(days: 7));
        break;
      case FilterType.month:
        newDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
        break;
      case FilterType.year:
        newDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
        break;
    }
    return _isAfterLastSelectable(newDate);
  }

  /// True if [date] is after [lastSelectableDate] (date-only comparison).
  bool _isAfterLastSelectable(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    final last = DateTime(lastSelectableDate.year, lastSelectableDate.month, lastSelectableDate.day);
    return d.isAfter(last);
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final firstDate = DateTime(2020);
    final lastDate = lastSelectableDate;

    switch (filterType) {
      case FilterType.day:
        final picked = await showDatePicker(
          context: context,
          initialDate: currentDate.isAfter(lastDate) ? lastDate : currentDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked != null) onDateChange(picked);
        break;

      case FilterType.week:
        final range = weekRange ?? DateTimeRange(start: currentDate, end: currentDate.add(const Duration(days: 6)));
        final picked = await showDateRangePicker(
          context: context,
          firstDate: firstDate,
          lastDate: lastDate,
          initialDateRange: range,
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(primary: AppColors.primary),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          final startDay = DateTime(picked.start.year, picked.start.month, picked.start.day);
          var endDay = DateTime(picked.end.year, picked.end.month, picked.end.day);
          final days = endDay.difference(startDay).inDays + 1;
          if (days > 7) endDay = startDay.add(const Duration(days: 6));
          if (onWeekRangeChange != null) {
            onWeekRangeChange!(startDay, endDay);
          }
          onDateChange(startDay);
        }
        break;

      case FilterType.month:
        await _showMonthYearPicker(context);
        break;

      case FilterType.year:
        await _showYearPicker(context);
        break;
    }
  }

  Future<void> _showYearPicker(BuildContext context) async {
    int selectedYear = currentDate.year;
    final maxYear = lastSelectableDate.year;
    final years = List.generate(maxYear - 2020 + 1, (i) => 2020 + i).toList()
      ..sort((a, b) => b.compareTo(a));

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select year'),
          content: SizedBox(
            width: 280,
            child: DropdownButtonFormField<int>(
              initialValue: selectedYear <= maxYear ? selectedYear : maxYear,
              decoration: const InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
              ),
              items: years
                  .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                  .toList(),
              onChanged: (v) => setState(() => selectedYear = v ?? selectedYear),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );

    if (result ?? false) {
      onDateChange(DateTime(selectedYear, 1, 1));
    }
  }

  Future<void> _showMonthYearPicker(BuildContext context) async {
    int selectedMonth = currentDate.month;
    int selectedYear = currentDate.year;
    final maxYear = lastSelectableDate.year;
    final maxMonth = lastSelectableDate.month;
    final years = List.generate(maxYear - 2020 + 1, (i) => 2020 + i).toList()
      ..sort((a, b) => b.compareTo(a));
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final allowedMonths = selectedYear < maxYear
              ? List.generate(12, (i) => i + 1)
              : List.generate(maxMonth, (i) => i + 1);
          final displayMonth = allowedMonths.contains(selectedMonth) ? selectedMonth : allowedMonths.last;
          final displayYear = selectedYear <= maxYear ? selectedYear : maxYear;
          return AlertDialog(
            title: const Text('Select month and year'),
            content: SizedBox(
              width: 280,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: displayMonth,
                    decoration: const InputDecoration(
                      labelText: 'Month',
                      border: OutlineInputBorder(),
                    ),
                    items: allowedMonths
                        .map((m) => DropdownMenuItem(value: m, child: Text(months[m - 1])))
                        .toList(),
                    onChanged: (v) => setState(() => selectedMonth = v ?? selectedMonth),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  DropdownButtonFormField<int>(
                    initialValue: displayYear,
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(),
                    ),
                    items: years
                        .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                        .toList(),
                    onChanged: (v) => setState(() => selectedYear = v ?? selectedYear),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    );

    if (result ?? false) {
      final month = selectedYear == maxYear
          ? (selectedMonth <= maxMonth ? selectedMonth : maxMonth)
          : selectedMonth;
      onDateChange(DateTime(selectedYear, month, 1));
    }
  }
}
