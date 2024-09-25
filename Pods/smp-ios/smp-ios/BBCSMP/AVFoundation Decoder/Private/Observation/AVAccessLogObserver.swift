//
//  AVAccessLogObserver.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 24/01/2024.
//  Copyright © 2024 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPAVAccessLogObserver)
final public class AVAccessLogObserver: NSObject {
    private let context: BBCSMPAVObservationContext
    private var receptionist: BBCSMPNotificationReceptionist?
        
    @objc
    public init(context: BBCSMPAVObservationContext) {
        self.context = context
        super.init()
        guard let playerItem = context.playerItem,
                let callbackWorker = context.callbackWorker else {
            return
        }
        receptionist = BBCSMPNotificationReceptionist(notificationName: AVPlayerItem.newAccessLogEntryNotification.rawValue,
                                                      postedFrom: NotificationCenter.default,
                                                      from: playerItem,
                                                      callbackWorker: callbackWorker,
                                                      target: self,
                                                      selector: #selector(playerAccessLogUpdated))
    }
        
    @objc func playerAccessLogUpdated(notification: NSNotification) {
        let accessLog = context.playerItem?.accessLog()
        guard let event = accessLog?.events.last else {
            return
        }
        context.decoderDelegate?.decoderBitrateChanged(event.indicatedBitrate)
    }
}
