//
//  SubtitleProvider.swift
//  SMP
//
//  Created by Rory Clear on 19/07/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

@objc(BBCSMPSubtitleProvider)
public protocol SubtitleProvider: NSObjectProtocol, ProgressObserver {
    var notifierDelegate: SubtitleNotifier? { get set }
    
    func setSubtitlesActive(_ toActive: Bool)
    func updateSettings(_ settings: BBCSMPSettingsPersistence)
    func currentState() -> SubtitleState
}

@objc(BBCSMPSubtitleState)
final public class SubtitleState: NSObject {
    let availability: Bool
    let activation: Bool
    let subtitles: [BBCSMPSubtitle]
    let styles: [AnyHashable: Any]
    let baseStyleKey: String?
    
    public init(availability: Bool, activation: Bool, subtitles: [BBCSMPSubtitle], styles: [AnyHashable: Any], baseStyleKey: String?) {
        self.availability = availability
        self.activation = activation
        self.subtitles = subtitles
        self.styles = styles
        self.baseStyleKey = baseStyleKey
    }
}
