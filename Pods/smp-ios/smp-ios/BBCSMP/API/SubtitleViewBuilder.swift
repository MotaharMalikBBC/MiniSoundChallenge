//
//  SubtitleViewBuilder.swift
//  SMP
//
//  Created by Andrew Wilson-Jones on 21/07/2021.
//  Copyright © 2021 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPSubtitleViewBuilder)
public class SubtitleViewBuilder: NSObject {
    
    private weak var player: BBCSMPPlayerObservable?
    private var configuration: SubtitlesUIConfiguration
    private var subtitleStyleStatus: SubtitleSettingsStatus
    private var subtitleStyleSettings: SubtitleStyleSettings
    
    @objc
    public func with(configuration: SubtitlesUIConfiguration) -> SubtitleViewBuilder {
        self.configuration = configuration
        return self
    }
    
    @objc
    public func with(styleSettings: SubtitleStyleSettings) -> SubtitleViewBuilder {
        self.subtitleStyleSettings = styleSettings
        return self
    }
    
    @objc
    public init(player: BBCSMPPlayerObservable) {
        self.configuration = DefaultSubtitlesConfiguration()
        self.player = player
        self.subtitleStyleStatus = SystemSubtitleStyleSettingsStatus()
        self.subtitleStyleSettings = MediaAccessibilitySubtitleStyleSettings(domain: .user)
        UIFont.registerFonts()
    }
    
    convenience init(player: BBCSMPPlayerObservable,
                     subtitleStyleStatus: SubtitleSettingsStatus = SystemSubtitleStyleSettingsStatus(),
                     styleSettings: SubtitleStyleSettings = MediaAccessibilitySubtitleStyleSettings(domain: .user)) {
        self.init(player: player)
        self.subtitleStyleStatus = subtitleStyleStatus
        self.subtitleStyleSettings = styleSettings
    }

    @objc(createSubtitleView)
    public func makeSubtitleView() -> UIView {
        let subtitleView = BBCSMPSubtitleView(frame: .zero) { [weak self] styles in
            guard let weakSelf = self, weakSelf.subtitleStyleStatus.isUserDefined else {
                return TTMLSubtitleStyle(mergedStyles: styles)
            }
            return UserDefinedSubtitleStyle(styleSettings: weakSelf.subtitleStyleSettings)
        }
            
        player?.add(observer: subtitleView)
        subtitleView.configuration = configuration
        return subtitleView
    }
    
    private class DefaultSubtitlesConfiguration: NSObject, SubtitlesUIConfiguration {
        func minimumSubtitlesSize() -> Float {
            return 11
        }
    }
}
