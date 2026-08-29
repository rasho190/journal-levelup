import 'package:drift/drift.dart';
import 'habits_table.dart';

@TableIndex(name: 'completion_habit_day_unique', columns: {#habitId, #localDateKey}, unique: true)
class HabitCompletions extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id)();
  TextColumn get localDateKey => text()();
  IntColumn get completedCount => integer().check(completedCount.isBiggerOrEqualValue(0))();
  DateTimeColumn get createdAtUtc => dateTime()();
  DateTimeColumn get updatedAtUtc => dateTime()();
  @override Set<Column<Object>> get primaryKey => {id};
  @override List<Set<Column<Object>>> get uniqueKeys => [{habitId, localDateKey}];
}
