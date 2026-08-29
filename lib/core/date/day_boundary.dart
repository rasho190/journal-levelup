import 'date_key.dart';

/// Converts an already-localized wall-clock value to its civil-day key.
/// Time-zone conversion belongs at the platform/application boundary.
abstract final class DayBoundary {
  static String keyForLocal(DateTime localNow) => dateKey(localNow);
}
