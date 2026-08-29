import 'package:flutter_test/flutter_test.dart';
import 'package:journal_levelup/features/habits/domain/entities/habit.dart';
import 'package:journal_levelup/features/habits/domain/entities/habit_completion.dart';
import 'package:journal_levelup/features/streaks/domain/services/streak_calculator.dart';

void main() {
  final now = DateTime.utc(2025);
  Habit habit({HabitFrequency frequency = HabitFrequency.daily}) => Habit(
    id: 'h', categoryId: 'c', name: 'Leer', frequency: frequency,
    scheduledWeekdays: frequency == HabitFrequency.daily ? {} : {DateTime.monday, DateTime.wednesday},
    createdAt: now, updatedAt: now);
  HabitCompletion done(String key) => HabitCompletion(id: key, habitId: 'h',
    localDateKey: key, completedCount: 1, createdAtUtc: now, updatedAtUtc: now);
  final calculator = StreakCalculator();
  final monday = DateTime(2025, 1, 6);
  List<DateTime> days(int count) => List.generate(count, (i) => monday.add(Duration(days: i)));

  test('first check-in starts a streak', () {
    final state = calculator.calculate(habit: habit(), days: days(1),
      completions: {'2025-01-06': done('2025-01-06')}, availableFreezes: 0, calculatedAtUtc: now);
    expect(state.currentStreak, 1);
  });
  test('two consecutive completions increment it', () {
    final state = calculator.calculate(habit: habit(), days: days(2), completions: {
      '2025-01-06': done('2025-01-06'), '2025-01-07': done('2025-01-07')},
      availableFreezes: 0, calculatedAtUtc: now);
    expect(state.currentStreak, 2);
  });
  test('unscheduled day between completions is ignored', () {
    final state = calculator.calculate(habit: habit(frequency: HabitFrequency.selectedWeekdays),
      days: days(3), completions: {'2025-01-06': done('2025-01-06'), '2025-01-08': done('2025-01-08')},
      availableFreezes: 0, calculatedAtUtc: now);
    expect(state.currentStreak, 2);
  });
  test('isolated absence consumes available freeze', () {
    final state = calculator.calculate(habit: habit(), days: days(3), completions: {
      '2025-01-06': done('2025-01-06'), '2025-01-08': done('2025-01-08')},
      availableFreezes: 1, calculatedAtUtc: now);
    expect(state.currentStreak, 3);
    expect(state.consumedFreezeDateKeys, contains('2025-01-07'));
  });
  test('absence without freeze breaks streak', () {
    final state = calculator.calculate(habit: habit(), days: days(2),
      completions: {'2025-01-06': done('2025-01-06')}, availableFreezes: 0, calculatedAtUtc: now);
    expect(state.currentStreak, 0);
  });
  test('two consecutive absences cannot both be protected', () {
    final state = calculator.calculate(habit: habit(), days: days(3),
      completions: {'2025-01-06': done('2025-01-06')}, availableFreezes: 2, calculatedAtUtc: now);
    expect(state.currentStreak, 0);
    expect(state.consumedFreezeDateKeys, {'2025-01-07'});
  });
}
