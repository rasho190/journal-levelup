abstract interface class NotificationScheduler {
  Future<void> scheduleDailyReminders();
  Future<void> scheduleNextRandomReminder();
  Future<void> cancelAll();
}
