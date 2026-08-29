import '../../../habits/domain/entities/habit.dart';
import '../../../habits/domain/entities/habit_completion.dart';
import '../entities/streak_state.dart';

/// Pure chronological streak calculation. Unscheduled days neither increment nor
/// break a streak. At most one isolated scheduled miss may consume a freeze.
class StreakCalculator {
  const StreakCalculator();

  StreakState calculate({required Habit habit, required List<DateTime> days,
    required Map<String, HabitCompletion> completions,
    required int availableFreezes, Set<String> consumedFreezes = const {},
    required DateTime calculatedAtUtc}) {
    var current = 0;
    var longest = 0;
    var freezes = availableFreezes;
    var previousScheduledWasFrozen = false;
    String? protectedKey;
    String? completionKey;
    final consumed = {...consumedFreezes};

    for (final day in days) {
      if (!habit.isScheduledFor(day)) continue;
      final key = _key(day);
      final completed = completions[key]?.reachesTarget(habit.targetCount) ?? false;
      if (completed) {
        current++;
        completionKey = key;
        protectedKey = key;
        previousScheduledWasFrozen = false;
      } else if (current > 0 && freezes > 0 && !previousScheduledWasFrozen &&
          !consumed.contains(key)) {
        freezes--;
        consumed.add(key);
        current++;
        protectedKey = key;
        previousScheduledWasFrozen = true;
      } else {
        current = 0;
        previousScheduledWasFrozen = false;
      }
      if (current > longest) longest = current;
    }
    return StreakState(habitId: habit.id, currentStreak: current,
      longestStreak: longest, lastProtectedDateKey: protectedKey,
      lastCompletionDateKey: completionKey, availableFreezes: freezes,
      consumedFreezeDateKeys: consumed, calculatedAtUtc: calculatedAtUtc);
  }

  String _key(DateTime day) => '${day.year.toString().padLeft(4, '0')}-'
      '${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
}
