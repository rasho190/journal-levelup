enum FocusSessionStatus { running, completed, cancelled }

class FocusSession {
  const FocusSession({required this.id, required this.habitId,
    required this.startedAtUtc, required this.endsAtUtc, required this.status});
  final String id;
  final String habitId;
  final DateTime startedAtUtc;
  final DateTime endsAtUtc;
  final FocusSessionStatus status;
  Duration remainingAt(DateTime nowUtc) {
    final remaining = endsAtUtc.difference(nowUtc);
    return remaining.isNegative ? Duration.zero : remaining;
  }
  bool isExpiredAt(DateTime nowUtc) => !endsAtUtc.isAfter(nowUtc);
}
