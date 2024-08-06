import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<bool> isNotificationAllowed() async {
    final bool? isAllowed = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();

    return isAllowed ?? false;
  }

  /// Request permission to send notifications.
  static Future<void> requestPermissionToSendNotifications() async {
    // Check current permission status
    final PermissionStatus permissionStatus = await Permission.notification.status;

    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      // Request permission
      final PermissionStatus newStatus = await Permission.notification.request();

      if (newStatus.isDenied) {
        // Handle denied scenario
        // Open app settings to enable notifications manually
        await openNotificationSettings();
      } else if (newStatus.isGranted) {
        // Permission granted
        // You can proceed with showing notifications
      }
    } else if (permissionStatus.isGranted) {
      // Permission already granted
      // You can proceed with showing notifications
    }
  }

  static Future<void> openNotificationSettings() async {
    await openAppSettings();
  }

  static final onClickNotification = BehaviorSubject<String>();

  /// On Tap On Any Notification
  static void onNotificationTap(NotificationResponse notificationResponse,) {
    onClickNotification.add(notificationResponse.payload!);
  }

  /// Initialize the notification
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {});
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );

    /// Initialize timezones for scheduling notifications
    tz.initializeTimeZones();
  }

  /// Show Notification
  static Future showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon', // Change icon here
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// To Show Periodic Notification at regular interval
  static Future showPeriodicNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel 2',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon', // Change icon here
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(
        '',
        contentTitle: '<b>$title</b>',
        htmlFormatContentTitle: true,
        summaryText: '<i>$body</i>',
        htmlFormatSummaryText: true,
      ),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.weekly,
      notificationDetails,
      payload: payload,
    );
  }

  /// To Schedule Notification
  static Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    var localTime = tz.local;
    _flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 2',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon', // Change icon here
          ticker: 'ticker',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  /// Close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Close all Notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
