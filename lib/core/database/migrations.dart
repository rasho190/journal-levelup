import 'package:drift/drift.dart';
import 'app_database.dart';

MigrationStrategy migrations(AppDatabase db) => MigrationStrategy(
  onCreate: (migrator) async {
    await migrator.createAll();
    await db.seedDefaultCategories();
  },
  onUpgrade: (migrator, from, to) async {
    // Future schema changes are explicit and version-gated here.
  },
  beforeOpen: (details) async => db.customStatement('PRAGMA foreign_keys = ON'),
);
