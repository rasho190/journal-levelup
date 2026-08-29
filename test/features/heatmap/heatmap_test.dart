import 'package:flutter_test/flutter_test.dart';
import 'package:journal_levelup/features/heatmap/domain/heatmap_builder.dart';

void main() {
  test('month includes days without records and crosses year correctly', () {
    final days = buildMonth(month: DateTime(2024, 12), completedByDay: {}, scheduledByDay: {});
    expect(days, hasLength(31));
    expect(days.first.intensityLevel, 0);
    expect(days.last.localDate, DateTime(2024, 12, 31));
  });
  test('partial completion has proportional intensity', () {
    final day = buildMonth(month: DateTime(2025, 2), completedByDay: {1: 1}, scheduledByDay: {1: 2}).first;
    expect(day.completionRatio, .5);
    expect(day.intensityLevel, 3);
  });
}
