import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

enum TimeRange {
  hourly,
  daily7,
  monthly,
  custom,
}

class TimeRangeToggle extends ConsumerStatefulWidget {
  const TimeRangeToggle({
    super.key,
    this.onTimeRangeChanged,
  });

  final Function(TimeRange timeRange, DateTimeRange? customRange)? onTimeRangeChanged;

  @override
  ConsumerState<TimeRangeToggle> createState() => _TimeRangeToggleState();
}

class _TimeRangeToggleState extends ConsumerState<TimeRangeToggle> {
  TimeRange _selectedRange = TimeRange.daily7;
  DateTimeRange? _customRange;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _buildTimeRangeButtons(),
          const SizedBox(height: AppTheme.spacing12),
          if (_selectedRange == TimeRange.custom) _buildCustomRangePicker(),
        ],
      );

  Widget _buildTimeRangeButtons() => Wrap(
        spacing: AppTheme.spacing8,
        runSpacing: AppTheme.spacing8,
        children: TimeRange.values.map((range) {
          final isSelected = _selectedRange == range;
          return ElevatedButton(
            onPressed: () => _selectTimeRange(range),
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? AppColors.primary : AppColors.surface,
              foregroundColor: isSelected ? Colors.white : AppColors.textPrimary,
              elevation: isSelected ? 2 : 0,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
                vertical: AppTheme.spacing8,
              ),
            ),
            child: Text(_getTimeRangeLabel(range)),
          );
        }).toList(),
      );

  Widget _buildCustomRangePicker() => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Date Range',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    'Start Date',
                    _customRange?.start ?? DateTime.now().subtract(const Duration(days: 7)),
                    (date) => _updateCustomRange(start: date),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _buildDateField(
                    'End Date',
                    _customRange?.end ?? DateTime.now(),
                    (date) => _updateCustomRange(end: date),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _customRange != null ? _applyCustomRange : null,
                icon: const Icon(Icons.check),
                label: const Text('Apply Range'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildDateField(
    String label,
    DateTime initialDate,
    Function(DateTime) onDateChanged,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          InkWell(
            onTap: () => _selectDate(context, initialDate, onDateChanged),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(_formatDate(initialDate)),
                ],
              ),
            ),
          ),
        ],
      );

  String _getTimeRangeLabel(TimeRange range) {
    switch (range) {
      case TimeRange.hourly:
        return 'Hourly';
      case TimeRange.daily7:
        return '7 Days';
      case TimeRange.monthly:
        return 'Monthly';
      case TimeRange.custom:
        return 'Custom';
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  void _selectTimeRange(TimeRange range) {
    setState(() {
      _selectedRange = range;
    });
    
    DateTimeRange? rangeData;
    switch (range) {
      case TimeRange.hourly:
        rangeData = DateTimeRange(
          start: DateTime.now().subtract(const Duration(hours: 24)),
          end: DateTime.now(),
        );
        break;
      case TimeRange.daily7:
        rangeData = DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 7)),
          end: DateTime.now(),
        );
        break;
      case TimeRange.monthly:
        rangeData = DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 30)),
          end: DateTime.now(),
        );
        break;
      case TimeRange.custom:
        rangeData = _customRange;
        break;
    }
    
    widget.onTimeRangeChanged?.call(range, rangeData);
  }

  void _updateCustomRange({DateTime? start, DateTime? end}) {
    setState(() {
      _customRange = DateTimeRange(
        start: start ?? _customRange?.start ?? DateTime.now().subtract(const Duration(days: 7)),
        end: end ?? _customRange?.end ?? DateTime.now(),
      );
    });
  }

  void _applyCustomRange() {
    if (_customRange != null) {
      widget.onTimeRangeChanged?.call(TimeRange.custom, _customRange);
    }
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime initialDate,
    Function(DateTime) onDateChanged,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      onDateChanged(picked);
    }
  }
}
