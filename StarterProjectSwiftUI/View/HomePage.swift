import SwiftUI
struct HomePage: View {
  @StateObject private var viewModel = HomePageViewModel()
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
                                          // Handle play button action here
                                          print("Play button tapped for \(item.titles.primary)")
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
}
#Preview {
  HomePage()
}
struct MusicPlayerView: View {
    @StateObject private var audioPlayer = AudioPlayer()

    let remoteURL = "https://www.example.com/audio.mp3"  // Replace with your remote audio URL

    var body: some View {
        VStack {
            Text("Music Player")
                .font(.largeTitle)
                .padding()

            if audioPlayer.isPlaying {
                Button(action: {
                    audioPlayer.pause()
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                }
            } else {
                Button(action: {
                    audioPlayer.play(url: remoteURL)
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                }
            }

            Button(action: {
                audioPlayer.stop()
            }) {
                Text("Stop")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}


