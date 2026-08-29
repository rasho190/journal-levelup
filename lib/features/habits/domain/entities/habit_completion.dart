import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_completion.freezed.dart';
part 'habit_completion.g.dart';

@freezed
class HabitCompletion with _$HabitCompletion {
  const HabitCompletion._();
  @Assert('completedCount >= 0', 'completedCount cannot be negative')
  const factory HabitCompletion({
    required String id,
    required String habitId,
    required String localDateKey,
    required int completedCount,
    required DateTime createdAtUtc,
    required DateTime updatedAtUtc,
  }) = _HabitCompletion;

  factory HabitCompletion.fromJson(Map<String, Object?> json) =>
      _$HabitCompletionFromJson(json);
  bool reachesTarget(int targetCount) => completedCount >= targetCount;
}
