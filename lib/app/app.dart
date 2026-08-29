import 'package:flutter/material.dart';
import 'router.dart';
import 'theme/app_theme.dart';
class JournalLevelUpApp extends StatelessWidget {
  const JournalLevelUpApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp.router(
    title: 'Journal LevelUp', theme: AppTheme.light, routerConfig: appRouter);
}
