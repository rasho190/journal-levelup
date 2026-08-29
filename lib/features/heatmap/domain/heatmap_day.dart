class HeatmapDay {
  const HeatmapDay({required this.localDate, required this.completedHabits,
    required this.scheduledHabits});
  final DateTime localDate;
  final int completedHabits;
  final int scheduledHabits;
  double get completionRatio => scheduledHabits == 0
      ? 0 : (completedHabits / scheduledHabits).clamp(0.0, 1.0);
  int get intensityLevel {
    final ratio = completionRatio;
    if (ratio == 0) return 0;
    if (ratio < .25) return 1;
    if (ratio < .50) return 2;
    if (ratio < .75) return 3;
    return 4;
  }
}
