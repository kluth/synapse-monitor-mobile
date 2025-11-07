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

  * Flutter SDK (Version 3.x.x or higher)
  * Dart SDK
  * A running Synapse backend that exposes a monitoring API (e.g., WebSocket or REST).

### Installation & Execution

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
    cd YOUR_REPOSITORY
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Configure the application:**
    Create a `.env` file in the project root (based on `.env.example`) and add the endpoint for your Synapse monitoring API:

    ```ini
    # .env
    SYNAPSE_API_ENDPOINT=wss://your-synapse-backend.com/monitor
    ```

4.  **Run the app:**

    ```bash
    flutter run
    ```

## 📐 Architecture & Planning

This project strictly adheres to the principles of **Clean Code** and **Clean Architecture**. The application logic is segregated into well-defined layers (Data, Domain, Presentation) to ensure high testability and maintainability.

  * **State Management:** (Please select one, e.g., `Riverpod`, `Bloc`)
  * **Dependency Injection:** (e.g., `get_it`, `Riverpod`)
  * **Routing:** (e.g., `GoRouter`, `AutoRoute`)

Prior to the implementation of any new feature, a mandatory **planning and review cycle** is conducted. This process ensures all requirements are critically examined and best practices are upheld.

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
