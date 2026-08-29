import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_state.freezed.dart';
part 'streak_state.g.dart';

@freezed
class StreakState with _$StreakState {
  const StreakState._();
  const factory StreakState({
    required String habitId,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    String? lastProtectedDateKey,
    String? lastCompletionDateKey,
    @Default(0) int availableFreezes,
    @Default(<String>{}) Set<String> consumedFreezeDateKeys,
    required DateTime calculatedAtUtc,
  }) = _StreakState;
  factory StreakState.fromJson(Map<String, Object?> json) =>
      _$StreakStateFromJson(json);
  bool wasFreezeConsumedOn(String dateKey) =>
      consumedFreezeDateKeys.contains(dateKey);
}

class StreakFreezeUsage {
  const StreakFreezeUsage({required this.id, required this.habitId,
    required this.protectedLocalDateKey, required this.consumedAtUtc});
  final String id;
  final String habitId;
  final String protectedLocalDateKey;
  final DateTime consumedAtUtc;
}
