# Synapse Monitor (Flutter App)

[](https://opensource.org/licenses/MIT)
[](https://flutter.dev)
[](https://dart.dev)

A mobile dashboard built with Flutter for monitoring and visualizing the health and functionalities of [Synapse-Framework](https://github.com/kluth/synapse)-based distributed systems.

## 📝 Overview

The [Synapse Framework](https://github.com/kluth/synapse) by kluth models distributed systems as biologically-inspired neural networks, where microservices act as "neurons" and connections as "synapses."

This **Synapse Monitor App** serves as a mobile command center, connecting to an existing Synapse backend to visualize its state, performance, and topology in real-time. It provides administrators and developers with a mission-critical overview of system health directly from their mobile devices.

## ✨ Features

  * **Real-time Dashboard:** A global overview of the entire neural network's health status.
  * **Neuron Visualization:** A detailed list and inspection view for all `NeuralNode`, `CorticalNeuron`, and `ReflexNeuron` instances.
      * Status (active, inactive)
      * Activation thresholds
      * Processed signal counts
  * **Synapse Inspection:** Graphical representation of the `Synaptic Connections` between neurons.
      * Connection Weight
      * Signal Type (Excitatory/Inhibitory)
      * Transmission Speed
  * **Glial Cell Metrics:** Monitoring of the core support infrastructure.
      * **Astrocyte (Cache):** Displays cache size, hit rate, and TTL statistics.
  * **System Health:** Visualizes error rates and neuroplasticity metrics (e.g., self-healing events).
  * **Push Notifications:** Configurable alerts for critical system events (e.g., neuron failure, high error rates).

## 🚀 Getting Started

### Prerequisites

  * Flutter SDK (Version 3.0.0 or higher)
  * Dart SDK (comes with Flutter)
  * A code editor (VS Code, Android Studio, or IntelliJ IDEA)
  * For detailed build requirements, see [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)

### Quick Start

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/kluth/synapse-monitor-mobile.git
    cd synapse-monitor-mobile
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    # On Chrome (easiest for testing)
    flutter run -d chrome

    # Or on connected device/emulator
    flutter run
    ```

### Full Build Instructions

For complete build, test, and deployment instructions, see **[BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)**

This includes:
- Platform-specific setup (Android, iOS, Web, Desktop)
- Code generation commands
- Testing strategies
- Troubleshooting guide

## 📊 Current Status

### ✅ Implemented (Phase 1-4)

**Phase 1: Core Infrastructure** (14 files, ~2,750 lines)
- ✅ Network layer (HTTP client with Dio + WebSocket)
- ✅ Theme system (Light/Dark modes with Material 3)
- ✅ Utilities (Logger, Formatters, Validators)
- ✅ Core widgets (Loading, Error, Empty states)
- ✅ Base architecture (UseCase pattern, DI container)

**Phase 2: Domain Layer - Entities** (18 files, ~1,900 lines)
- ✅ 15 domain entities with business logic
- ✅ 4 repository interfaces
- ✅ Complete entity models for Neurons, Synapses, Glial Cells, System Health

**Phase 3: Domain Layer - Use Cases** (19 files, ~475 lines)
- ✅ 19 use cases following Clean Architecture
- ✅ Neuron operations (7 use cases)
- ✅ Synapse operations (3 use cases)
- ✅ Glial cells operations (4 use cases)
- ✅ System health operations (5 use cases)

**Phase 4: Data Layer - Models** (39 files, ~3,550 lines) ✅
- ✅ 13 data models with Freezed + JSON serialization
- ✅ 8 comprehensive test files with TDD approach (RED → GREEN)
- ✅ 16 test fixtures with realistic data
- ✅ Entity conversion (toEntity/fromEntity) for Clean Architecture
- ✅ Nested model support (Lists, Maps, value objects)
- ✅ Models: NeuralNode, CorticalNeuron, ReflexNeuron, Synapse, NetworkGraph, AstrocyteStats, OligodendrocyteStats, EpendymalStats, MicrogliaMetrics, Alert, SystemHealth, ErrorLog, NeuroplasticityEvent, MetricDataPoint

### 🚧 In Progress

**Phase 4: Data Layer - Data Sources & Repositories**
- Data sources (REST + WebSocket)
- Repository implementations

**Phase 5: Presentation Layer**
- Riverpod providers
- Feature screens
- UI components

### 📈 Statistics

- **Total Files**: 90
- **Lines of Code**: ~8,675
- **Test Coverage**: TDD with comprehensive unit tests (RED → GREEN approach)
- **Architecture**: Clean Architecture with SOLID principles

## 📐 Architecture & Planning

This project strictly adheres to the principles of **Clean Code** and **Clean Architecture**. The application logic is segregated into well-defined layers (Data, Domain, Presentation) to ensure high testability and maintainability.

### Technology Stack

  * **State Management:** Riverpod (with code generation)
  * **Dependency Injection:** GetIt + Injectable
  * **Routing:** GoRouter (type-safe navigation)
  * **Network:** Dio (HTTP) + WebSocket Channel (real-time)
  * **Code Generation:** Freezed, json_serializable, riverpod_generator
  * **Testing:** mocktail, flutter_test, integration_test

### Architecture Layers

1. **Domain Layer** (✅ Complete)
   - Pure Dart business logic
   - Entities with business rules
   - Repository interfaces
   - Use cases (application-specific logic)

2. **Data Layer** (🚧 In Progress)
   - Models with JSON serialization
   - Remote data sources (API clients)
   - Repository implementations
   - Error handling

3. **Presentation Layer** (📋 Planned)
   - Riverpod providers (state management)
   - Screens and widgets
   - UI components
   - Navigation

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md)

For implementation roadmap, see [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md)

## 🧪 Testing (TDD Mandatory)

This project enforces **Test-Driven Development (TDD)** as a non-negotiable standard.

### TDD Workflow: 🔴 RED → 🟢 GREEN → 🔵 REFACTOR

1. **🔴 RED**: Write failing tests FIRST
2. **🟢 GREEN**: Write minimum code to pass tests
3. **🔵 REFACTOR**: Improve code while keeping tests green

### Test Coverage Requirements
- **Minimum coverage**: 85%
- **Unit Tests**: All business logic
- **Widget Tests**: All UI components
- **Integration Tests**: Critical user flows

### Quick Commands
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Using Makefile
make test           # Run all tests
make test-watch     # Watch mode
make coverage       # Generate coverage report
```

## 🤖 CI/CD & Automation

### GitHub Workflows (Industry Best Practices)

This project uses **production-grade CI/CD workflows** following Flutter and GitHub Actions best practices:

#### Key Features:
- ✅ **Fast & Reliable**: `subosito/flutter-action@v2` (industry standard with 10K+ stars)
- ✅ **Smart Caching**: Setup time reduced from ~2min to ~10sec on cache hits
- ✅ **Intelligent Filtering**: Only runs on code changes, not documentation
- ✅ **Branch Protection Ready**: Single sentinel status check for all critical jobs
- ✅ **No False Failures**: Fixed git branch comparisons and concurrency handling
- ✅ **Optimized Performance**: Cached lcov, Flutter SDK, and dependencies

#### 1. **CI/CD Pipeline** (`.github/workflows/ci.yml`)
Runs on every push and PR:
- ✅ **Code Quality** (formatting, linting, metrics)
- ✅ **Code Generation** verification
- ✅ **Tests** (unit, widget, integration) with 85% coverage enforcement
- ✅ **Security** scanning (OSV scanner for vulnerabilities)
- ✅ **Multi-platform Builds** (Android, iOS, Web, Desktop)
- ✅ **Documentation** generation and GitHub Pages deployment
- ✅ **Sentinel Check**: "All Required Checks Complete" job for branch protection

**Performance Optimizations:**
- Flutter SDK caching (92% faster setup)
- lcov installation caching (83% faster coverage checks)
- Path filters to prevent unnecessary runs
- Smart concurrency (never cancels main/develop builds)

#### 2. **Release Pipeline** (`.github/workflows/release.yml`)
Automated releases on git tags:
- 📦 Build production APK/AAB
- 🍎 Build iOS IPA
- 🌐 Build and deploy Web
- 🚀 Create GitHub releases with changelogs

#### 3. **Dependency Updates** (`.github/workflows/dependency-update.yml`)
Weekly automated updates:
- 📦 Flutter/Dart dependency updates
- 🔒 Security vulnerability scanning with OSV scanner
- 🤖 Auto-create PRs for updates
- 📧 Notifications for Flutter version updates

#### 4. **Code Review Automation** (`.github/workflows/code-review.yml`)
On every PR:
- 📊 PR size analysis
- 🧪 TDD compliance checking
- 📚 Documentation coverage
- 🏷️ Auto-labeling by feature/layer
- 💡 Code improvement suggestions
- 📈 Complexity analysis

### Branch Protection Setup

**Recommended Configuration:**

1. Go to **Settings** → **Branches** → **Add rule**
2. Branch name pattern: `main`
3. Enable: ✅ **Require status checks to pass before merging**
4. Select status check: **"All Required Checks Complete"**
5. Enable: ✅ **Require branches to be up to date**
6. Enable: ✅ **Require linear history** (optional)
7. Save changes

**Why this works:**
- The sentinel job aggregates all critical checks (quality, tests, security)
- It only depends on jobs that always run (not platform builds)
- Single status check = simple branch protection configuration
- Prevents PRs from merging if any critical check fails

### Makefile Commands

Over 40 commands for development:

```bash
# Show all commands
make help

# Setup
make setup          # Initial setup
make install-tools  # Install dev tools

# Testing (TDD)
make test           # Run all tests
make test-watch     # Watch mode
make coverage       # Coverage report
make tdd-red        # Create test file
make tdd-green      # Run tests
make tdd-refactor   # Refactor with tests

# Code Quality
make analyze        # Static analysis
make format         # Format code
make lint           # All linters
make metrics        # Code metrics

# Building
make build-android  # Build APK
make build-ios      # Build iOS
make build-web      # Build web
make build-all      # Build all

# Quick Checks
make quick-check    # Fast quality check
make ready-for-pr   # Prepare for PR
make ci-local       # Simulate CI locally
```

## 🤝 Contributing

We welcome contributions! This project has **mandatory** standards:

### Before Contributing

1. Read [CONTRIBUTING.md](CONTRIBUTING.md) - Complete guidelines
2. Read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - Community standards
3. Check existing issues and PRs

### Contribution Standards

1. **🧪 TDD is Required**: Tests MUST be written before code
2. **🏗️ Clean Architecture**: Follow layer separation strictly
3. **🎨 Code Style**: Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
4. **📚 Documentation**: Document all public APIs
5. **✅ Quality**: Pass all CI checks

### Quick Start for Contributors

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/synapse-monitor-mobile.git
cd synapse-monitor-mobile

# Setup
make setup

# Create feature branch
git checkout -b feature/your-feature

# TDD Workflow
make tdd-red        # Write failing tests
make tdd-green      # Implement feature
make tdd-refactor   # Improve code

# Before PR
make ready-for-pr   # Run all checks

# Create PR using the template
```

### Pull Request Process

1. ✅ Use PR template
2. ✅ Include TDD evidence (tests written first)
3. ✅ Ensure 85%+ coverage
4. ✅ Pass all CI checks
5. ✅ Address review feedback
6. ✅ Get approval from maintainers

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.
