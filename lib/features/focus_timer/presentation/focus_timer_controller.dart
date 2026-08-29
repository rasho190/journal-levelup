import 'dart:async';
import '../domain/focus_session.dart';

abstract interface class FocusSessionStore {
  Future<void> save(FocusSession session);
  Future<FocusSession?> restoreRunning();
}

class FocusTimerController {
  FocusTimerController(this.store, {DateTime Function()? clock})
      : _clock = clock ?? (() => DateTime.now().toUtc());
  final FocusSessionStore store;
  final DateTime Function() _clock;
  Timer? _ticker;
  FocusSession? session;
  Duration remaining = Duration.zero;
  final _changes = StreamController<Duration>.broadcast();
  Stream<Duration> get changes => _changes.stream;

  Future<void> restore() async {
    session = await store.restoreRunning();
    _refresh();
    if (remaining > Duration.zero) _startTicker();
  }
  Future<void> start(FocusSession value) async {
    session = value;
    await store.save(value); // endsAtUtc, rather than a volatile tick count.
    _refresh();
    _startTicker();
  }
  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _refresh());
  }
  void _refresh() {
    remaining = session?.remainingAt(_clock()) ?? Duration.zero;
    _changes.add(remaining);
    if (remaining == Duration.zero) _ticker?.cancel();
  }
  Future<void> dispose() async { _ticker?.cancel(); await _changes.close(); }
}
