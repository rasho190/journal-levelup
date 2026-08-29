import '../entities/habit.dart';
import '../repositories/habit_repository.dart';
class ObserveHabitsForDay {
  const ObserveHabitsForDay(this.repository);
  final HabitRepository repository;
  Stream<List<Habit>> call(DateTime localDay) => repository.watchActiveHabitsFor(localDay);
}
