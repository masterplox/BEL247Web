import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/app_support_repository.dart';
import '../../data/repositories/device_events_repository.dart';

final deviceEventsRepositoryProvider = Provider<DeviceEventsRepository>(
  (ref) => DeviceEventsRepository(),
);

final appSupportRepositoryProvider = Provider<AppSupportRepository>(
  (ref) => AppSupportRepository(),
);
