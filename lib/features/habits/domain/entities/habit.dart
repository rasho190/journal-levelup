import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

enum HabitFrequency { daily, selectedWeekdays }

@freezed
class Habit with _$Habit {
  const Habit._();

  @Assert('targetCount > 0', 'targetCount must be greater than zero')
  @Assert(
    'scheduledWeekdays.every((day) => day >= 1 && day <= 7)',
    'scheduledWeekdays must contain only ISO weekdays 1 through 7',
  )
  const factory Habit({
    required String id,
    required String categoryId,
    required String name,
    String? description,
    required HabitFrequency frequency,
    @Default(<int>{}) Set<int> scheduledWeekdays,
    int? reminderMinuteOfDay,
    @Default(1) int targetCount,
    @Default(0) int position,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? archivedAt,
  }) = _Habit;

  factory Habit.fromJson(Map<String, Object?> json) => _$HabitFromJson(json);

  bool isScheduledFor(DateTime localDay) => frequency == HabitFrequency.daily ||
      scheduledWeekdays.contains(localDay.weekday);
}
