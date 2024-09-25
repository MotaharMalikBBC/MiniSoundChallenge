//
//  SubtitleHandler.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 23/08/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

public protocol SubtitleHandler {
    var delegate: SubtitleHandlerDelegate? { get set }
    func handleProgress(_ mediaProgress: MediaProgress)
}

public protocol SubtitleHandlerDelegate: AnyObject {
    func updateSuccess(_ result: BBCSMPSubtitleParserResult)
    func updateFailure()
}
