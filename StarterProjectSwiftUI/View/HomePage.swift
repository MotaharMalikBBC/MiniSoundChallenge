import SwiftUI
import SMP

struct HomePage: View {
    
  @ObservedObject private var viewModel = HomePageViewModel()
    let station : PlayableItem?
    @State var smpVideoView: UIView?
    @State var isPlaying = false
    @State private var jwtToken: String?
    let rmsAuthenticator = RMSAuthenticator()
    
    var body: some View {
      
      NavigationStack {
          
          ScrollView {
              
              
                  if viewModel.isLoading {
                      ProgressView("Fetching data...")
                  } else if let errorMessage = viewModel.errorMessage {
                      Text(errorMessage)
                          .foregroundColor(.red)
                  } else if !viewModel.user.isEmpty {
                      ForEach(viewModel.user.flatMap {$0.data }, id: \.id) { item in
                          VStack {
                              Color.gray.ignoresSafeArea()
                              Text(item.titles.primary)
                                  .font(.headline)
                                  .padding(.top, 10)
                                  .foregroundColor(.white)
                              if let imageUrlString = item.imageURL, let imageUrl = URL(string: imageUrlString.replacingOccurrences(of: "{recipe}", with: "256x256")) {
                                  ZStack(alignment: .bottomLeading){
                                      AsyncImage(url: imageUrl) { phase in
                                          switch phase {
                                          case .empty:
                                              ProgressView()
                                                  .frame(width: 300, height: 300)
                                          case .success(let image):
                                              image.resizable()
                                                  .aspectRatio(contentMode: .fill)
                                                  .frame(width: 300, height: 300)
                                                  .clipShape(RoundedRectangle(cornerRadius: 25))
                                          case .failure:
                                              Color.red
                                                  .aspectRatio(contentMode: .fill)
                                                  .frame(width: 300, height: 300)
                                                  .clipShape(RoundedRectangle(cornerRadius: 25))
                                          @unknown default:
                                              Color.gray
                                                  .frame(width: 300, height: 300)
                                                  .clipShape(RoundedRectangle(cornerRadius: 25))
                                          }
                                      }
                                      
                                      .frame(width: 300, height: 300)
//                                      Button(isPlaying) {
//                                          if isPlaying {
//                                              stopPlayback()
//                                          } else {
//                                              fetchJWTAndPlay(for: station!)
//                                          }
//                                      }
//                                      
                                      
                                      
                                      Button(action: {
                                          isPlaying ? "Stop" : "Contiinue Playing"
                                          if isPlaying {
                                              stopPlayback()
                                          } else {
                                              fetchJWTAndPlay(for: station!)
                                          }
                                      
                                          // Handle play button action here
                                          print("Play button tapped for \(item.titles.primary)")
                                          
                                        }) {
                                          Image(systemName: "play.circle.fill")
                                              .resizable()
                                              .frame(width: 50, height: 50)
                                              .foregroundColor(.white)
                                              .shadow(radius: 10)
                                      }
                                      SMPView(smpVideoView: smpVideoView)
                                              .frame(height: 150)

                                      
                                  }
                              } else {
                                  Image(systemName: "photo")
                                      .resizable()
                                      .frame(width: 300, height: 300)
                                      .foregroundColor(.gray)
                                      .clipShape(RoundedRectangle(cornerRadius: 25))
                              }
                              Text(item.synopses.short)
                                  .foregroundStyle(.white)
                          }.padding()
                      }
                  } else {
                      Text("No data available")
                          .foregroundColor(.gray)
                          
                  }
          }
          .background(Color.gray)
          
              .onAppear {
                  viewModel.fetchData()
              }
      }
  }
    
    
    private func playStation(with station: PlayableItem) {
        guard let jwtToken = jwtToken else {return }
        
        var builder = BBCSMPPlayerBuilder()
        builder = builder.withInterruptionEndedBehaviour(.autoresume)
        let smp = builder.build()
        
        let authProvider = MediaSelectorAuthenticationProvider(jwtToken: jwtToken)
        
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: station.id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
            .withAuthenticationProvider(authProvider)
            .buildItemProvider()
        
        smp.playerItemProvider = playerItemProvider
        smp.play()
        isPlaying = true
        
        smpVideoView = smp.buildUserInterface().buildView()
        
    }
    
    
    private func stopPlayback() {
        smpVideoView = nil
        isPlaying = false
    }
    
    private func fetchJWTAndPlay(for station: PlayableItem) {
        
        let serviceId = station.id
        
        rmsAuthenticator.fetchJWTToken(for: serviceId ) { token in
            if let jwt = token {
                DispatchQueue.main.async {
                    self.jwtToken = jwt
                    self.playStation(with: station)
                }
            } else {
                print("Failed to fetch JWT")
            }
        }
    }
    
}
//
//#Preview {
//  HomePage()
//}



