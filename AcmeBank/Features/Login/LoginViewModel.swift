import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    // NOTE: password is plain-text — the Okta story must not read this field for the real flow.
    // The real implementation should pass credentials directly to the OIDC SDK without
    // materialising them as a durable Swift String that can linger in heap memory.
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String? = nil

    var isSignInEnabled: Bool {
        !username.isEmpty && !password.isEmpty
    }

    var onSignIn: (String, String) -> Void = { _, _ in }

    func signIn() {
        onSignIn(username, password)
    }
}
