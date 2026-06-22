import XCTest

final class AcmeBankUITests: XCTestCase {
    /// Bootstrap proof-of-life: app launches without crashing.
    /// Full critical-flow UI tests (login, transfer, sign-out) belong in
    /// feature stories once those screens are implemented.
    func test_appLaunches() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.state == .runningForeground)
    }
}
