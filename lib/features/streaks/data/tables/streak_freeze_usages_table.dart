import 'package:drift/drift.dart';
import '../../../habits/data/tables/habits_table.dart';

@TableIndex(name: 'freeze_habit_day_unique', columns: {#habitId, #protectedLocalDateKey}, unique: true)
class StreakFreezeUsages extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id)();
  TextColumn get protectedLocalDateKey => text()();
  DateTimeColumn get consumedAtUtc => dateTime()();
  @override Set<Column<Object>> get primaryKey => {id};
  @override List<Set<Column<Object>>> get uniqueKeys => [{habitId, protectedLocalDateKey}];
}
