//
//  UserDefinedSubtitleStyle.swift
//  SMP
//
//  Created by Marc Jowett on 25/10/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import Foundation
import MediaAccessibility

@objc(BBCSMPUserDefinedSubtitleStyle)
public class UserDefinedSubtitleStyle: NSObject, SubtitleStyle {
        
    private let styleSettings: SubtitleStyleSettings
 
    @objc
    public init(styleSettings: SubtitleStyleSettings = MediaAccessibilitySubtitleStyleSettings(domain: .user)) {
        self.styleSettings = styleSettings
    }

    public var relativeFontSize: CGFloat {
        return styleSettings.relativeFontSize
    }
    
    public var fontSizeAsPercentage: String {
        return String(format: "%.0lf%%", (relativeFontSize * 100))
    }
    
    public var textColor: UIColor {
        let colorFromPreference = styleSettings.foregroundColor
        let opacity = styleSettings.foregroundOpacity
        return UIColor(cgColor: colorFromPreference).withAlphaComponent(opacity)
    }
    
    public var textHighlightColor: UIColor {
        let highlightColor = styleSettings.textHightlightColor
        let opacity = styleSettings.textHightlightColorOpacity
        return UIColor(cgColor: highlightColor).withAlphaComponent(opacity)
    }

    public var textEdgeStyleAttributes: [NSAttributedString.Key: Any] {
        let edgeStyle = styleSettings.textEdgeStyle
        
        var attributes = [NSAttributedString.Key: Any]()
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        
        switch edgeStyle {
        case .undefined, .none:
            shadow.shadowColor = UIColor.clear
            
        case .dropShadow:
            shadow.shadowOffset = CGSize(width: 0, height: 0.7)
            shadow.shadowBlurRadius = 1.2
            
        case .raised:
            shadow.shadowOffset = CGSize(width: -1.1, height: -1.1)
            shadow.shadowBlurRadius = 1.2
            
        case .depressed:
            shadow.shadowOffset = CGSize(width: 1.1, height: 1.1)
            shadow.shadowBlurRadius = 1.2
            
        case .uniform:
            shadow.shadowColor = UIColor.clear
            attributes[.strokeColor] = UIColor.black
            attributes[.strokeWidth] = -2.0
            
        default:
            shadow.shadowColor = UIColor.clear
        }
        
        attributes[.shadow] = shadow
        return attributes
    }
    
    public func font(forSize: CGFloat, isItalic: Bool) -> UIFont {
        let fontDescriptor = styleSettings.fontDescriptor
        let ctFontFromDescriptor = CTFontCreateWithFontDescriptor(fontDescriptor, 0.0, nil)
        let fontName = CTFontCopyName(ctFontFromDescriptor, kCTFontPostScriptNameKey) as? String ?? "Helvetica-Bold"
        return UIFont(name: fontName, size: forSize) ?? .systemFont(ofSize: forSize)
    }
    
    
    public var backgroundColor: UIColor {
        let colorFromPreference = styleSettings.backgroundColor
        let opacity = styleSettings.backgroundColorOpacity
        return UIColor(cgColor: colorFromPreference).withAlphaComponent(opacity)
    }
    
    public var fillLineGap: Bool { false }
}
