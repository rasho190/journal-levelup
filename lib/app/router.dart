import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
final appRouter = GoRouter(routes: [GoRoute(path: '/', builder: (_, __) => const Scaffold(
  body: SafeArea(child: Center(child: Text('Journal LevelUp'))),
))]);
