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

### ✅ Implemented (Phase 1-3)

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

### 🚧 In Progress

**Phase 4: Data Layer**
- Data models with Freezed
- Data sources (REST + WebSocket)
- Repository implementations

**Phase 5: Presentation Layer**
- Riverpod providers
- Feature screens
- UI components

### 📈 Statistics

- **Total Files**: 51
- **Lines of Code**: ~5,125
- **Test Coverage**: TDD ready (tests coming in Phase 4)
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

  * **Unit Tests:** All business logic (Use Cases, State Notifiers) must be 100% covered by unit tests *before* the feature code is written.
  * **Widget Tests:** All UI components must be tested for correct rendering and interaction.
  * **Integration Tests:** End-to-end tests simulate the connection to the (mocked) Synapse backend and verify the data flow through the entire application.

Run all tests via:

```bash
flutter test
```

## 🤝 Contributing

We welcome contributions\! Please adhere to the following guidelines, which are **mandatory** for this repository:

1.  **Clean Code:** Strictly follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines and the project's defined linting rules.
2.  **TDD is Required:** No feature code will be merged without accompanying (and pre-written) tests.
3.  **Critical Planning:** For every new feature or significant change, open a "Planning Issue" to discuss the architecture and approach *before* implementation begins.
4.  **Pull Requests (PRs):**
      * PRs must include proof of TDD (i.e., comprehensive tests).
      * PRs must pass the CI pipeline (tests, linter).
      * PRs must be reviewed and approved by at least one other team member.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.
