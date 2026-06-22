# Bootstrap Plan — AcmeBank iOS

## In scope (this PR)

### Project name + tech stack decisions
- **App Name:** AcmeBank
- **Platform:** iOS 17+, Swift 5.10
- **UI Framework:** SwiftUI (`@main struct AcmeBankApp: App`)
- **Project file mechanism:** XcodeGen (`project.yml`) — no hand-crafted `.xcodeproj`
- **Test runner:** XCTest (one unit test proving the test target builds and links)
- **Architecture:** MVVM + Coordinator pattern (full structure deferred; entry file only)
- **Min Xcode:** 16.0, Bundle ID: `com.acmebank.mobile`

### Directory structure (Hello World only)

```
.
├── project.yml                         # XcodeGen spec
├── setup.sh                            # one-shot: installs xcodegen, generates .xcodeproj, opens it
├── .gitignore                          # standard iOS/XcodeGen ignore set
├── bootstrap_plan.md
├── CLAUDE.md
├── AGENT.md
├── README.md
│
├── AcmeBank/
│   ├── App/
│   │   ├── AcmeBankApp.swift           # @main SwiftUI App entry
│   │   └── ContentView.swift           # "AcmeBank" placeholder screen
│   ├── Resources/
│   │   └── Assets.xcassets/
│   │       ├── Contents.json
│   │       └── AppIcon.appiconset/
│   │           └── Contents.json
│   ├── AcmeBank.entitlements           # keychain-access-groups stub
│   └── PrivacyInfo.xcprivacy           # privacy manifest stub
│
├── AcmeBankTests/
│   └── AcmeBankTests.swift             # ONE trivial test (ContentView initializes)
│
└── AcmeBankUITests/
    └── AcmeBankUITests.swift           # ONE trivial XCUITest (app launches)
```

### Files this PR creates
| File | Purpose |
|---|---|
| `project.yml` | XcodeGen project spec — generates `AcmeBank.xcodeproj` |
| `setup.sh` | One-shot clone → open in Xcode script |
| `.gitignore` | Excludes generated `.xcodeproj`, DerivedData, etc. |
| `AcmeBank/App/AcmeBankApp.swift` | `@main` SwiftUI entry point |
| `AcmeBank/App/ContentView.swift` | Placeholder screen: `Text("AcmeBank")` |
| `AcmeBank/Resources/Assets.xcassets/Contents.json` | Asset catalog root metadata |
| `AcmeBank/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json` | AppIcon stub (prevents actool error) |
| `AcmeBank/AcmeBank.entitlements` | Keychain access groups stub |
| `AcmeBank/PrivacyInfo.xcprivacy` | Apple privacy manifest stub |
| `AcmeBankTests/AcmeBankTests.swift` | One test: `ContentView` initializes |
| `AcmeBankUITests/AcmeBankUITests.swift` | One XCUITest: app launches |
| `CLAUDE.md` | Project context for Anthropic agents |
| `AGENT.md` | Identical — project context for all agents |
| `README.md` | Developer quick-start |

### How to run the project locally
```bash
git clone <repo>
cd <repo>
./setup.sh          # installs xcodegen if needed, generates .xcodeproj, opens Xcode
```
Manual fallback:
```bash
brew install xcodegen
xcodegen generate
open AcmeBank.xcodeproj
```

### How to run tests
In Xcode: Cmd+U  
Or from the command line:
```bash
xcodebuild test \
  -scheme AcmeBank \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

### Definition of Hello World
App launches in iOS Simulator and shows a centered `Text("AcmeBank")` label on a white background. One XCTest passes (`test_contentView_initializes`). One XCUITest passes (`test_appLaunches`).

---

## Out of scope — deferred to future work

- **MVVM + Coordinator architecture** (AppCoordinator, LoginCoordinator, TabBarCoordinator, HomeCoordinator, TransferCoordinator, CardsCoordinator, MoreCoordinator) — future PR
- **Authentication — Okta OIDC** (`okta-mobile-swift` SDK, `AuthService`, `KeychainStore`, `UserSession`, Okta.plist, token refresh, `RequestInterceptor`) — future PR
- **Networking layer** (`APIClient`, `APIRouter`, `APIError`, `RequestInterceptor`, `API_BASE_URL` xcconfig injection) — future PR
- **Domain models** (`Account`, `Transaction`, `Customer`, `TransferRequest`, `AccountType`) — future PR
- **Repository protocols** (`AccountRepositoryProtocol`, `TransactionRepositoryProtocol`, `CustomerRepositoryProtocol`, `TransferRepositoryProtocol`) — future PR
- **Data layer — Remote repositories** (`AccountAPIRepository`, `TransactionAPIRepository`, `CustomerAPIRepository`) — future PR
- **Data layer — Mock repositories** (`MockAccountRepository`, `MockTransactionRepository`, `MockCustomerRepository`) — future PR
- **Login screen** (`LoginView`, `LoginViewModel`) — future PR
- **Home Dashboard** (`HomeView`, `HomeViewModel`, `SignedInCardView`, `QuickActionsView`, `AccountRowView`, BFF `GET /v1/home` integration) — future PR
- **Accounts screen** — future PR
- **Transfer screen** (`TransferView`, `TransferViewModel`) — future PR
- **Cards screen** — future PR
- **Design System** (`Colors.swift`, `Typography.swift`, monochrome navy palette, Dynamic Type) — future PR
- **Internal notifications** (`AppNotification`, `NotificationPublisher`, `NotificationKey`) — future PR
- **SwiftLint** (`.swiftlint.yml`, CI lint enforcement, `-warnings-as-errors`) — future PR
- **CI workflow** (GitHub Actions `ios-build.yml`, `xcodebuild test`, xcconfig injection) — future PR
- **Extensions** (`Decimal+Currency`, `Date+Greeting`, `String+Initials`) — future PR
- **RootView** (login vs. tab bar auth-state switching) — future PR
- **`Localizable.strings`** — future PR
- **`Okta.plist.example`** and Okta xcconfig injection — future PR
- **Bills / Bill payment flow** — future PR
- **80% unit test coverage** targets — future PRs as features land
