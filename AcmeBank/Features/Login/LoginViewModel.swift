import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
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
