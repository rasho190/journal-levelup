import 'package:flutter_test/flutter_test.dart';
import 'package:journal_levelup/core/date/date_key.dart';

void main() {
  test('local times around midnight have distinct civil keys', () {
    expect(dateKey(DateTime(2025, 1, 31, 23, 59)), '2025-01-31');
    expect(dateKey(DateTime(2025, 2, 1, 0, 1)), '2025-02-01');
  });
  test('civil addition crosses month and year', () {
    expect(dateKey(civilAddDays(DateTime(2024, 12, 31), 1)), '2025-01-01');
  });
}
