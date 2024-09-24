//
//  AudioPlayer.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 20/09/2024.
//

import Foundation
import SwiftUI
import AVFoundation


class AudioPlayer: ObservableObject {
    var player: AVPlayer?
    @Published var isPlaying = false

    func play(url: String) {
        if let remoteURL = URL(string: url) {
            let playerItem = AVPlayerItem(url: remoteURL)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
            isPlaying = true
        }
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
        isPlaying = false
    }
}
