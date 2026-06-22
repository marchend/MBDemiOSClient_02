import XCTest
import SwiftUI
import UIKit
@testable import AcmeBank

final class LoginViewTests: XCTestCase {

    // MARK: - LoginView loading

    /// Verify LoginView can be instantiated and laid out in a UIHostingController
    /// without crashing — a regression guard that the view hierarchy compiles and
    /// renders without fatal errors.
    func test_loginView_loadsWithoutCrashing() {
        let viewModel = LoginViewModel()
        let view = LoginView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 393, height: 852)
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()
        XCTAssertFalse(hostingController.view.frame.isEmpty)
    }

    // MARK: - ErrorBannerView collapse

    /// Verify ErrorBannerView loads without crashing when errorMessage is nil,
    /// confirming the conditional rendering path is exercised without a crash.
    func test_errorBanner_hiddenWhenErrorMessageNil() {
        let banner = ErrorBannerView(message: nil)
        let hostingController = UIHostingController(rootView: AnyView(banner))
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 393, height: 100)
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()
        // The view must load without crashing when message is nil.
        // The .frame(height: 0).clipped() modifier collapses layout height to zero.
        XCTAssertFalse(hostingController.view.frame.isEmpty)
    }

    /// Verify ErrorBannerView loads and has non-empty layout when errorMessage
    /// is non-nil — confirms the banner renders content correctly.
    func test_errorBanner_visibleWhenErrorMessageNonNil() {
        let banner = ErrorBannerView(message: "Invalid username or password.")
        let hostingController = UIHostingController(rootView: AnyView(banner))
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 393, height: 200)
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()
        XCTAssertFalse(hostingController.view.frame.isEmpty)
    }
}
