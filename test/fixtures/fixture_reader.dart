import 'dart:io';

/// Utility to read fixture files for testing.
///
/// Fixtures are test data files stored in test/fixtures/ directory.
String fixture(String name) {
  final file = File('test/fixtures/$name');
  if (!file.existsSync()) {
    throw Exception('Fixture file not found: test/fixtures/$name');
  }
  return file.readAsStringSync();
}
