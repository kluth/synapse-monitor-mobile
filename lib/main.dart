import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'injection_container.dart';

/// Main entry point for the Synapse Monitor application.
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Configure dependency injection
  await configureDependencies();

  // Run the app
  runApp(
    const ProviderScope(
      child: SynapseMonitorApp(),
    ),
  );
}

/// Root application widget.
class SynapseMonitorApp extends StatelessWidget {
  const SynapseMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synapse Monitor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const PlaceholderScreen(),
    );
  }
}

/// Placeholder screen until we implement the full UI.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synapse Monitor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.memory,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Synapse Monitor',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Monitoring Synapse Framework',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            const Text('Architecture layers implemented:'),
            const SizedBox(height: 16),
            _buildCheckItem('✅ Core Infrastructure'),
            _buildCheckItem('✅ Domain Entities'),
            _buildCheckItem('✅ Repository Interfaces'),
            _buildCheckItem('✅ Use Cases'),
            const SizedBox(height: 16),
            const Text('Next: Data Layer & Presentation'),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text),
    );
  }
}
