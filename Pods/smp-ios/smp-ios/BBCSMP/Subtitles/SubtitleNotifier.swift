//
//  SubtitleNotifier.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 23/08/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

@objc(BBCSMPSubtitleNotifier)
public protocol SubtitleNotifier: AnyObject {
    func notifyCurrentSubtitles(_ subtitles: [BBCSMPSubtitle])
    func notifyAvailability(status: Bool)
    func notifyActive(status: Bool)
    func notifyStyles(_ styles: [AnyHashable: Any], baseStyleKey: String?)
    func notifyError()
    func notifyLoaded(_ subtitles: [BBCSMPSubtitle])
}

public extension SubtitleNotifier {
    func notifyLoaded(_ subtitles: [BBCSMPSubtitle]) { }
}
