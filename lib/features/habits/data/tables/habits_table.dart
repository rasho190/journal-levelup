import 'package:drift/drift.dart';
import 'habit_categories_table.dart';
import '../../../../core/database/converters.dart';

class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text().references(HabitCategories, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get frequency => text()();
  TextColumn get scheduledWeekdays => text().map(const WeekdaysConverter()).withDefault(const Constant(''))();
  IntColumn get reminderMinuteOfDay => integer().nullable()();
  IntColumn get targetCount => integer().check(targetCount.isBiggerThanValue(0))();
  IntColumn get position => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  @override Set<Column<Object>> get primaryKey => {id};
}
