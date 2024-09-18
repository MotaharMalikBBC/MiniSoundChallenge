import SwiftUI

struct ContentViewAPI: View {
    let endpoint: String  
    @StateObject var networkManager = NetworkManagerActive()
    @State private var user: ApiModel? = nil
    @State private var isUserDataFetched = Bool()
    @State private var isLoading = true
    @State private var isTapped = false
    
    var body: some View {
        NavigationStack {
            if isLoading {
                VStack {
                    ProgressView("Loading..")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
            
            else if isUserDataFetched {
                ScrollView {
                    VStack(spacing: 40) {
                        Text(user?.status.message ?? "HOLDER")
                           
                            
                            .accessibilityLabel(user?.status.message ?? "HOLDER")
                        
                        Button(action: {
                            if let url = URL(string: user?.status.appStoreURL ?? Constants.url) {
                                UIApplication.shared.open(url)
                            }
                        })
                        {
                            Text(user?.status.linkTitle ?? "")
                        }.accessibilityLabel(user?.status.appStoreURL ?? Constants.url)
                            .accessibilityAddTraits(.isButton )
                        
                        GroupBox {
                            RMSConfigBoxActive(user: user)
                        } label: {
                            Label("RMS Configuration", systemImage: "key.fill")
                        }.accessibilityLabel("RMS configuration")
                        if endpoint == Constants.endpointActive
                        {
                            Button(action: {
                                self.isTapped = true
                            },
                                   label: {
                                Text("Home page").padding()
                                    .frame(width: 120.0, height: 50.0)
                                    .background(.black)
                                    .cornerRadius(10)
                                    .tint(.orange)
                                    
                                    
                            })
                        }
                    }
                    .navigationTitle(user?.status.title ?? "")
                    .accessibilityLabel(user?.status.title ?? "")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(isPresented: $isTapped) { MainView()
                            .padding()
                           
                        
                    }
                }}
        } .onAppear(perform: {
            Task {
                await fetchData()
            }
        })
    }
     func fetchData() async {
        let result : Result<ApiModel, NetworkManagerActive.APIError> = await  networkManager.fetchAPIDetails(from: endpoint)
        switch result {
        case .success(let userModel) :
            print("success!")
            user = userModel
            isUserDataFetched = true
            isLoading = false
        case .failure(let error) :
            print("error!")
            isLoading = false
        }
        
        
    }
    
}



//#Preview {
//    ContentViewAPI(endpoint: Constants.endpointActive)  // Provide a sample endpoint for preview
//}
