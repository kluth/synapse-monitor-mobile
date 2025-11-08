import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:synapse_monitor/core/notifications/notification_service.dart';
import 'package:synapse_monitor/domain/entities/alert.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

/// 🔴 RED PHASE - NotificationService Tests

void main() {
  late NotificationService notificationService;
  late MockFlutterLocalNotificationsPlugin mockPlugin;

  setUp(() {
    mockPlugin = MockFlutterLocalNotificationsPlugin();
    notificationService = NotificationService(plugin: mockPlugin);
  });

  group('NotificationService', () {
    group('Initialization', () {
      test('should initialize notification plugin', () async {
        // This test will FAIL

        when(() => mockPlugin.initialize(any()))
            .thenAnswer((_) async => true);

        final result = await notificationService.initialize();

        expect(result, true);
        verify(() => mockPlugin.initialize(any())).called(1);
      });

      test('should request permissions on iOS', () async {
        // This test will FAIL

        when(() => mockPlugin.resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>())
            .thenReturn(mockIosPlugin);
        when(() => mockIosPlugin.requestPermissions())
            .thenAnswer((_) async => true);

        await notificationService.requestPermissions();

        verify(() => mockIosPlugin.requestPermissions()).called(1);
      });

      test('should handle initialization failure gracefully', () async {
        // This test will FAIL

        when(() => mockPlugin.initialize(any()))
            .thenThrow(Exception('Init failed'));

        await expectLater(
          notificationService.initialize(),
          throwsA(isA<NotificationException>()),
        );
      });
    });

    group('Show Notification', () {
      test('should show basic notification', () async {
        // This test will FAIL

        when(() => mockPlugin.show(
              any(),
              any(),
              any(),
              any(),
            )).thenAnswer((_) async {});

        await notificationService.showNotification(
          title: 'Test',
          body: 'Test notification',
        );

        verify(() => mockPlugin.show(
              any(),
              'Test',
              'Test notification',
              any(),
            )).called(1);
      });

      test('should show alert notification with high priority', () async {
        // This test will FAIL

        final alert = Alert(
          id: 'alert-1',
          title: 'High CPU',
          message: 'CPU usage exceeded 90%',
          severity: AlertSeverity.critical,
          timestamp: DateTime.now(),
          acknowledged: false,
        );

        when(() => mockPlugin.show(
              any(),
              any(),
              any(),
              any(),
            )).thenAnswer((_) async {});

        await notificationService.showAlert(alert);

        verify(() => mockPlugin.show(
              any(),
              'High CPU',
              'CPU usage exceeded 90%',
              argThat(predicate<NotificationDetails>(
                (details) => details.android?.priority == Priority.high,
              )),
            )).called(1);
      });

      test('should use different notification channels for different types', () async {
        // This test will FAIL

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenAnswer((_) async {});

        await notificationService.showNotification(
          title: 'Test',
          body: 'Test',
          channel: NotificationChannel.alerts,
        );

        verify(() => mockPlugin.show(
              any(),
              any(),
              any(),
              argThat(predicate<NotificationDetails>(
                (details) => details.android?.channelId == 'alerts',
              )),
            )).called(1);
      });

      test('should include custom sound for critical alerts', () async {
        // This test will FAIL

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenAnswer((_) async {});

        await notificationService.showNotification(
          title: 'Critical Alert',
          body: 'System failure',
          playSound: true,
          sound: 'critical_alert.mp3',
        );

        verify(() => mockPlugin.show(
              any(),
              any(),
              any(),
              argThat(predicate<NotificationDetails>(
                (details) => details.android?.sound != null,
              )),
            )).called(1);
      });
    });

    group('Scheduled Notifications', () {
      test('should schedule notification for specific time', () async {
        // This test will FAIL

        final scheduledTime = DateTime.now().add(const Duration(hours: 1));

        when(() => mockPlugin.zonedSchedule(
              any(),
              any(),
              any(),
              any(),
              any(),
              androidAllowWhileIdle: any(named: 'androidAllowWhileIdle'),
              uiLocalNotificationDateInterpretation:
                  any(named: 'uiLocalNotificationDateInterpretation'),
            )).thenAnswer((_) async {});

        await notificationService.scheduleNotification(
          title: 'Scheduled',
          body: 'This is scheduled',
          scheduledTime: scheduledTime,
        );

        verify(() => mockPlugin.zonedSchedule(
              any(),
              'Scheduled',
              'This is scheduled',
              any(),
              any(),
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation: any(
                named: 'uiLocalNotificationDateInterpretation',
              ),
            )).called(1);
      });

      test('should schedule repeating notification', () async {
        // This test will FAIL

        when(() => mockPlugin.periodicallyShow(
              any(),
              any(),
              any(),
              any(),
              any(),
            )).thenAnswer((_) async {});

        await notificationService.scheduleRepeatingNotification(
          title: 'Repeating',
          body: 'Daily reminder',
          repeatInterval: RepeatInterval.daily,
        );

        verify(() => mockPlugin.periodicallyShow(
              any(),
              'Repeating',
              'Daily reminder',
              RepeatInterval.daily,
              any(),
            )).called(1);
      });

      test('should cancel scheduled notification', () async {
        // This test will FAIL

        when(() => mockPlugin.cancel(any())).thenAnswer((_) async {});

        await notificationService.cancelNotification(123);

        verify(() => mockPlugin.cancel(123)).called(1);
      });

      test('should cancel all notifications', () async {
        // This test will FAIL

        when(() => mockPlugin.cancelAll()).thenAnswer((_) async {});

        await notificationService.cancelAllNotifications();

        verify(() => mockPlugin.cancelAll()).called(1);
      });
    });

    group('Notification Actions', () {
      test('should handle notification tap', () async {
        // This test will FAIL

        String? tappedPayload;

        notificationService.onNotificationTap = (payload) {
          tappedPayload = payload;
        };

        await notificationService.handleNotificationTap('test-payload');

        expect(tappedPayload, 'test-payload');
      });

      test('should parse notification payload', () async {
        // This test will FAIL

        final payload = '{"type":"alert","id":"alert-123"}';

        final parsed = notificationService.parsePayload(payload);

        expect(parsed['type'], 'alert');
        expect(parsed['id'], 'alert-123');
      });

      test('should handle action buttons', () async {
        // This test will FAIL

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenAnswer((_) async {});

        await notificationService.showNotification(
          title: 'Alert',
          body: 'Critical issue',
          actions: [
            NotificationAction(id: 'view', label: 'View'),
            NotificationAction(id: 'dismiss', label: 'Dismiss'),
          ],
        );

        verify(() => mockPlugin.show(
              any(),
              any(),
              any(),
              argThat(predicate<NotificationDetails>(
                (details) => details.android?.actions?.length == 2,
              )),
            )).called(1);
      });
    });

    group('Notification Channels', () {
      test('should create notification channels on Android', () async {
        // This test will FAIL

        when(() => mockPlugin.resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>())
            .thenReturn(mockAndroidPlugin);
        when(() => mockAndroidPlugin.createNotificationChannel(any()))
            .thenAnswer((_) async {});

        await notificationService.createChannels();

        verify(() => mockAndroidPlugin.createNotificationChannel(any()))
            .called(greaterThan(0));
      });

      test('should have separate channels for different notification types', () async {
        // This test will FAIL

        final channels = notificationService.getNotificationChannels();

        expect(channels, contains(isA<NotificationChannel>()));
        expect(channels.length, greaterThanOrEqualTo(3));
      });
    });

    group('Notification Grouping', () {
      test('should group notifications by type', () async {
        // This test will FAIL

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenAnswer((_) async {});

        await notificationService.showNotification(
          title: 'Alert 1',
          body: 'First alert',
          groupKey: 'alerts',
        );

        await notificationService.showNotification(
          title: 'Alert 2',
          body: 'Second alert',
          groupKey: 'alerts',
        );

        verify(() => mockPlugin.show(
              any(),
              any(),
              any(),
              argThat(predicate<NotificationDetails>(
                (details) => details.android?.groupKey == 'alerts',
              )),
            )).called(2);
      });

      test('should create summary notification for groups', () async {
        // This test will FAIL

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenAnswer((_) async {});

        await notificationService.showGroupSummary(
          groupKey: 'alerts',
          title: '3 new alerts',
          body: 'Tap to view all',
        );

        verify(() => mockPlugin.show(
              any(),
              '3 new alerts',
              'Tap to view all',
              argThat(predicate<NotificationDetails>(
                (details) => details.android?.setAsGroupSummary == true,
              )),
            )).called(1);
      });
    });

    group('Badge Management', () {
      test('should update app badge count', () async {
        // This test will FAIL

        when(() => mockPlugin.resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>())
            .thenReturn(mockIosPlugin);

        await notificationService.updateBadgeCount(5);

        expect(notificationService.badgeCount, 5);
      });

      test('should clear badge count', () async {
        // This test will FAIL

        await notificationService.clearBadgeCount();

        expect(notificationService.badgeCount, 0);
      });
    });

    group('Notification Preferences', () {
      test('should check if notifications are enabled', () async {
        // This test will FAIL

        when(() => mockPlugin.resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>())
            .thenReturn(mockAndroidPlugin);
        when(() => mockAndroidPlugin.areNotificationsEnabled())
            .thenAnswer((_) async => true);

        final enabled = await notificationService.areNotificationsEnabled();

        expect(enabled, true);
      });

      test('should respect do not disturb settings', () async {
        // This test will FAIL

        notificationService.setDoNotDisturb(true);

        await notificationService.showNotification(
          title: 'Test',
          body: 'Should not show',
        );

        verifyNever(() => mockPlugin.show(any(), any(), any(), any()));
      });
    });

    group('Error Handling', () {
      test('should handle notification failure gracefully', () async {
        // This test will FAIL

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenThrow(Exception('Failed to show'));

        await expectLater(
          notificationService.showNotification(
            title: 'Test',
            body: 'Test',
          ),
          throwsA(isA<NotificationException>()),
        );
      });

      test('should log errors', () async {
        // This test will FAIL

        final logger = MockLogger();
        notificationService.logger = logger;

        when(() => mockPlugin.show(any(), any(), any(), any()))
            .thenThrow(Exception('Failed'));

        try {
          await notificationService.showNotification(
            title: 'Test',
            body: 'Test',
          );
        } catch (_) {}

        verify(() => logger.error(any())).called(1);
      });
    });
  });
}
