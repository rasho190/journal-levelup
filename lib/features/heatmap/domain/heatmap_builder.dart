import 'heatmap_day.dart';

List<HeatmapDay> buildMonth({required DateTime month,
  required Map<int, int> completedByDay, required Map<int, int> scheduledByDay}) {
  final count = DateTime(month.year, month.month + 1, 0).day;
  return [for (var day = 1; day <= count; day++) HeatmapDay(
    localDate: DateTime(month.year, month.month, day),
    completedHabits: completedByDay[day] ?? 0,
    scheduledHabits: scheduledByDay[day] ?? 0,
  )];
}
