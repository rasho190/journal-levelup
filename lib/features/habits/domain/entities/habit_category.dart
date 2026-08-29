import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_category.freezed.dart';
part 'habit_category.g.dart';

const defaultCategoryNames = <String>[
  'Salud Mental',
  'Higiene',
  'Autocuidado',
  'Psicología',
  'Físico',
];

@freezed
class HabitCategory with _$HabitCategory {
  const factory HabitCategory({
    required String id,
    required String name,
    required int colorValue,
    required String iconKey,
    @Default(0) int position,
    @Default(false) bool isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _HabitCategory;

  factory HabitCategory.fromJson(Map<String, Object?> json) =>
      _$HabitCategoryFromJson(json);
}
