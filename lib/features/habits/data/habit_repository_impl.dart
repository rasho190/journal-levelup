import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../domain/entities/habit.dart' as domain;
import '../domain/entities/habit_completion.dart' as domain;
import '../domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl(this.database);
  final AppDatabase database;

  @override
  Stream<List<domain.Habit>> watchActiveHabitsFor(DateTime localDay) {
    final query = database.select(database.habits)
      ..where((row) => row.isActive.equals(true))
      ..orderBy([(row) => OrderingTerm.asc(row.position)]);
    return query.watch().map((rows) => rows.map(_habit).where((habit) => habit.isScheduledFor(localDay)).toList());
  }

  @override
  Stream<Map<String, domain.HabitCompletion>> watchCompletionsFor(String key) =>
      (database.select(database.habitCompletions)..where((row) => row.localDateKey.equals(key)))
        .watch().map((rows) => {for (final row in rows) row.habitId: _completion(row)});

  @override
  Future<void> saveHabit(domain.Habit habit) => database.into(database.habits).insertOnConflictUpdate(
    HabitsCompanion.insert(id: habit.id, categoryId: habit.categoryId, name: habit.name,
      description: Value(habit.description), frequency: habit.frequency.name,
      scheduledWeekdays: habit.scheduledWeekdays.toList()..sort(),
      reminderMinuteOfDay: Value(habit.reminderMinuteOfDay), targetCount: habit.targetCount,
      position: Value(habit.position), isActive: Value(habit.isActive), createdAt: habit.createdAt,
      updatedAt: habit.updatedAt, archivedAt: Value(habit.archivedAt)));

  @override
  Future<void> archiveHabit(String id, DateTime at) =>
      (database.update(database.habits)..where((row) => row.id.equals(id))).write(
        HabitsCompanion(isActive: const Value(false), archivedAt: Value(at), updatedAt: Value(at)));

  @override
  Future<domain.HabitCompletion> toggleCompletion({required domain.Habit habit,
    required String localDateKey, required DateTime nowUtc}) async {
    // Setting the target (instead of read-then-increment) makes duplicate rapid
    // completion commands idempotent and the unique key makes them race-safe.
    final id = const Uuid().v4();
    await database.customStatement('''
      INSERT INTO habit_completions
        (id, habit_id, local_date_key, completed_count, created_at_utc, updated_at_utc)
      VALUES (?, ?, ?, ?, ?, ?)
      ON CONFLICT(habit_id, local_date_key) DO UPDATE SET
        completed_count = excluded.completed_count,
        updated_at_utc = excluded.updated_at_utc
    ''', [id, habit.id, localDateKey, habit.targetCount,
      nowUtc.millisecondsSinceEpoch ~/ 1000, nowUtc.millisecondsSinceEpoch ~/ 1000]);
    final row = await (database.select(database.habitCompletions)
      ..where((row) => row.habitId.equals(habit.id) & row.localDateKey.equals(localDateKey))).getSingle();
    return _completion(row);
  }

  domain.Habit _habit(Habit row) => domain.Habit(id: row.id, categoryId: row.categoryId,
    name: row.name, description: row.description,
    frequency: domain.HabitFrequency.values.byName(row.frequency),
    scheduledWeekdays: row.scheduledWeekdays.toSet(), reminderMinuteOfDay: row.reminderMinuteOfDay,
    targetCount: row.targetCount, position: row.position, isActive: row.isActive,
    createdAt: row.createdAt, updatedAt: row.updatedAt, archivedAt: row.archivedAt);
  domain.HabitCompletion _completion(HabitCompletion row) => domain.HabitCompletion(
    id: row.id, habitId: row.habitId, localDateKey: row.localDateKey,
    completedCount: row.completedCount, createdAtUtc: row.createdAtUtc, updatedAtUtc: row.updatedAtUtc);
}
