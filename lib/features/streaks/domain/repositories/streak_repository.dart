import '../entities/streak_state.dart';

abstract interface class StreakRepository {
  Future<StreakState> calculateForHabit({required String habitId,
    required DateTime throughLocalDay});
  Stream<StreakState> watchForHabit(String habitId);
  Future<void> grantFreezes({required String habitId, required int amount});
}
