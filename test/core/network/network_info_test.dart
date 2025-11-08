import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:synapse_monitor/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

/// 🔴 RED PHASE - NetworkInfo Tests
///
/// These tests WILL FAIL until the NetworkInfo implementation is complete

void main() {
  late NetworkInfo networkInfo;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockConnectionChecker);
  });

  group('isConnected', () {
    test('should forward call to InternetConnectionChecker.hasConnection', () async {
      // This test will FAIL

      // Arrange
      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, true);
      verify(() => mockConnectionChecker.hasConnection).called(1);
    });

    test('should return false when no internet connection', () async {
      // This test will FAIL

      // Arrange
      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, false);
    });
  });

  group('connectionStream', () {
    test('should provide stream of connection status changes', () async {
      // This test will FAIL

      // Arrange
      final connectionStream = Stream.fromIterable([
        InternetConnectionStatus.connected,
        InternetConnectionStatus.disconnected,
      ]);

      when(() => mockConnectionChecker.onStatusChange)
          .thenAnswer((_) => connectionStream);

      // Act
      final stream = networkInfo.connectionStream;

      // Assert
      await expectLater(
        stream,
        emitsInOrder([
          true,
          false,
        ]),
      );
    });

    test('should handle connection errors gracefully', () async {
      // This test will FAIL

      // Arrange
      when(() => mockConnectionChecker.onStatusChange)
          .thenAnswer((_) => Stream.error(Exception('Connection check failed')));

      // Act
      final stream = networkInfo.connectionStream;

      // Assert
      await expectLater(
        stream,
        emitsError(isA<Exception>()),
      );
    });
  });

  group('checkConnection', () {
    test('should perform one-time connection check', () async {
      // This test will FAIL

      // Arrange
      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      // Act
      final result = await networkInfo.checkConnection();

      // Assert
      expect(result, true);
      verify(() => mockConnectionChecker.hasConnection).called(1);
    });

    test('should handle connection timeout', () async {
      // This test will FAIL

      // Arrange
      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((_) => Future.delayed(
                const Duration(seconds: 20),
                () => true,
              ));

      // Act & Assert
      await expectLater(
        networkInfo.checkConnection(timeout: const Duration(seconds: 1)),
        throwsA(isA<TimeoutException>()),
      );
    });
  });
}
