# AcmeBank iOS — Agent Context

## Project Overview
AcmeBank is an iOS 17+ banking app built in Swift/SwiftUI. It provides customers
with account balances, transaction history, fund transfers, bill payments, and card
management — secured via Okta OIDC authentication. This repo currently contains the
Hello-World bootstrap shell; all features ship in follow-up PRs against `develop`.

## Tech Stack
| Item | Value |
|---|---|
| Platform | iOS 17+, Swift 5.10, Xcode 16+ |
| UI Framework | SwiftUI (`@main struct AcmeBankApp: App`) |
| Architecture | MVVM + Coordinator (SwiftUI `NavigationStack`) |
| Project file | XcodeGen `project.yml` (never hand-edit `project.pbxproj`) |
| Auth | Okta OIDC via `okta-mobile-swift` (deferred) |
| Networking | `URLSession` + async/await (deferred) |
| Dependency Injection | Constructor injection; no service locator |
| Test framework | XCTest (unit) + XCUITest (UI end-to-end) |
| Bundle ID | `com.acmebank.mobile` |

## How to Run Locally
```bash
git clone <repo>
cd <repo>
./setup.sh        # installs xcodegen, generates .xcodeproj, opens Xcode
```
Manual fallback:
```bash
brew install xcodegen && xcodegen generate && open AcmeBank.xcodeproj
```

## How to Run Tests
In Xcode: `Cmd+U`
CLI:
```bash
xcodebuild test \
  -scheme AcmeBank \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Key Directory Structure
```
project.yml               # XcodeGen spec — source of truth for .xcodeproj
setup.sh                  # post-clone one-shot materialisation script
AcmeBank/
  App/                    # @main entry + ContentView (bootstrap placeholder)
  Core/                   # Auth, Networking, Notifications, Extensions (deferred)
  Domain/                 # Models + Repository protocols (deferred)
  Data/                   # Remote + Mock repository implementations (deferred)
  Features/               # Login, Home, Accounts, Transfer, Cards screens (deferred)
  DesignSystem/           # Colors, Typography (deferred)
  Resources/              # Assets.xcassets, PrivacyInfo.xcprivacy
  AcmeBank.entitlements   # Keychain access groups
AcmeBankTests/            # XCTest unit tests
AcmeBankUITests/          # XCUITest end-to-end tests
```

## Planned Architecture

### MVVM + Coordinator (deferred — future PR)
- **View** — SwiftUI `View` struct; renders ViewModel `@Published` state; zero business logic.
- **ViewModel** — `final class: ObservableObject`; holds `@Published` state; calls repositories; imports no SwiftUI view types.
- **Coordinator** — `ObservableObject`; owns `NavigationStack` path; creates child Views+ViewModels; drives push/present declaratively.
- **Repository protocols** in `Domain/`; concrete implementations in `Data/`; ViewModels depend only on protocols.

### Coordinator Tree (deferred — future PR)
```
AppCoordinator (observed by RootView)
  ├── LoginCoordinator   (full-screen, no session)
  └── TabBarCoordinator  (root TabView after login)
        ├── HomeCoordinator
        ├── TransferCoordinator
        ├── CardsCoordinator
        └── MoreCoordinator
```

### Auth — Okta OIDC (deferred — future PR)
- `AuthService` wraps `okta-mobile-swift`; persists tokens via `KeychainStore`.
- `UserSession` value type passed forward through coordinators; never stored in `UserDefaults`.
- `RequestInterceptor` refreshes token before every request; posts `AppNotification.sessionExpired` on failure.
- **Keychain in CI:** always include `kSecUseDataProtectionKeychain: true` in every `SecItem*` query to avoid `-34018` in simulator CI builds.

### Networking (deferred — future PR)
- `APIClient` wraps `URLSession`; decodes with `.convertFromSnakeCase` + `.iso8601`.
- `APIRouter` enum encodes every endpoint (path, method, body, queryItems).
- `API_BASE_URL` read from `Info.plist`; injected by CI via xcconfig — never hardcoded.

### Domain Models (deferred — future PR)
`Account`, `Transaction`, `Customer`, `TransferRequest` — `Identifiable`/`Codable` value types.

### Design System (deferred — future PR)
Strict monochrome palette: `acmeNavy (#1B2A4A)`, `acmeBackground (#F2F3F5)`, `acmeSurface`, `acmeText (#1A1A1A)`, `acmeSubtext (#6B7280)`. **No semantic colours** (no red/green for amounts). All fonts use Dynamic Type.

### Internal Notifications (deferred — future PR)
`AppNotification` enum of typed `Notification.Name` constants. `NotificationPublisher.post(_:userInfo:)` wrapper. Subscriptions owned by `AppCoordinator` via Combine — never inside a ViewModel.

### CI (deferred — future PR)
GitHub Actions `ios-build.yml`; `xcodebuild test`; SwiftLint (`-warnings-as-errors`); xcconfig injection for secrets.

## Deferred Work
- MVVM + Coordinator full wiring (AppCoordinator, LoginCoordinator, TabBarCoordinator, etc.)
- Okta OIDC authentication (AuthService, KeychainStore, UserSession, token refresh)
- Networking layer (APIClient, APIRouter, APIError, RequestInterceptor)
- Domain models (Account, Transaction, Customer, TransferRequest)
- Repository protocols + Remote/Mock implementations
- Login, Home Dashboard (BFF `GET /v1/home`), Accounts, Transfer, Cards screens
- Design system (Colors, Typography, monochrome navy palette)
- Internal notifications (AppNotification, NotificationPublisher)
- SwiftLint enforcement + CI workflow
- Extensions (Decimal+Currency, Date+Greeting, String+Initials)
- RootView auth-state switching
- Localizable.strings, Okta.plist.example
- Bills / bill payment flow
- 80% unit test coverage targets

## Git Workflow

> **Default PR target branch: `develop`.** Every feature/refactor/docs PR
> opens against `develop`. PRs are only opened against `qa`, `uat`, or
> `main` for explicit promotion PRs.

**Branch model (`develop` → `qa` → `uat` → `main`):**

| Branch  | Role                                 | Receives PRs from              | Promotes to |
|---------|--------------------------------------|--------------------------------|-------------|
| develop | Default integration branch           | feature branches               | qa          |
| qa      | First quality gate                   | develop (promotion PR)         | uat         |
| uat     | Pre-prod acceptance                  | qa (promotion PR)              | main        |
| main    | Production / release tags            | uat (promotion PR)             | tagged only |

All feature PRs MUST target `develop`. Never open a feature PR against
`qa`, `uat`, or `main`. Promotions happen via dedicated promotion PRs.
