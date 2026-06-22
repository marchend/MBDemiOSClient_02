import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    // #1B2A4A — dark navy
    private let navyColor = Color(red: 0.106, green: 0.165, blue: 0.290)

    var body: some View {
        VStack(spacing: 0) {
            OktaHeaderView()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer().frame(height: 24)

                    // Hexagon "A" logo
                    ZStack {
                        Image(systemName: "hexagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72, height: 72)
                            .foregroundColor(navyColor)
                        Text("A")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }

                    // App name
                    Text("Acme Bank")
                        .font(.title2)
                        .bold()
                        .foregroundColor(navyColor)

                    // Subtitle
                    Text("Sign in to your account")
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray))

                    // Username field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Username")
                            .font(.subheadline)
                            .foregroundColor(navyColor)
                        TextField("name@acmebank.com", text: $viewModel.username)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .accessibilityIdentifier("usernameField")
                    }

                    // Password field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundColor(navyColor)
                        ZStack(alignment: .trailing) {
                            if viewModel.isPasswordVisible {
                                TextField("Password", text: $viewModel.password)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 40)
                                    .background(Color(.systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .accessibilityIdentifier("passwordField")
                            } else {
                                SecureField("Password", text: $viewModel.password)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 40)
                                    .background(Color(.systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .accessibilityIdentifier("passwordField")
                            }
                            Button {
                                viewModel.isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(Color(.systemGray))
                            }
                            .padding(.trailing, 12)
                            .accessibilityIdentifier("passwordVisibilityToggle")
                        }
                    }

                    // Error banner
                    ErrorBannerView(message: viewModel.errorMessage)
                        .accessibilityIdentifier("errorBanner")

                    // Sign in button
                    Button {
                        viewModel.signIn()
                    } label: {
                        Text("Sign in")
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(navyColor)
                            )
                    }
                    .disabled(!viewModel.isSignInEnabled)
                    .opacity(viewModel.isSignInEnabled ? 1.0 : 0.5)
                    .accessibilityIdentifier("signInButton")

                    Spacer().frame(height: 24)
                }
                .padding(.horizontal, 24)
            }

            OktaFooterView()
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
