import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../features/habits/data/tables/habit_categories_table.dart';
import '../../features/habits/data/tables/habits_table.dart';
import '../../features/habits/data/tables/habit_completions_table.dart';
import '../../features/habits/domain/entities/habit_category.dart';
import '../../features/streaks/data/tables/streak_freeze_usages_table.dart';
import 'migrations.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [HabitCategories, Habits, HabitCompletions, StreakFreezeUsages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);
  @override int get schemaVersion => 1;
  @override MigrationStrategy get migration => migrations(this);

  Future<void> seedDefaultCategories() async {
    final now = DateTime.now().toUtc();
    const uuid = Uuid();
    await batch((batch) {
      for (var i = 0; i < defaultCategoryNames.length; i++) {
        batch.insert(habitCategories, HabitCategoriesCompanion.insert(
          id: uuid.v5(Uuid.NAMESPACE_URL, 'journal-levelup/category/$i'),
          name: defaultCategoryNames[i], colorValue: 0xff6750a4,
          iconKey: 'category', position: Value(i), createdAt: now, updatedAt: now));
      }
    });
  }
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  final directory = await getApplicationDocumentsDirectory();
  return NativeDatabase.createInBackground(File(p.join(directory.path, 'journal-levelup.sqlite')));
});
