import SwiftUI

struct OktaHeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Image(systemName: "lock")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Text("acmebank.okta.com")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Spacer()
                Image(systemName: "dot.circle")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Text("okta")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            Divider()
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    OktaHeaderView()
}
