import SwiftUI

struct OktaFooterView: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(spacing: 4) {
                Spacer()
                Text("Secured by")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                // TODO: replace with Image("okta-logo") once the Okta brand asset is available in the repo.
                // Using a generic system symbol as the Okta logo may raise brand/trademark concerns.
                Image(systemName: "dot.circle")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Text("okta")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    OktaFooterView()
}
