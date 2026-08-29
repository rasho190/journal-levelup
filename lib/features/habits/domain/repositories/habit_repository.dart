import '../entities/habit.dart';
import '../entities/habit_completion.dart';

abstract interface class HabitRepository {
  Stream<List<Habit>> watchActiveHabitsFor(DateTime localDay);
  Stream<Map<String, HabitCompletion>> watchCompletionsFor(String localDateKey);
  Future<void> saveHabit(Habit habit);
  Future<void> archiveHabit(String habitId, DateTime archivedAtUtc);
  Future<HabitCompletion> toggleCompletion({required Habit habit,
    required String localDateKey, required DateTime nowUtc});
}
