//
//  SubtitleStyle.swift
//  SMP
//
//  Created by Marc Jowett on 03/11/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

@objc(BBCSMPSubtitleStyle)
public protocol SubtitleStyle {
    var textColor: UIColor { get }
    var textHighlightColor: UIColor { get }
    var textEdgeStyleAttributes: [NSAttributedString.Key: Any] { get }
    var relativeFontSize: CGFloat { get }
    var fontSizeAsPercentage: String { get }
    var backgroundColor: UIColor { get }
    var fillLineGap: Bool { get }
    
    func font(forSize: CGFloat, isItalic: Bool) -> UIFont
}
