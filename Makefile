.PHONY: help setup clean test build analyze format doctor coverage install-tools

# Default target
help:
	@echo "📱 Synapse Monitor - Development Commands"
	@echo ""
	@echo "Setup & Installation:"
	@echo "  make setup          - Initial project setup"
	@echo "  make install-tools  - Install development tools"
	@echo ""
	@echo "Testing (TDD):"
	@echo "  make test           - Run all tests"
	@echo "  make test-watch     - Run tests in watch mode"
	@echo "  make test-unit      - Run unit tests only"
	@echo "  make test-widget    - Run widget tests only"
	@echo "  make test-integration - Run integration tests"
	@echo "  make coverage       - Generate test coverage report"
	@echo ""
	@echo "Code Quality:"
	@echo "  make analyze        - Run static analysis"
	@echo "  make format         - Format code"
	@echo "  make format-check   - Check code formatting"
	@echo "  make lint           - Run all linters"
	@echo "  make metrics        - Check code metrics"
	@echo ""
	@echo "Code Generation:"
	@echo "  make generate       - Run code generation"
	@echo "  make generate-watch - Run code generation in watch mode"
	@echo "  make clean-generate - Clean and regenerate code"
	@echo ""
	@echo "Building:"
	@echo "  make build-android  - Build Android APK"
	@echo "  make build-ios      - Build iOS app"
	@echo "  make build-web      - Build web app"
	@echo "  make build-all      - Build all platforms"
	@echo ""
	@echo "Running:"
	@echo "  make run            - Run app on default device"
	@echo "  make run-dev        - Run in development mode"
	@echo "  make run-prod       - Run in production mode"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make doctor         - Run flutter doctor"
	@echo "  make upgrade        - Upgrade dependencies"
	@echo "  make outdated       - Check outdated dependencies"
	@echo ""
	@echo "Git & CI:"
	@echo "  make pre-commit     - Run pre-commit checks"
	@echo "  make pre-push       - Run pre-push checks"
	@echo "  make ci-local       - Simulate CI pipeline locally"

# ============================================================================
# Setup & Installation
# ============================================================================

setup: ## Initial project setup
	@echo "🔧 Setting up project..."
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs
	@echo "✅ Setup complete!"

install-tools: ## Install development tools
	@echo "📦 Installing development tools..."
	flutter pub global activate dart_code_metrics
	flutter pub global activate dependency_validator
	flutter pub global activate import_sorter
	flutter pub global activate pana
	@echo "✅ Tools installed!"

# ============================================================================
# Testing (TDD)
# ============================================================================

test: ## Run all tests
	@echo "🧪 Running all tests..."
	flutter test

test-watch: ## Run tests in watch mode
	@echo "👀 Running tests in watch mode..."
	flutter test --watch

test-unit: ## Run unit tests only
	@echo "🧪 Running unit tests..."
	flutter test test/unit

test-widget: ## Run widget tests only
	@echo "🧪 Running widget tests..."
	flutter test test/widget

test-integration: ## Run integration tests
	@echo "🧪 Running integration tests..."
	flutter test integration_test

coverage: ## Generate test coverage report
	@echo "📊 Generating coverage report..."
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	@echo "✅ Coverage report generated at coverage/html/index.html"
	@echo "Opening coverage report..."
	@if command -v xdg-open > /dev/null; then \
		xdg-open coverage/html/index.html; \
	elif command -v open > /dev/null; then \
		open coverage/html/index.html; \
	else \
		echo "Please open coverage/html/index.html manually"; \
	fi

# ============================================================================
# Code Quality
# ============================================================================

analyze: ## Run static analysis
	@echo "🔍 Running static analysis..."
	flutter analyze --fatal-infos --fatal-warnings

format: ## Format code
	@echo "🎨 Formatting code..."
	dart format .
	@echo "✅ Code formatted!"

format-check: ## Check code formatting
	@echo "🎨 Checking code formatting..."
	dart format --output=none --set-exit-if-changed .

lint: analyze format-check ## Run all linters
	@echo "✅ All linting checks passed!"

metrics: ## Check code metrics
	@echo "📊 Checking code metrics..."
	flutter pub global run dart_code_metrics:metrics analyze lib \
		--reporter=console \
		--set-exit-on-violation-level=warning

# ============================================================================
# Code Generation
# ============================================================================

generate: ## Run code generation
	@echo "⚙️ Running code generation..."
	dart run build_runner build --delete-conflicting-outputs
	@echo "✅ Code generation complete!"

generate-watch: ## Run code generation in watch mode
	@echo "👀 Running code generation in watch mode..."
	dart run build_runner watch --delete-conflicting-outputs

clean-generate: clean generate ## Clean and regenerate code

# ============================================================================
# Building
# ============================================================================

build-android: ## Build Android APK
	@echo "🤖 Building Android APK..."
	flutter build apk --release

build-android-aab: ## Build Android App Bundle
	@echo "🤖 Building Android App Bundle..."
	flutter build appbundle --release

build-ios: ## Build iOS app
	@echo "🍎 Building iOS app..."
	flutter build ios --release --no-codesign

build-web: ## Build web app
	@echo "🌐 Building web app..."
	flutter build web --release --web-renderer canvaskit

build-windows: ## Build Windows app
	@echo "🪟 Building Windows app..."
	flutter build windows --release

build-macos: ## Build macOS app
	@echo "💻 Building macOS app..."
	flutter build macos --release

build-linux: ## Build Linux app
	@echo "🐧 Building Linux app..."
	flutter build linux --release

build-all: build-android build-web ## Build all platforms

# ============================================================================
# Running
# ============================================================================

run: ## Run app on default device
	@echo "🚀 Running app..."
	flutter run

run-dev: ## Run in development mode
	@echo "🚀 Running in development mode..."
	flutter run --flavor development --dart-define=ENV=development

run-prod: ## Run in production mode
	@echo "🚀 Running in production mode..."
	flutter run --flavor production --dart-define=ENV=production --release

run-chrome: ## Run on Chrome
	@echo "🌐 Running on Chrome..."
	flutter run -d chrome

# ============================================================================
# Maintenance
# ============================================================================

clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	flutter clean
	rm -rf coverage
	rm -rf build
	@echo "✅ Clean complete!"

doctor: ## Run flutter doctor
	@echo "🏥 Running flutter doctor..."
	flutter doctor -v

upgrade: ## Upgrade dependencies
	@echo "⬆️ Upgrading dependencies..."
	flutter pub upgrade --major-versions
	@echo "✅ Dependencies upgraded!"
	@echo "⚠️  Don't forget to test after upgrading!"

outdated: ## Check outdated dependencies
	@echo "📦 Checking outdated dependencies..."
	flutter pub outdated

get: ## Get dependencies
	@echo "📦 Getting dependencies..."
	flutter pub get

# ============================================================================
# Git & CI
# ============================================================================

pre-commit: format analyze test ## Run pre-commit checks
	@echo "✅ Pre-commit checks passed!"

pre-push: pre-commit coverage ## Run pre-push checks
	@echo "✅ Pre-push checks passed!"

ci-local: clean setup lint test coverage ## Simulate CI pipeline locally
	@echo "✅ Local CI pipeline complete!"

# ============================================================================
# TDD Workflow Helpers
# ============================================================================

tdd-red: ## TDD: Create test file (RED phase)
	@echo "🔴 TDD RED Phase: Creating test file..."
	@read -p "Enter test file name (e.g., feature_test.dart): " filename; \
	echo "Creating test/unit/$$filename..."; \
	mkdir -p $$(dirname test/unit/$$filename); \
	echo "import 'package:flutter_test/flutter_test.dart';" > test/unit/$$filename; \
	echo "" >> test/unit/$$filename; \
	echo "void main() {" >> test/unit/$$filename; \
	echo "  group('FeatureName', () {" >> test/unit/$$filename; \
	echo "    test('should do something', () {" >> test/unit/$$filename; \
	echo "      // Arrange" >> test/unit/$$filename; \
	echo "" >> test/unit/$$filename; \
	echo "      // Act" >> test/unit/$$filename; \
	echo "" >> test/unit/$$filename; \
	echo "      // Assert" >> test/unit/$$filename; \
	echo "      expect(true, isFalse); // This should fail!" >> test/unit/$$filename; \
	echo "    });" >> test/unit/$$filename; \
	echo "  });" >> test/unit/$$filename; \
	echo "}" >> test/unit/$$filename; \
	echo "✅ Test file created! Now write your failing tests."; \
	echo "Run 'make test' to see it fail (RED phase)"

tdd-green: test ## TDD: Run tests (GREEN phase)
	@echo "🟢 TDD GREEN Phase: Running tests..."
	@echo "If tests pass, you're in GREEN! If not, fix your implementation."

tdd-refactor: test analyze ## TDD: Refactor while keeping tests green
	@echo "🔵 TDD REFACTOR Phase: Refactoring..."
	@echo "Tests still pass? Great! Refactor complete."

# ============================================================================
# Documentation
# ============================================================================

docs: ## Generate documentation
	@echo "📚 Generating documentation..."
	dart doc .
	@echo "✅ Documentation generated at doc/api"

# ============================================================================
# Security
# ============================================================================

security-check: ## Run security checks
	@echo "🔒 Running security checks..."
	flutter pub global activate dependency_validator
	flutter pub global run dependency_validator:dependency_validator
	@echo "✅ Security checks complete!"

# ============================================================================
# Helpers
# ============================================================================

check-deps: ## Check dependency health
	@echo "📦 Checking dependency health..."
	flutter pub global activate dependency_validator
	flutter pub global run dependency_validator:dependency_validator

import-sort: ## Sort imports
	@echo "📦 Sorting imports..."
	flutter pub global run import_sorter:main

# ============================================================================
# Quick Commands
# ============================================================================

quick-check: format-check analyze test ## Quick quality check
	@echo "✅ Quick check complete!"

full-check: clean setup ci-local ## Full quality check
	@echo "✅ Full check complete!"

# Development cycle: write tests, run, repeat
dev-cycle: generate-watch test-watch ## Start development cycle (watch mode)

# Before creating PR
ready-for-pr: clean setup format analyze test coverage ## Prepare for PR
	@echo "✅ Ready for PR! Don't forget to:"
	@echo "   1. Update CHANGELOG.md"
	@echo "   2. Update documentation"
	@echo "   3. Self-review your code"
	@echo "   4. Create PR using the template"
