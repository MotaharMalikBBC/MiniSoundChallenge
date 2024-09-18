import SwiftUI

struct LoadingScreen: View {
    
    @State private var isNavigating = false
    @State private var selectedEndpoint: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: Constants.bbbcSoundsImage)) { image in
                    image
                        .resizable()
                        .accessibilityLabel("BBC Sounds")
                        .accessibilityAddTraits(.isImage )
                }
            placeholder: {
                    Color.white
                }
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                HStack {
                    Button(action: {
                        
                        self.selectedEndpoint = Constants.endpointActive
                        self.isNavigating = true  // Set isNavigating to true to trigger navigation
                    }, label: {
                        Text("Active")
                            .frame(width: 100, height: 30, alignment: .center)
                            .padding()
                            .bold()
                            .tint(.green)
                            .background(.black)
                            .cornerRadius(10)
                            
                    })
                    .accessibilityLabel("Active Switch")
                        .accessibilityAddTraits(.isButton )

                    Button(action: {
                        
                        self.selectedEndpoint = Constants.endpointKill
                        self.isNavigating = true  // Set isNavigating to true to trigger navigation
                    }, label: {
                        Text("Kill")
                            .frame(width: 100, height: 30, alignment: .center)
                            .padding()
                            .bold()
                            .tint(.red)
                            .background(.black)
                            .cornerRadius(10)
                        
                            
                    })
                    .accessibilityLabel("Kill Switch")
                        .accessibilityAddTraits(.isButton )
                }
            }
            .navigationTitle("Kill switch page")
            .navigationBarTitleDisplayMode(.inline)
            // Navigate to ContentViewAPI, passing the selectedEndpoint
            .navigationDestination(isPresented: $isNavigating) {
                ContentViewAPI(endpoint: selectedEndpoint)  
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
