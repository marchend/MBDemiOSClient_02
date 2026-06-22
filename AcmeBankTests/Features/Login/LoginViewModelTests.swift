import XCTest
@testable import AcmeBank

final class LoginViewModelTests: XCTestCase {

    // MARK: - isSignInEnabled

    func test_isSignInEnabled_falseWhenBothFieldsEmpty() {
        let viewModel = LoginViewModel()
        XCTAssertFalse(viewModel.isSignInEnabled)
    }

    func test_isSignInEnabled_falseWhenOnlyUsernameSet() {
        let viewModel = LoginViewModel()
        viewModel.username = "user@acmebank.com"
        XCTAssertFalse(viewModel.isSignInEnabled)
    }

    func test_isSignInEnabled_falseWhenOnlyPasswordSet() {
        let viewModel = LoginViewModel()
        viewModel.password = "secret"
        XCTAssertFalse(viewModel.isSignInEnabled)
    }

    func test_isSignInEnabled_trueWhenBothFieldsNonEmpty() {
        let viewModel = LoginViewModel()
        viewModel.username = "user@acmebank.com"
        viewModel.password = "secret"
        XCTAssertTrue(viewModel.isSignInEnabled)
    }

    // MARK: - signIn

    func test_signIn_invokesOnSignInClosureWithCorrectArgs() {
        let viewModel = LoginViewModel()
        viewModel.username = "user@acmebank.com"
        viewModel.password = "secret123"

        var capturedUsername: String?
        var capturedPassword: String?
        viewModel.onSignIn = { username, password in
            capturedUsername = username
            capturedPassword = password
        }

        viewModel.signIn()

        XCTAssertEqual(capturedUsername, "user@acmebank.com")
        XCTAssertEqual(capturedPassword, "secret123")
    }

    // MARK: - errorMessage

    func test_errorMessage_isNilByDefault() {
        let viewModel = LoginViewModel()
        XCTAssertNil(viewModel.errorMessage)
    }
}
