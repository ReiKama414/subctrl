import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> initialize() async {
    if (kIsWeb) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(const InitializationSettings(android: android, iOS: ios));
    _ready = true;
  }

  Future<void> requestPermission() async {
    if (kIsWeb || !_ready) return;
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> resync(List<ReminderView> reminders) async {
    if (kIsWeb || !_ready) return;
    await _plugin.cancelAll();
    for (final r in reminders.where((e) => e.enabled)) {
      await _schedule(r);
    }
  }

  Future<void> scheduleRenewalReminder(ReminderView r) => _schedule(r);
  Future<void> scheduleCancelDeadlineReminder(ReminderView r) => _schedule(r);
  Future<void> scheduleTrialEndingReminder(ReminderView r) => _schedule(r);
  Future<void> schedulePromoEndingReminder(ReminderView r) => _schedule(r);
  Future<void> schedulePriceChangeReminder(ReminderView r) => _schedule(r);

  Future<void> _schedule(ReminderView r) async {
    if (kIsWeb || !_ready) return;
    if (r.fireAt.isBefore(DateTime.now())) return;
    await _plugin.zonedSchedule(
      r.notificationId,
      'SUB//CTRL',
      r.kind.label,
      tz.TZDateTime.from(r.fireAt, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'subctrl',
          'Subscription alerts',
          channelDescription: 'Local reminders for renewals, trials, and deadlines',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}

int reminderNotificationId(String reminderId) => reminderId.hashCode.abs() % 2147483647;
