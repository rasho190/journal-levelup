# Journal LevelUp

Base arquitectónica offline-first para una aplicación Flutter de hábitos, rachas,
heatmap y sesiones de enfoque. El código mantiene el dominio libre de Flutter,
Riverpod, Drift y plugins de plataforma.

## Desarrollo

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
```

Los archivos `*.freezed.dart`, `*.g.dart` y `app_database.g.dart` son generados y
no se versionan.
