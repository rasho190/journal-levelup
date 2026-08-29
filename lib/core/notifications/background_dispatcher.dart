import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void backgroundDispatcher() {
  Workmanager().executeTask((_, __) async {
    // Maintenance only: schedule the next local notification, never rely on
    // Workmanager for exact delivery time.
    return true;
  });
}
