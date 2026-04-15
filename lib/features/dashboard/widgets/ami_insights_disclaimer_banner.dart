import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Disclaimer about AMI-only detailed usage insights (dashboard and empty states).
class AmiInsightsDisclaimerBanner extends StatefulWidget {
  const AmiInsightsDisclaimerBanner({super.key});

  static const String learnMoreUrl = 'https://bit.ly/AMIbz';

  @override
  State<AmiInsightsDisclaimerBanner> createState() =>
      _AmiInsightsDisclaimerBannerState();
}

class _AmiInsightsDisclaimerBannerState
    extends State<AmiInsightsDisclaimerBanner> {
  late final TapGestureRecognizer _learnMoreTap;

  @override
  void initState() {
    super.initState();
    _learnMoreTap = TapGestureRecognizer()..onTap = _openLearnMore;
  }

  Future<void> _openLearnMore() async {
    final uri = Uri.parse(AmiInsightsDisclaimerBanner.learnMoreUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _learnMoreTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        );
    final linkStyle = baseStyle?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.primary,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.info),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: baseStyle,
                children: [
                  const TextSpan(
                    text:
                        'Detailed energy usage insights are available only for Customers with AMI meters. ',
                  ),
                  const TextSpan(
                    text:
                        'After your account is updated with an AMI meter, these features will become available unlocking deeper insights and new ways to understand and manage your energy use. ',
                  ),
                  TextSpan(
                    text: 'Learn More: ',
                    style: baseStyle?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'bit.ly/AMIbz',
                    style: linkStyle,
                    recognizer: _learnMoreTap,
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
