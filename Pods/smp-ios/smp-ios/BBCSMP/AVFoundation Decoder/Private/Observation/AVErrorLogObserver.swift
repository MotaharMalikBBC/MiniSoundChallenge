//
//  AVErrorLogObserver.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 25/01/2024.
//  Copyright © 2024 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPAVErrorLogObserver)
final public class AVErrorLogObserver: NSObject {
    private let context: BBCSMPAVObservationContext
    private let eventBus: BBCSMPEventBus
    private var receptionist: BBCSMPNotificationReceptionist?
        
    @objc
    public init(context: BBCSMPAVObservationContext, eventBus: BBCSMPEventBus) {
        self.context = context
        self.eventBus = eventBus
        super.init()
        guard let playerItem = context.playerItem, let callbackWorker = context.callbackWorker else {
            return
        }
        receptionist = BBCSMPNotificationReceptionist(notificationName:  Notification.Name.AVPlayerItemNewErrorLogEntry.rawValue,
                                                       postedFrom: .default,
                                                       from: playerItem,
                                                       callbackWorker: callbackWorker,
                                                       target: self,
                                                       selector: #selector(playerErrorLogUpdated))
    }
    
    @objc func playerErrorLogUpdated(notification: NSNotification) {
        let playerItem = notification.object as? AVPlayerItem
        let errorLog = playerItem?.errorLog()
        let event = errorLog?.events.last
        
        if event?.errorStatusCode == Constants.avCoreMediaFailedToLoadPlaylistErrorCode &&
            event?.errorDomain == Constants.avCoreMediaErrorDomain {
            let event = BBCSMPAVFailedToLoadPlaylistEvent()
            eventBus.sendEvent(event)
        }
    }
    
    private struct Constants {
        static let avCoreMediaErrorDomain = "CoreMediaErrorDomain"
        static let avCoreMediaFailedToLoadPlaylistErrorCode = -12884
    }
}
