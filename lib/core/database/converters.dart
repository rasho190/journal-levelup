import 'package:drift/drift.dart';

class WeekdaysConverter extends TypeConverter<Set<int>, String> {
  const WeekdaysConverter();
  @override Set<int> fromSql(String fromDb) => fromDb.isEmpty
      ? <int>{} : fromDb.split(',').map(int.parse).toSet();
  @override String toSql(Set<int> value) {
    if (value.any((day) => day < 1 || day > 7)) {
      throw ArgumentError.value(value, 'value', 'Only ISO weekdays 1 through 7 are valid');
    }
    final sorted = value.toList()..sort();
    return sorted.join(',');
  }
}
