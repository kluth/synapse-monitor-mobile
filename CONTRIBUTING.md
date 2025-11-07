# Contributing to Synapse Monitor

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## 🧪 Test-Driven Development (MANDATORY)

This project enforces **TDD**. All feature code must be preceded by tests.

### TDD Cycle: 🔴 RED → 🟢 GREEN → 🔵 REFACTOR

1. **RED**: Write failing tests FIRST
2. **GREEN**: Write minimal code to pass tests
3. **REFACTOR**: Improve code while keeping tests green

No code will be merged without tests written first!

## 🏗️ Clean Architecture

Follow strict layer separation:
- **Domain**: Pure Dart, no Flutter
- **Data**: External dependencies, implements repositories
- **Presentation**: UI, depends on domain

Dependencies flow: `Presentation → Domain ← Data`

## 📝 Commit Guidelines

Follow Conventional Commits:
```
feat(scope): description
fix(scope): description
test(scope): description
```

## 🔀 Pull Request Process

1. Write tests FIRST (RED)
2. Implement feature (GREEN)
3. Refactor if needed (REFACTOR)
4. Run: `flutter test`, `flutter analyze`, `dart format .`
5. Ensure 85%+ test coverage
6. Create PR using template

## 📚 Resources

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [TDD Guide](https://en.wikipedia.org/wiki/Test-driven_development)

For detailed guidelines, see full documentation in the repo wiki.
