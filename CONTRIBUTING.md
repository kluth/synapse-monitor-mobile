# Contributing to Synapse Monitor

Thank you for your interest in contributing to Synapse Monitor! This document provides guidelines and best practices for contributing to this project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Test-Driven Development](#test-driven-development)
- [Pull Request Process](#pull-request-process)
- [Architecture Guidelines](#architecture-guidelines)

## Code of Conduct

This project adheres to a code of conduct that all contributors are expected to follow. Be respectful, inclusive, and professional in all interactions.

## Getting Started

### Prerequisites

- Flutter SDK 3.x.x or higher
- Dart SDK
- Git
- An IDE (VS Code, Android Studio, or IntelliJ IDEA recommended)

### Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/synapse-monitor-mobile.git
   cd synapse-monitor-mobile
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Set up environment:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

5. Run code generation:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

6. Run tests to verify setup:
   ```bash
   flutter test
   ```

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b bugfix/your-bug-fix
```

### 2. Planning Phase (MANDATORY)

Before writing any code:

1. Open a Planning Issue on GitHub
2. Describe the feature/change
3. Outline the proposed architecture
4. Discuss approach with maintainers
5. Get approval before proceeding

### 3. Test-Driven Development (MANDATORY)

**Write tests FIRST, then implementation:**

```bash
# 1. Write failing tests
flutter test test/unit/features/your_feature/

# 2. Implement minimal code to pass tests
# Edit lib/features/your_feature/

# 3. Run tests again
flutter test

# 4. Refactor while keeping tests green
```

### 4. Code Implementation

Follow Clean Architecture principles:

```
feature/
├── data/
│   ├── datasources/    # API calls, database queries
│   ├── models/         # Data models with JSON serialization
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business objects (pure Dart)
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Business logic
└── presentation/
    ├── providers/      # Riverpod state management
    ├── screens/        # Full screen widgets
    └── widgets/        # Reusable UI components
```

### 5. Run Quality Checks

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run all tests
flutter test

# Check test coverage
flutter test --coverage
```

## Coding Standards

### Effective Dart

This project strictly follows [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines.

### Linting

All code must pass the strict linting rules defined in `analysis_options.yaml`:

```bash
flutter analyze
```

**Zero warnings and errors are required.**

### Code Style

#### Naming Conventions

```dart
// Classes: PascalCase
class NeuronRepository {}

// Functions, variables: camelCase
void fetchNeurons() {}
final neuronCount = 42;

// Constants: camelCase
const maxRetries = 3;

// Private members: _leadingUnderscore
final _privateValue = 'secret';
```

#### Documentation

All public APIs must be documented:

```dart
/// Fetches all neurons from the Synapse backend.
///
/// Returns a [List<Neuron>] containing all active neurons.
/// Throws [ServerException] if the request fails.
///
/// Example:
/// ```dart
/// final neurons = await repository.getNeurons();
/// ```
Future<List<Neuron>> getNeurons();
```

#### File Organization

```dart
// 1. Imports (dart, flutter, package, relative)
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/exceptions.dart';
import '../entities/neuron.dart';

// 2. Class definition
class NeuronRepository {
  // 3. Constructor
  const NeuronRepository(this._dataSource);

  // 4. Fields
  final NeuronDataSource _dataSource;

  // 5. Public methods
  Future<List<Neuron>> getNeurons() async {
    // Implementation
  }

  // 6. Private methods
  Future<void> _handleError() async {
    // Implementation
  }
}
```

### Clean Architecture Rules

1. **Domain layer** must NOT depend on data or presentation layers
2. **Data layer** can depend on domain, but NOT presentation
3. **Presentation layer** can depend on domain, but NOT data layer directly
4. Use **dependency injection** for all dependencies
5. All **external dependencies** must be abstracted with interfaces

### State Management with Riverpod

```dart
// Use Riverpod providers for state management
@riverpod
class NeuronsNotifier extends _$NeuronsNotifier {
  @override
  Future<List<Neuron>> build() async {
    final useCase = ref.read(getNeuronsUseCaseProvider);
    final result = await useCase();
    return result.fold(
      (failure) => throw failure,
      (neurons) => neurons,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}
```

## Test-Driven Development

### TDD is MANDATORY

**No code will be merged without tests written FIRST.**

### Test Structure

```dart
void main() {
  group('NeuronRepository', () {
    late NeuronRepository repository;
    late MockNeuronDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockNeuronDataSource();
      repository = NeuronRepository(mockDataSource);
    });

    group('getNeurons', () {
      test('should return list of neurons when call is successful', () async {
        // Arrange
        final tNeurons = [Neuron(id: '1', name: 'Test')];
        when(() => mockDataSource.getNeurons())
            .thenAnswer((_) async => tNeurons);

        // Act
        final result = await repository.getNeurons();

        // Assert
        expect(result, equals(tNeurons));
        verify(() => mockDataSource.getNeurons()).called(1);
      });

      test('should throw ServerException when call fails', () async {
        // Arrange
        when(() => mockDataSource.getNeurons())
            .thenThrow(ServerException());

        // Act & Assert
        expect(
          () => repository.getNeurons(),
          throwsA(isA<ServerException>()),
        );
      });
    });
  });
}
```

### Test Coverage Requirements

- **Use Cases**: 100% coverage
- **Repositories**: 100% coverage
- **Providers**: 100% coverage
- **Widgets**: 90%+ coverage
- **Overall**: 85%+ minimum

### Test Types

1. **Unit Tests** (`test/unit/`)
   - Test business logic in isolation
   - Mock all dependencies
   - Fast execution

2. **Widget Tests** (`test/widget/`)
   - Test UI components
   - Verify rendering and interactions
   - Use test helpers

3. **Integration Tests** (`test/integration/`)
   - Test end-to-end flows
   - Mock backend responses
   - Test navigation and state

## Pull Request Process

### 1. Before Submitting

- [ ] All tests pass: `flutter test`
- [ ] Code is formatted: `dart format .`
- [ ] No linting errors: `flutter analyze`
- [ ] Test coverage ≥ 85%
- [ ] All features have TDD proof (tests written first)
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated

### 2. PR Title Format

```
[Type] Brief description

Types:
- feat: New feature
- fix: Bug fix
- refactor: Code refactoring
- test: Adding tests
- docs: Documentation changes
- chore: Maintenance tasks
```

Examples:
- `[feat] Add neuron detail screen with metrics visualization`
- `[fix] Resolve WebSocket reconnection issue`
- `[refactor] Extract common chart components`

### 3. PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New feature
- [ ] Bug fix
- [ ] Refactoring
- [ ] Documentation

## TDD Proof
- [ ] Tests written before implementation
- [ ] All tests pass
- [ ] Coverage meets requirements

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests added/updated
- [ ] UI tested on multiple screen sizes (if applicable)

## Screenshots (if applicable)
Add screenshots for UI changes

## Related Issues
Closes #issue_number
```

### 4. Review Process

- At least one approval required
- All CI checks must pass
- Code coverage must not decrease
- Maintainer will provide feedback
- Address all comments before merge

## Architecture Guidelines

### Dependency Rule

Dependencies should point inward:

```
Presentation ──→ Domain ←── Data
     ↓                         ↓
  Widgets              External Sources
```

### Use Case Pattern

```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetNeurons implements UseCase<List<Neuron>, NoParams> {
  const GetNeurons(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, List<Neuron>>> call(NoParams params) async {
    try {
      final neurons = await _repository.getNeurons();
      return Right(neurons);
    } on ServerException {
      return const Left(ServerFailure());
    } on NetworkException {
      return const Left(NetworkFailure());
    }
  }
}
```

### Repository Pattern

```dart
// Domain layer - interface
abstract class NeuronRepository {
  Future<List<Neuron>> getNeurons();
  Future<Neuron> getNeuronById(String id);
}

// Data layer - implementation
class NeuronRepositoryImpl implements NeuronRepository {
  const NeuronRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  final NeuronRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<List<Neuron>> getNeurons() async {
    if (await _networkInfo.isConnected) {
      return _remoteDataSource.getNeurons();
    } else {
      throw NetworkException();
    }
  }
}
```

## Questions?

If you have questions or need clarification:

1. Check existing documentation
2. Search existing issues
3. Open a discussion on GitHub
4. Ask in pull request comments

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Synapse Monitor!
