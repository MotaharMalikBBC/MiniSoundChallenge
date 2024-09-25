//
//  AVStatisticsConsumer.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 20/06/2024.
//  Copyright © 2024 BBC. All rights reserved.
//

import Foundation
import CoreGraphics

@objc(BBCSMPAVStatisticsConsumer)
public protocol AVStatisticsConsumerProtocol: BBCSMPStatisticsConsumer {
    @objc(trackAVSessionStartForItemMetadata:)
    func trackAVSessionStart(itemMetadata: BBCSMPItemMetadata)
    
    @objc(trackAVFullMediaLength:)
    func trackAVFullMediaLength(lengthInSeconds: Int)
    
    @objc(trackAVPlaybackWithCurrentLocation:customParameters:)
    func trackAVPlayback(currentLocation: Int, customParameters: [AnyHashable: Any]?)
    
    @objc(trackAVPlayingForSubtitlesActive:playlistTime:assetTime:currentLocation:assetDuration:)
    func trackAVPlaying(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, currentLocation: Int, assetDuration: Int)
    
    @objc(trackAVBufferForPlaylistTime:assetTime:currentLocation:)
    func trackAVBuffer(playlistTime: Int, assetTime: Int, currentLocation: Int)
    
    @objc(trackAVPauseForPlaylistTime:assetTime:currentLocation:)
    func trackAVPause(playlistTime: Int, assetTime: Int, currentLocation: Int)
    
    @objc(trackAVResumeForPlaylistTime:assetTime:currentLocation:)
    func trackAVResume(playlistTime: Int, assetTime: Int, currentLocation: Int)
    
    @objc(trackAVScrubFromTime:toTime:)
    func trackAVScrub(from: Int, to: Int)
    
    @objc(trackAVEndForSubtitlesActive:playlistTime:assetTime:assetDuration:wasNatural:withCustomParameters:)
    func trackAVEnd(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, assetDuration: Int, wasNatural: Bool, customParameters: [AnyHashable: Any]?)
    
    @objc(trackAVPlayerSizeChange:)
    func trackAVPlayerSizeChange(_ playerSize: CGSize)
    
    @objc(trackAVError:playlistTime:assetTime:currentLocation:customParameters:)
    func trackAVError(_ errorString: String, playlistTime: Int, assetTime: Int, currentLocation: Int, customParameters: [AnyHashable: Any]?)
    
    @available(*, deprecated, message: "This method is now deprecated. Please use setPlayerIsSubtitledAttribute")
    func trackAVSubtitlesEnabled(_ subtitlesEnabled: Bool)
    
    @objc(seekableRangeChanged:)
    optional func seekableRangeChanged(_ timeRange: BBCSMPTimeRange)
    
    @objc(timeChanged:)
    optional func timeChanged(_ time: BBCSMPTime)
    
    @objc(stateChanged:)
    optional func stateChanged(_ state: SMPPublicState)
    
    @objc(customAvStatsLabelsChanged:)
    optional func customAvStatsLabelsChanged(_ customAvStatsLabels: [String: String]?)
    
    @objc(progress:)
    optional func progress(_ mediaProgress: MediaProgress)
    
    @objc(trackAVPlaybackInitiated)
    optional func trackAVPlaybackInitiated()
    
    @objc
    optional func setPlayerVolumeAttribute(_ volume: NSNumber)
    
    @objc
    optional func setPlayerPlaybackSpeedAttribute(_ targetRate: Float)
    
    @objc
    optional func setPlayerIsSubtitledAttribute(_ subtitleIsEnabled: Bool)
}
