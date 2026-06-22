# AcmeBank iOS

An iOS 17+ banking app built with Swift 5.10 + SwiftUI, following MVVM + Coordinator
architecture and Okta OIDC authentication. This repo is in its bootstrap phase —
see `CLAUDE.md` / `AGENT.md` for the full planned architecture and deferred work.

## Quick Start

```bash
git clone <repo>
cd <repo>
./setup.sh
```

`setup.sh` installs [XcodeGen](https://github.com/yonaskolb/XcodeGen) via Homebrew
if it isn't already present, runs `xcodegen generate` to materialise
`AcmeBank.xcodeproj` from `project.yml`, and opens it in Xcode.

**Manual fallback** (for environments that restrict shell scripts):
```bash
brew install xcodegen
xcodegen generate
open AcmeBank.xcodeproj
```

## Run Tests

In Xcode: `Cmd+U`

CLI:
```bash
xcodebuild test \
  -scheme AcmeBank \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Project Structure

| Path | Contents |
|---|---|
| `project.yml` | XcodeGen spec — **source of truth** for the Xcode project |
| `AcmeBank/App/` | `@main` entry point + placeholder `ContentView` |
| `AcmeBank/Resources/` | `Assets.xcassets`, `PrivacyInfo.xcprivacy` |
| `AcmeBankTests/` | XCTest unit tests |
| `AcmeBankUITests/` | XCUITest end-to-end tests |

`AcmeBank.xcodeproj` is **git-ignored** — it is generated from `project.yml`.
Never hand-edit `project.pbxproj`.

## Branch Model

| Branch | Role |
|---|---|
| `develop` | Default target for all feature PRs |
| `qa` | First quality gate (promotion PR from `develop`) |
| `uat` | Pre-prod acceptance (promotion PR from `qa`) |
| `main` | Production / release tags (promotion PR from `uat`) |

All feature PRs target `develop`. See `CLAUDE.md` for full details.
