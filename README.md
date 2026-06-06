# SimpleBank

SimpleBank is an iOS sample project focused on clean architecture, testability, and CI/CD practices for a modern Swift application.

## Overview

The project currently includes an Investments feature built using MVVM, Use Cases, Repository Pattern, Dependency Injection, and Async/Await.

The goal of this project is to demonstrate production-oriented iOS development practices including architecture, testing, code quality, and automation.

## Tech Stack

- Swift
- SwiftUI
- Async/Await
- XCTest
- GitHub Actions
- SwiftLint
- SonarCloud
- Xcode Code Coverage

## Architecture

The project follows a layered structure:

```text
Presentation
    ↓
Domain
    ↓
Data
```

### Presentation

Contains SwiftUI views, view models, and UI state handling.

### Domain

Contains business rules and use cases.

### Data

Contains repositories and data providers.

## Testing

The project includes unit tests for:

- ViewModel state transitions
- Use Case behavior
- Repository integration boundaries
- Async loading states

Current code coverage:

**79.8%**

Coverage is automatically measured during CI and reported to SonarCloud.

## Continuous Integration

GitHub Actions automatically runs on every Pull Request and Push to main.

The pipeline includes:

- SwiftLint validation
- Unit test execution
- Code coverage generation
- SonarCloud analysis
- Quality Gate validation

Pull Requests cannot be merged unless all required checks pass successfully.

## Code Quality

The project uses SonarCloud to monitor:

- Code coverage
- Maintainability
- Security hotspots
- Code duplication
- Quality Gate compliance

## Future Improvements

Planned additions include:

- Snapshot Testing
- UI Testing
- Additional banking features
- Fastlane integration
- TestFlight deployment pipeline
