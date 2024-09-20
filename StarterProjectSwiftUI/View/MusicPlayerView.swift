//
//  MusicPlayerView.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 20/09/2024.
//

import Foundation
import SwiftUI

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
