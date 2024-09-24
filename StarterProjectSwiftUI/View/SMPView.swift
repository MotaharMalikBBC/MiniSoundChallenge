//
//  SMPView.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 23/09/2024.
//

import Foundation
import SwiftUI
struct SMPView: UIViewRepresentable {
  var smpVideoView: UIView?
  func makeUIView(context: Context) -> UIView {
    return SMPUIView(videoView: smpVideoView)
  }
  func updateUIView(_ uiView: UIView, context: Context) {
    guard let uiView = uiView as? SMPUIView else {return}
    uiView.videoView = smpVideoView
  }
}
