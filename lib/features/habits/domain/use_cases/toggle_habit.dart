import '../entities/habit.dart';
import '../entities/habit_completion.dart';
import '../repositories/habit_repository.dart';

class ToggleHabit {
  const ToggleHabit(this.repository);
  final HabitRepository repository;
  Future<HabitCompletion> call({required Habit habit,
    required String localDateKey, required DateTime nowUtc}) =>
      repository.toggleCompletion(habit: habit, localDateKey: localDateKey, nowUtc: nowUtc);
}
