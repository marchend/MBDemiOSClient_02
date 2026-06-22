import SwiftUI

struct ErrorBannerView: View {
    let message: String?

    // #1B2A4A — dark navy
    private let navyColor = Color(red: 0.106, green: 0.165, blue: 0.290)

    var body: some View {
        Group {
            if let message = message {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(navyColor)
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(navyColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(navyColor, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                EmptyView()
            }
        }
        .frame(height: message == nil ? 0 : nil)
        .clipped()
    }
}

#Preview {
    VStack(spacing: 16) {
        ErrorBannerView(message: "Invalid username or password.")
        ErrorBannerView(message: nil)
    }
    .padding()
}
