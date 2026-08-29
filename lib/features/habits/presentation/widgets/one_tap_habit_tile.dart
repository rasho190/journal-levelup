import 'package:flutter/material.dart';
import '../../domain/entities/habit.dart';

class OneTapHabitTile extends StatelessWidget {
  const OneTapHabitTile({super.key, required this.habit, required this.completed,
    required this.onTap});
  final Habit habit;
  final bool completed;
  final VoidCallback onTap;
  @override Widget build(BuildContext context) => ListTile(
    onTap: onTap, title: Text(habit.name),
    leading: Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked),
    trailing: completed ? const Text('Hecho') : const Text('Completar'),
  );
}
