import SwiftUI

struct ContentViewAPI: View {
    let endpoint: String  
    @StateObject var networkManager = NetworkManagerActive()
    @State private var user: ApiModel? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    Text(user?.status.message ?? "HOLDER: Unfortunately this version of the app no longer works. You'll need to update it to continue.")
                        .accessibilityLabel(user?.status.message ?? "Unfortunately this version of the app no longer works. You'll need to update it to continue.")
                    Button(action: {
                        if let url = URL(string: user?.status.appStoreURL ?? Constants.url) {
                            UIApplication.shared.open(url)
                        }
                    })
                    {
                        Text(user?.status.linkTitle ?? "HOLDER: Update now")
                    }.accessibilityLabel(user?.status.appStoreURL ?? Constants.url)
                        .accessibilityAddTraits(.isButton )
                    
                    GroupBox {
                        RMSConfigBoxActive(user: user)
                    } label: {
                        Label("RMS Configuration", systemImage: "key.fill")
                    }.accessibilityLabel("RMS configuration")
                }
                .navigationTitle(user?.status.title ?? "HOLDER: it's time to update BBC Sounds")
                .accessibilityLabel(user?.status.title ?? "HOLDER: it's time to update BBC Sounds")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .task {
                    await fetchData()
                }
            }
        }
    }
    func fetchData() async {
        let result : Result<ApiModel, NetworkManagerActive.APIError> = await  networkManager.fetchAPIDetails(from: endpoint)
        switch result {
        case .success(let userModel) :
            print("success!")
            user = userModel
        case .failure(let error) :
            print("error!")
            
        }
        
        
    }
    
}



#Preview {
    ContentViewAPI(endpoint: Constants.endpointActive)  // Provide a sample endpoint for preview
}
