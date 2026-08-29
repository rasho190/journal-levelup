import 'package:flutter_test/flutter_test.dart';
import 'package:journal_levelup/features/focus_timer/domain/focus_session.dart';
import 'package:journal_levelup/features/focus_timer/presentation/focus_timer_controller.dart';

class MemoryStore implements FocusSessionStore {
  FocusSession? value;
  @override Future<FocusSession?> restoreRunning() async => value;
  @override Future<void> save(FocusSession session) async => value = session;
}
void main() {
  test('restore recalculates remaining time from persisted end instant', () async {
    final now = DateTime.utc(2025, 1, 1, 12);
    final store = MemoryStore()..value = FocusSession(id: 's', habitId: 'h',
      startedAtUtc: now, endsAtUtc: now.add(const Duration(minutes: 2)),
      status: FocusSessionStatus.running);
    final controller = FocusTimerController(store, clock: () => now.add(const Duration(seconds: 45)));
    await controller.restore();
    expect(controller.remaining, const Duration(seconds: 75));
    await controller.dispose();
  });
}
