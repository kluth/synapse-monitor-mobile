# Pull Request

## 📝 Description

<!-- Provide a brief description of the changes in this PR -->

## 🎯 Type of Change

<!-- Mark the relevant option with an 'x' -->

- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] 📚 Documentation update
- [ ] 🎨 Code refactoring (no functional changes)
- [ ] ⚡ Performance improvement
- [ ] ✅ Test updates
- [ ] 🔧 Configuration/build changes

## 🔗 Related Issues

<!-- Link to related issues using #issue_number -->

Closes #
Related to #

## 🧪 Testing (TDD Required)

<!-- This project enforces TDD. Tests must be written FIRST! -->

### RED Phase ✅
- [ ] Wrote failing tests before implementation
- [ ] Tests clearly define requirements
- [ ] All test cases added to cover edge cases

### GREEN Phase ✅
- [ ] Implementation makes all tests pass
- [ ] No test skipped or ignored
- [ ] All existing tests still pass

### REFACTOR Phase ✅
- [ ] Code improved for readability
- [ ] No duplication
- [ ] Follows Clean Architecture principles

### Test Coverage
<!-- Describe what tests were added -->

- Unit tests: <!-- list test files -->
- Widget tests: <!-- list test files -->
- Integration tests: <!-- list test files -->

```bash
# Test results
flutter test
# Include test coverage percentage here
```

## 📸 Screenshots/Videos

<!-- If applicable, add screenshots or videos to demonstrate changes -->

## ✅ Checklist

### Code Quality
- [ ] My code follows the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guidelines
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] My code follows Clean Architecture principles
- [ ] No hardcoded values (use constants/config)

### Testing
- [ ] I wrote tests BEFORE implementation (TDD)
- [ ] All tests pass locally (`flutter test`)
- [ ] Test coverage is ≥85% for new code
- [ ] I have added widget tests for new UI components
- [ ] I have added integration tests if applicable

### Code Generation
- [ ] I ran code generation (`dart run build_runner build`)
- [ ] Generated files (.freezed.dart, .g.dart) are included
- [ ] No generated file conflicts

### Analysis & Formatting
- [ ] Code is properly formatted (`dart format .`)
- [ ] No analyzer warnings (`flutter analyze`)
- [ ] Imports are properly sorted
- [ ] No unused dependencies

### Documentation
- [ ] I have updated the README if needed
- [ ] I have added /// doc comments for public APIs
- [ ] I have updated CHANGELOG.md
- [ ] I have updated architecture docs if needed

### Clean Architecture
- [ ] Domain layer has no Flutter/external dependencies
- [ ] Data layer properly implements repository interfaces
- [ ] Presentation layer uses Riverpod providers correctly
- [ ] Proper separation of concerns maintained

### Performance
- [ ] No performance regressions
- [ ] Proper use of const constructors
- [ ] No unnecessary rebuilds
- [ ] Async operations handled correctly

### Security
- [ ] No sensitive data hardcoded
- [ ] API keys in environment variables
- [ ] Proper input validation
- [ ] No SQL injection vulnerabilities

## 🔍 Code Review Focus Areas

<!-- Guide reviewers on what to focus on -->

1.
2.
3.

## 📚 Additional Context

<!-- Add any other context about the PR here -->

## 🚀 Deployment Notes

<!-- Any special deployment considerations? -->

---

## For Reviewers

### Review Checklist
- [ ] Code follows project structure and patterns
- [ ] Tests are comprehensive and follow TDD
- [ ] Documentation is clear and complete
- [ ] No obvious bugs or edge cases missed
- [ ] Performance is acceptable
- [ ] Security considerations addressed

### Review Questions
<!-- Reviewers: Ask questions here -->

---

**By submitting this PR, I confirm that:**
- I have followed the TDD approach (RED → GREEN → REFACTOR)
- My code follows Clean Architecture principles
- All tests pass and coverage is adequate
- I have reviewed my own code thoroughly
