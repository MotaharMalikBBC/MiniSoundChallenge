//
//  DefaultSubtitleProvider.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 19/07/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

public final class DefaultSubtitleProvider: NSObject, SubtitleProvider {
    
    private enum HandlerState {
        case success
        case failure
    }
    
    private var settings: BBCSMPSettingsPersistence {
        didSet { subtitleActive = settings.subtitlesActive() }
    }
    
    private var subtitles: [BBCSMPSubtitle] = [] {
        didSet {
            if oldValue != subtitles {
                notifierDelegate?.notifyLoaded(subtitles)
            }
            notifierDelegate?.notifyCurrentSubtitles(currentSubtitles())
        }
    }
    
    private var subtitleActive: Bool {
        didSet {
            guard subtitleActive != oldValue else { return }
            settings.setSubtitlesActive(subtitleActive)
            notifierDelegate?.notifyActive(status: subtitleActive)
        }
    }
    
    private var subtitleAvailability = false {
        didSet {
            guard oldValue != subtitleAvailability else { return }
            notifierDelegate?.notifyAvailability(status: subtitleAvailability)
        }
    }
    
    private var styles: [AnyHashable: Any] = [:] {
        didSet { notifierDelegate?.notifyStyles(styles, baseStyleKey: styleKey) }
    }
    private var styleKey: String?
    
    weak public var notifierDelegate: SubtitleNotifier? {
        didSet { notifyAllUpdates() }
    }
    
    private var mediaPositionInSeconds: TimeInterval = 0
    
    private var subtitleHandler: SubtitleHandler
    private var subtitleHandlerState: HandlerState?

    public init(settings: BBCSMPSettingsPersistence,
                subtitleHandler: SubtitleHandler) {
        self.settings = settings
        self.subtitleHandler = subtitleHandler
        subtitleActive = settings.subtitlesActive()
        super.init()
        self.subtitleHandler.delegate = self
    }
    
    // MARK: Public
    
    public func setSubtitlesActive(_ status: Bool) {
        subtitleActive = status
    }
    
    public func updateSettings(_ settings: BBCSMPSettingsPersistence) {
        self.settings = settings
    }
    
    public func currentState() -> SubtitleState {
        SubtitleState(availability: subtitleAvailability, activation: subtitleActive, subtitles: currentSubtitles(), styles: styles, baseStyleKey: styleKey)
    }
    
    // MARK: Private
    
    private func notifyAllUpdates() {
        notifierDelegate?.notifyActive(status: subtitleActive)
        notifierDelegate?.notifyCurrentSubtitles(currentSubtitles())
        notifierDelegate?.notifyAvailability(status: subtitleAvailability)
        notifierDelegate?.notifyStyles(styles, baseStyleKey: styleKey)
    }

    private func currentSubtitles() -> [BBCSMPSubtitle] {
        guard settings.subtitlesActive() else {
            return []
        }
        
        var currentSubtitles = [BBCSMPSubtitle]()
        
        for subtitle in subtitles {
            if subtitle.isActive(when: mediaPositionInSeconds) {
                currentSubtitles.append(subtitle)
            }
            
            if subtitle.begin > mediaPositionInSeconds {
                break
            }
        }
        return currentSubtitles
    }
}

// MARK: ProgressObserver

extension DefaultSubtitleProvider {
    public func progress(mediaProgress: MediaProgress) {
        mediaPositionInSeconds = mediaProgress.mediaPosition.seconds

        notifierDelegate?.notifyCurrentSubtitles(currentSubtitles())

        guard subtitleHandlerState != .failure else { return }
        subtitleHandler.handleProgress(mediaProgress)
    }
}

// MARK: - SubtitleHandlerDelegate

extension DefaultSubtitleProvider: SubtitleHandlerDelegate {
    public func updateSuccess(_ result: BBCSMPSubtitleParserResult) {
        subtitleHandlerState = .success
        subtitleAvailability = true
        subtitles = result.subtitles
        styleKey = result.baseStyleKey ?? nil
        styles = result.styleDictionary
    }
    
    public func updateFailure() {
        subtitleHandlerState = .failure
        subtitles = []
        subtitleAvailability = false
        notifierDelegate?.notifyError()
    }
}
