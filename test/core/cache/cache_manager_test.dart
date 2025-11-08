import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapse_monitor/core/cache/cache_manager.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

/// 🔴 RED PHASE - CacheManager Tests

void main() {
  late CacheManager cacheManager;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    cacheManager = CacheManagerImpl(mockSharedPreferences);
  });

  const tKey = 'test_key';
  const tValue = 'test_value';

  group('getString', () {
    test('should return cached string value when key exists', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.getString(tKey))
          .thenReturn(tValue);

      // Act
      final result = cacheManager.getString(tKey);

      // Assert
      expect(result, tValue);
      verify(() => mockSharedPreferences.getString(tKey)).called(1);
    });

    test('should return null when key does not exist', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.getString(tKey))
          .thenReturn(null);

      // Act
      final result = cacheManager.getString(tKey);

      // Assert
      expect(result, null);
    });
  });

  group('setString', () {
    test('should save string value to cache', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.setString(tKey, tValue))
          .thenAnswer((_) async => true);

      // Act
      final result = await cacheManager.setString(tKey, tValue);

      // Assert
      expect(result, true);
      verify(() => mockSharedPreferences.setString(tKey, tValue)).called(1);
    });

    test('should return false when save fails', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.setString(tKey, tValue))
          .thenAnswer((_) async => false);

      // Act
      final result = await cacheManager.setString(tKey, tValue);

      // Assert
      expect(result, false);
    });
  });

  group('getInt', () {
    test('should return cached int value', () async {
      // This test will FAIL

      const tIntValue = 42;

      // Arrange
      when(() => mockSharedPreferences.getInt(tKey))
          .thenReturn(tIntValue);

      // Act
      final result = cacheManager.getInt(tKey);

      // Assert
      expect(result, tIntValue);
    });
  });

  group('setInt', () {
    test('should save int value to cache', () async {
      // This test will FAIL

      const tIntValue = 42;

      // Arrange
      when(() => mockSharedPreferences.setInt(tKey, tIntValue))
          .thenAnswer((_) async => true);

      // Act
      final result = await cacheManager.setInt(tKey, tIntValue);

      // Assert
      expect(result, true);
      verify(() => mockSharedPreferences.setInt(tKey, tIntValue)).called(1);
    });
  });

  group('getBool', () {
    test('should return cached bool value', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.getBool(tKey))
          .thenReturn(true);

      // Act
      final result = cacheManager.getBool(tKey);

      // Assert
      expect(result, true);
    });

    test('should return default value when key not found', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.getBool(tKey))
          .thenReturn(null);

      // Act
      final result = cacheManager.getBool(tKey, defaultValue: false);

      // Assert
      expect(result, false);
    });
  });

  group('setBool', () {
    test('should save bool value to cache', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.setBool(tKey, true))
          .thenAnswer((_) async => true);

      // Act
      final result = await cacheManager.setBool(tKey, true);

      // Assert
      expect(result, true);
    });
  });

  group('remove', () {
    test('should remove key from cache', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.remove(tKey))
          .thenAnswer((_) async => true);

      // Act
      final result = await cacheManager.remove(tKey);

      // Assert
      expect(result, true);
      verify(() => mockSharedPreferences.remove(tKey)).called(1);
    });
  });

  group('clear', () {
    test('should clear all cache data', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.clear())
          .thenAnswer((_) async => true);

      // Act
      final result = await cacheManager.clear();

      // Assert
      expect(result, true);
      verify(() => mockSharedPreferences.clear()).called(1);
    });
  });

  group('containsKey', () {
    test('should return true when key exists', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.containsKey(tKey))
          .thenReturn(true);

      // Act
      final result = cacheManager.containsKey(tKey);

      // Assert
      expect(result, true);
    });

    test('should return false when key does not exist', () async {
      // This test will FAIL

      // Arrange
      when(() => mockSharedPreferences.containsKey(tKey))
          .thenReturn(false);

      // Act
      final result = cacheManager.containsKey(tKey);

      // Assert
      expect(result, false);
    });
  });

  group('JSON Cache', () {
    test('should save and retrieve JSON data', () async {
      // This test will FAIL

      const tJsonData = '{"name": "test", "value": 123}';

      // Arrange
      when(() => mockSharedPreferences.setString(tKey, tJsonData))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.getString(tKey))
          .thenReturn(tJsonData);

      // Act
      await cacheManager.setString(tKey, tJsonData);
      final result = cacheManager.getString(tKey);

      // Assert
      expect(result, tJsonData);
    });
  });

  group('Cache Expiration', () {
    test('should track cache entry timestamp', () async {
      // This test will FAIL

      const tTimestampKey = '${tKey}_timestamp';
      final tTimestamp = DateTime.now().millisecondsSinceEpoch;

      // Arrange
      when(() => mockSharedPreferences.setInt(tTimestampKey, any()))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.getInt(tTimestampKey))
          .thenReturn(tTimestamp);

      // Act
      await cacheManager.setStringWithExpiry(tKey, tValue, const Duration(hours: 1));
      final timestamp = cacheManager.getCacheTimestamp(tKey);

      // Assert
      expect(timestamp, isNotNull);
    });

    test('should return null for expired cache entries', () async {
      // This test will FAIL

      const tTimestampKey = '${tKey}_timestamp';
      final tExpiredTimestamp = DateTime.now()
          .subtract(const Duration(hours: 2))
          .millisecondsSinceEpoch;

      // Arrange
      when(() => mockSharedPreferences.getString(tKey))
          .thenReturn(tValue);
      when(() => mockSharedPreferences.getInt(tTimestampKey))
          .thenReturn(tExpiredTimestamp);

      // Act
      final result = cacheManager.getStringIfNotExpired(
        tKey,
        maxAge: const Duration(hours: 1),
      );

      // Assert
      expect(result, null);
    });
  });
}
