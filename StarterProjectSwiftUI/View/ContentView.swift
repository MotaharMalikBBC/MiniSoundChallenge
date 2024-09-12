import SwiftUI

struct ContentViewAPI: View {
    let endpoint: String  // Accept the endpoint dynamically
    @StateObject var networkManager = NetworkManagerActive()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    Text(networkManager.user?.status.message ?? "HOLDER: Unfortunately this version of the app no longer works. You'll need to update it to continue.")
                        .accessibilityLabel(networkManager.user?.status.message ?? "Unfortunately this version of the app no longer works. You'll need to update it to continue.")
                    Button(action: {
                        if let url = URL(string: networkManager.user?.status.appStoreURL ?? Constants.url) {
                            UIApplication.shared.open(url)
                        }
                    })
                    {
                        Text(networkManager.user?.status.linkTitle ?? "HOLDER: Update now")
                    }.accessibilityLabel(networkManager.user?.status.appStoreURL ?? Constants.url)
                        .accessibilityAddTraits(.isButton )
                    
                    GroupBox {
                        RMSConfigBoxActive(user: networkManager.user)
                    } label: {
                        Label("RMS Configuration", systemImage: "key.fill")
                    }.accessibilityLabel("RMS configuration")
                }
                .navigationTitle(networkManager.user?.status.title ?? "HOLDER: it's time to update BBC Sounds")
                .accessibilityLabel(networkManager.user?.status.title ?? "HOLDER: it's time to update BBC Sounds")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .task {
                    await networkManager.fetchAPIDetails(from: endpoint)  // Pass the endpoint to the fetch method
                }
            }
        }
    }
}

#Preview {
    ContentViewAPI(endpoint: Constants.endpointActive)  // Provide a sample endpoint for preview
}
