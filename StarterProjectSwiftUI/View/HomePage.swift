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
                                      
                                      Button(action: {
                                          
                                          fetchJWTAndPlay(for: item)
                                          print("============> Play Button clicked!")
                                        }) {
                                          Image(systemName: "play.circle.fill")
                                              .resizable()
                                              .frame(width: 50, height: 50)
                                              .foregroundColor(.white)
                                              .shadow(radius: 10)
                                      }
                                      
                                    
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


//"{\"token\":\"eyJhYWYiOnRydWUsImtpZCI6IjYiLCJpc3MiOiJ1ay5jby5iYmNfc291bmRzIiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJhdWQiOiJiYmNyYWRpbyIsInN1YiI6InVrLmNvLmJiY19zb3VuZHMiLCJ2ZXIiOjEsImlzcyI6InVrLmNvLmJiY19zb3VuZHMiLCJleHAiOjE3MjczMDI5NDIsImlhdCI6MTcyNzIxNjU0MiwiY3ZpZHMiOlsidXJuOmJiYzpwaXBzOnBpZDpiYmNfcmFkaW9fb25lIl19.-NF3YGQzt9akR0Naqc4bBzitH1t6_v_80hDzT-6FG8twu_wq0eLhotc5j4v3orKCh1NFShgJiV8lRmoNoeRwuA\"}"


//"eyJhYWYiOnRydWUsImtpZCI6IjYiLCJpc3MiOiJ1ay5jby5iYmNfc291bmRzIiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJhdWQiOiJiYmNyYWRpbyIsInN1YiI6InVrLmNvLmJiY19zb3VuZHMiLCJ2ZXIiOjEsImlzcyI6InVrLmNvLmJiY19zb3VuZHMiLCJleHAiOjE3MjczMDI5NDIsImlhdCI6MTcyNzIxNjU0MiwiY3ZpZHMiOlsidXJuOmJiYzpwaXBzOnBpZDpiYmNfcmFkaW9fb25lIl19.-NF3YGQzt9akR0Naqc4bBzitH1t6_v_80hDzT-6FG8twu_wq0eLhotc5j4v3orKCh1NFShgJiV8lRmoNoeRwuA"
