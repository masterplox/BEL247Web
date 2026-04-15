import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'app_button.dart';

/// Catches errors thrown during the build of its [child] subtree and
/// displays a friendly fallback UI instead of a red error screen.
///
/// Use this to isolate sections of the UI that may fail independently —
/// e.g. a chart widget or a data-rich card — so the rest of the page
/// remains usable.
///
/// Usage:
/// ```dart
/// ErrorBoundary(
///   child: BillingHistoryChart(),
/// )
/// ```
///
/// To provide a custom fallback:
/// ```dart
/// ErrorBoundary(
///   fallback: const Text("Chart unavailable"),
///   child: BillingHistoryChart(),
/// )
/// ```
class ErrorBoundary extends StatefulWidget {
  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
    this.onError,
  });

  final Widget child;

  /// Widget shown when [child] throws. Defaults to [_DefaultFallback].
  final Widget? fallback;

  /// Optional callback invoked with the error and stack trace when caught.
  final void Function(Object error, StackTrace stackTrace)? onError;

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool _hasError = false;

  void _handleError(Object error, StackTrace stackTrace) {
    widget.onError?.call(error, stackTrace);
    if (mounted) setState(() => _hasError = true);
  }

  void _reset() {
    if (mounted) setState(() => _hasError = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback ?? _DefaultFallback(onRetry: _reset);
    }
    return _ErrorCatcherWidget(
      onError: _handleError,
      child: widget.child,
    );
  }
}

/// Installs a scoped [ErrorWidget.builder] override that routes build errors
/// to the parent [ErrorBoundary] instead of showing Flutter's red screen.
class _ErrorCatcherWidget extends StatelessWidget {
  const _ErrorCatcherWidget({required this.child, required this.onError});

  final Widget child;
  final void Function(Object error, StackTrace stackTrace) onError;

  @override
  Widget build(BuildContext context) {
    // Override ErrorWidget.builder locally so any build error in `child`
    // calls our handler rather than the default red-screen renderer.
    ErrorWidget.builder = (FlutterErrorDetails details) {
      onError(details.exception, details.stack ?? StackTrace.empty);
      return const SizedBox.shrink();
    };
    return child;
  }
}

class _DefaultFallback extends StatelessWidget {
  const _DefaultFallback({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.broken_image_outlined,
                size: 48,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppTheme.spacing12),
              Text(
                "This section didn't load.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing4),
              Text(
                "The rest of the page should still work fine.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing16),
              AppButton(
                onPressed: onRetry,
                text: "Try Again",
                buttonType: AppButtonType.outlined,
              ),
            ],
          ),
        ),
      );
}
