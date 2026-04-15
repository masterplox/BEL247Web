import 'dart:async';

import '../../core/analytics/app_page_names.dart';
import '../../core/config/env.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../services/api_client.dart';

/// API EventType values.
abstract class DeviceEventType {
  static const String navigation = 'Navigation';
  static const String interaction = 'Interaction';
  static const String lifeCycle = 'LifeCycle';
}

/// API EventSubtype for Interaction events.
abstract class InteractionEventSubtype {
  static const String open = 'Open';
  static const String dialogOpen = 'DialogOpen';
}

/// Sends analytics-style device events to ApiEvent/V1/Event.
class DeviceEventsRepository {
  DeviceEventsRepository([ApiClient? apiClient]) : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<void> _post({
    required String pageEvent,
    required String eventType,
    required String eventSubtype,
    String eventDetails = '',
  }) async {
    if (EnvConfig.useMockApi) {
      Logger.debug(
        'DeviceEvents (mock skip): $eventType / $eventSubtype / $pageEvent',
        tag: 'DeviceEvents',
      );
      return;
    }
    try {
      await _apiClient.post<dynamic>(
        ApiEndpoints.deviceEvent,
        data: <String, dynamic>{
          // 'PageEvent': pageEvent,
          'PageEvent': 'Deprecated',
          'EventType': eventType,
          'EventSubtype': eventSubtype,
          'EventDetails': eventDetails,
        },
        authenticated: true,
      );
    } catch (e, st) {
      Logger.warning(
        'Device event failed (non-fatal): $e',
        tag: 'DeviceEvents',
      );
      Logger.debug('$st', tag: 'DeviceEvents');
    }
  }

  /// User landed on or navigated to a shell page (Navigation).
  void logNavigationForLocation(String matchedLocation) {
    final subtype = AppPageNames.navigationSubtypeForRoute(matchedLocation);
    unawaited(_post(
      pageEvent: subtype,
      eventType: DeviceEventType.navigation,
      eventSubtype: subtype,
      eventDetails: '',
    ));
  }

  /// In-app navigation intent, e.g. sidebar/bottom nav (Interaction + Open).
  void logInteractionOpen({
    required String destinationPageName,
    required String sourcePageName,
  }) {
    unawaited(_post(
      pageEvent: destinationPageName,
      eventType: DeviceEventType.interaction,
      eventSubtype: InteractionEventSubtype.open,
      eventDetails: '$destinationPageName - From - $sourcePageName',
    ));
  }

  /// Dialog opened (Interaction + DialogOpen).
  void logInteractionDialogOpen({
    required String currentPageName,
    required String dialogDetails,
  }) {
    unawaited(_post(
      pageEvent: currentPageName,
      eventType: DeviceEventType.interaction,
      eventSubtype: InteractionEventSubtype.dialogOpen,
      eventDetails: dialogDetails,
    ));
  }
}
