import SwiftUI

struct HomePage: View {
    @StateObject var networkManager = NetworkManagerActive()
    @State private var user: [InlineDisplayModule] = []
    @State private var isUserDataFetched = false // Default to false

    var body: some View {
        NavigationStack {
            ScrollView {
                if isUserDataFetched {
                    VStack() {
                        // Safely access the first playable item
                        if let firstModule = user.first, !firstModule.data.isEmpty {
                            let playableItems = firstModule.data
                            
                            // Loop over each PlayableItem in the InlineDisplayModule
                            ForEach(playableItems, id: \.id) { item in
                                // Display the title
                                Text(item.titles.primary)
                                    .font(.headline)
                                    .padding(.top, 10)
                                
                                // Access the imageUrl and titles
//                              if let imageUrl = Constants.bbbcSoundsImage
                                    /* item.imageUrl?.replacingOccurrences(of: "{recipe}", with: "320x320")*/
                                if let url = URL(string: item.imageUrl ?? Constants.bbbcSoundsImage) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image.resizable()
                                                .frame(width: 300, height: 300)
                                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                        case .failure:
                                            Color.red
                                                .frame(width: 300, height: 300)
                                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 300, height: 300)
                                        @unknown default:
                                            Color.gray
                                                .frame(width: 300, height: 300)
                                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                        }
                                    }
                                } else {
                                    Color.blue
                                        .frame(width: 300, height: 300)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                }
                            }
                        } else {
                            Text("No data available")
                        }
                    }
                    .onAppear {
                        if !isUserDataFetched {
                            Task {
                                await fetchData()
                            }
                        }
                    }
                } else {
                    ProgressView("Fetching data...")
                        .task {
//                            await fetchData()
                        }
                }
            }
        }
    }

    // Fetch data asynchronously
    func fetchData() async {
        print("Starting fetchData()...")
        let result: Result<RMSEndpoint, NetworkManagerActive.APIError> = await networkManager.fetchAPIDetails(from: Constants.rmsEndpoint)

        switch result {
        case .success(let userModel):
            print("Success! User data fetched.")
            
            // Assign the correct array of modules
            if let nationalAndRegionalStations = userModel.data.first(where: { $0.id == "national_and_regional_stations" }) {
                user = [nationalAndRegionalStations] 
                // Wrap it in an array
            }
            isUserDataFetched = true
            
        case .failure(let error):
            print("Error fetching data: \(error)")
            isUserDataFetched = false
        }
        print("isUserDataFetched: \(isUserDataFetched)")
    }
}

#Preview {
    HomePage()
}
