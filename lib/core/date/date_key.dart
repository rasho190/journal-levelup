final _dateKeyPattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

String dateKey(DateTime localDate) => '${localDate.year.toString().padLeft(4, '0')}-'
    '${localDate.month.toString().padLeft(2, '0')}-'
    '${localDate.day.toString().padLeft(2, '0')}';

DateTime parseDateKey(String value) {
  if (!_dateKeyPattern.hasMatch(value)) throw FormatException('Invalid date key', value);
  final parts = value.split('-').map(int.parse).toList();
  final result = DateTime(parts[0], parts[1], parts[2]);
  if (dateKey(result) != value) throw FormatException('Invalid civil date', value);
  return result;
}

DateTime civilAddDays(DateTime day, int days) =>
    DateTime(day.year, day.month, day.day + days);
