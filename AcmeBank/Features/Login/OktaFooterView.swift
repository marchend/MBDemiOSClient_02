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
