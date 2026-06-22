import SwiftUI

// TODO: The visual error banner has been deferred to the Okta-wiring story.
// The spec screenshot does not include an error banner, and the previous implementation
// used navy as a status/error accent colour, which the spec explicitly prohibits
// ("if you are tempted to add a colour for emphasis or status, Don't").
// `errorMessage` remains on LoginViewModel so the Okta story can set it;
// the visual rendering should be designed together with that story.
struct ErrorBannerView: View {
    let message: String?

    var body: some View {
        EmptyView()
    }
}
