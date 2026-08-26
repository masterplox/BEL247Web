import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../../../core/utils/formatting_utils.dart';

/// Base class for detail data
abstract class AmiDetail {
  const AmiDetail();
}

/// Hourly detail
class HourlyDetail extends AmiDetail {
  final int hour;
  final String time;
  final double kWh;

  const HourlyDetail({
    required this.hour,
    required this.time,
    required this.kWh,
  });
}

/// Day detail
class DayDetail extends AmiDetail {
  final DateTime date;
  final double kWh;

  const DayDetail({
    required this.date,
    required this.kWh,
  });
}

/// Month detail
class MonthDetail extends AmiDetail {
  final String month;
  final int year;
  final double kWh;

  const MonthDetail({
    required this.month,
    required this.year,
    required this.kWh,
  });
}

class AmiDetailCard extends StatelessWidget {
  const AmiDetailCard({
    super.key,
    required this.detail,
    required this.onClose,
  });

  final AmiDetail detail;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (detail is HourlyDetail) {
      return _HourlyDetailCard(
        detail: detail as HourlyDetail,
        onClose: onClose,
      );
    } else if (detail is DayDetail) {
      return _DayDetailCard(
        detail: detail as DayDetail,
        onClose: onClose,
      );
    } else if (detail is MonthDetail) {
      return _MonthDetailCard(
        detail: detail as MonthDetail,
        onClose: onClose,
      );
    }
    return const SizedBox.shrink();
  }
}

class _HourlyDetailCard extends StatelessWidget {
  const _HourlyDetailCard({
    required this.detail,
    required this.onClose,
  });

  final HourlyDetail detail;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hour ${detail.time}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FormattingUtils.formatKwhExact(detail.kWh),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

class _DayDetailCard extends StatelessWidget {
  const _DayDetailCard({
    required this.detail,
    required this.onClose,
  });

  final DayDetail detail;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final dateStr = _formatDate(detail.date);

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateStr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FormattingUtils.formatKwhExact(detail.kWh),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return '${weekdays[date.weekday % 7]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _MonthDetailCard extends StatelessWidget {
  const _MonthDetailCard({
    required this.detail,
    required this.onClose,
  });

  final MonthDetail detail;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${detail.month} ${detail.year}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FormattingUtils.formatKwhExact(detail.kWh),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}
