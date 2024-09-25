//
//  SubtitleObserverManager.swift
//  BBCSMPTests
//
//  Created by Vinoth Palanisamy on 11/08/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPSubtitleObserverManager)
final public class SubtitleObserverManager: NSObject {
    
    public typealias SubtitleFailureCallback = () -> Void
    
    @objc
    public var observers: [Int: BBCSMPSubtitleObserver] = [:]
    
    private var subtitleProvider: SubtitleProvider?
    private var subtitleFailureCallback: SubtitleFailureCallback?
    
    @objc
    public func addObserver(_ observer: BBCSMPSubtitleObserver) {
        observers[observer.hash] = observer
        
        guard let state = subtitleProvider?.currentState() else { return }
        
        observer.subtitleActivationChanged(state.activation as NSNumber)
        observer.subtitleAvailabilityChanged(state.availability as NSNumber)
        observer.subtitlesUpdated(state.subtitles)
        observer.styleDictionaryChanged(state.styles, state.baseStyleKey)
    }
    
    @objc
    public func removeObserver(_ observer: BBCSMPSubtitleObserver) {
        observers.removeValue(forKey: observer.hash)
    }
    
    @objc
    public func attachSubtitleProvider(_ provider: SubtitleProvider, failureCallback: SubtitleFailureCallback? = nil) {
        subtitleProvider = provider
        subtitleProvider?.notifierDelegate = self
        subtitleFailureCallback = failureCallback
    }
}

extension SubtitleObserverManager: SubtitleNotifier {
    
    public func notifyActive(status: Bool) {
        observers.values.forEach { observer in
            observer.subtitleActivationChanged(status as NSNumber)
        }
    }
    
    public func notifyLoaded(_ subtitles: [BBCSMPSubtitle]) {
        observers.values.forEach { observer in
            observer.subtitlesLoaded?(subtitles)
        }
    }
    
    public func notifyAvailability(status: Bool) {
        observers.values.forEach { observer in
            observer.subtitleAvailabilityChanged(status as NSNumber)
        }
    }
    
    public func notifyCurrentSubtitles(_ subtitles: [BBCSMPSubtitle]) {
        observers.values.forEach { observer in
            observer.subtitlesUpdated(subtitles)
        }
    }
    
    public func notifyStyles(_ styles: [AnyHashable: Any], baseStyleKey: String?) {
        observers.values.forEach { observer in
            observer.styleDictionaryChanged(styles, baseStyleKey)
        }
    }
    
    public func notifyError() {
        subtitleFailureCallback?()
    }
}
