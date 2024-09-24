//
//  SMPUIView.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 23/09/2024.
//

import Foundation
import UIKit
class SMPUIView: UIView {
  var videoView: UIView? {
    didSet {
      updateVideoView(oldVideoView: oldValue)
    }
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  convenience init(videoView: UIView?) {
    self.init(frame: .zero)
    self.videoView = videoView
  }
  private func setupView(){
    updateVideoView(oldVideoView: nil)
  }
  private func updateVideoView(oldVideoView: UIView?) {
    oldVideoView?.removeFromSuperview()
    guard let videoView = videoView else {return}
    videoView.frame = self.bounds
    addSubview(videoView)
  }
}
