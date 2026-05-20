import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../constants/bel_mobile_app_links.dart';

/// QR codes and store links for the BEL 24-7 mobile app (Android and Apple).
class BelMobileAppQrCard extends StatelessWidget {
  const BelMobileAppQrCard({super.key});

  static const double _sideBySideMinWidth = 560;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          side: const BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apply for services on the BEL 24-7 app',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                'Scan the QR code for your device or open the app store to download BEL 24-7 and apply for new services.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final sideBySide = constraints.maxWidth >= _sideBySideMinWidth;
                  final qrSize = sideBySide ? 140.0 : 128.0;

                  final android = _StoreDownloadSection(
                    platformLabel: 'Android',
                    storeButtonLabel: 'Google Play',
                    storeUrl: BelMobileAppLinks.googlePlayUrl,
                    icon: Icons.android,
                    qrSize: qrSize,
                  );
                  final apple = _StoreDownloadSection(
                    platformLabel: 'iPhone & iPad',
                    storeButtonLabel: 'App Store',
                    storeUrl: BelMobileAppLinks.appleAppStoreUrl,
                    icon: Icons.apple,
                    qrSize: qrSize,
                  );

                  if (sideBySide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: AppColors.border),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                                right: AppTheme.spacing16),
                            child: android,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing16),
                        Expanded(child: apple),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      android,
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                        child: Divider(height: 1, color: AppColors.border),
                      ),
                      apple,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class _StoreDownloadSection extends StatelessWidget {
  const _StoreDownloadSection({
    required this.platformLabel,
    required this.storeButtonLabel,
    required this.storeUrl,
    required this.icon,
    required this.qrSize,
  });

  final String platformLabel;
  final String storeButtonLabel;
  final String storeUrl;
  final IconData icon;
  final double qrSize;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              platformLabel,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: QrImageView(
                  data: storeUrl,
                  version: QrVersions.auto,
                  size: qrSize,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openStoreUrl(storeUrl),
                icon: Icon(icon, size: 18),
                label: Text(storeButtonLabel),
              ),
            ),
          ],
        ),
      );
}

Future<void> _openStoreUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
