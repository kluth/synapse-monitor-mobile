import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Network connectivity checker.
///
/// Provides information about the current network connectivity status
/// and streams connectivity changes.
abstract class NetworkInfo {
  /// Check if device is currently connected to internet
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of [NetworkInfo] using connectivity_plus package.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({
    Connectivity? connectivity,
  }) : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(_hasConnection);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    // No connection if list is empty or only contains none
    if (results.isEmpty) {
      return false;
    }

    // Check if we have any actual connection (not just "none")
    return results.any(
      (result) => result != ConnectivityResult.none,
    );
  }
}
