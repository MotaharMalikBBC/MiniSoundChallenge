//
//  SubtitleStyleSettings.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 10/11/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import Foundation
import MediaAccessibility

@objc
public protocol SubtitleStyleSettings {
    var foregroundColor: CGColor { get }
    var textHightlightColor: CGColor { get }
    var backgroundColor: CGColor { get }
    var foregroundOpacity: CGFloat { get }
    var textHightlightColorOpacity: CGFloat { get }
    var backgroundColorOpacity: CGFloat { get }
    var fontDescriptor: CTFontDescriptor { get }
    var relativeFontSize: CGFloat { get }
    var textEdgeStyle: MACaptionAppearanceTextEdgeStyle { get }
}

public final class MediaAccessibilitySubtitleStyleSettings: SubtitleStyleSettings {
    
    private let domain: MACaptionAppearanceDomain
    
    public init(domain: MACaptionAppearanceDomain) {
        self.domain = domain
    }
    
    public var foregroundColor: CGColor {
        return MACaptionAppearanceCopyForegroundColor(domain, nil).takeUnretainedValue()
    }
    
    public var textHightlightColor: CGColor {
        MACaptionAppearanceCopyBackgroundColor(domain, nil).takeUnretainedValue()
    }
    
    public var backgroundColor: CGColor {
        MACaptionAppearanceCopyWindowColor(domain, nil).takeUnretainedValue()
    }
    
    public var foregroundOpacity: CGFloat {
        MACaptionAppearanceGetForegroundOpacity(domain, nil)
    }
    
    public var textHightlightColorOpacity: CGFloat {
        MACaptionAppearanceGetBackgroundOpacity(domain, nil)
    }
    
    public var backgroundColorOpacity: CGFloat {
        MACaptionAppearanceGetWindowOpacity(domain, nil)
    }
    
    public var fontDescriptor: CTFontDescriptor {
        MACaptionAppearanceCopyFontDescriptorForStyle(domain, nil, .default).takeUnretainedValue()
    }
    
    public var relativeFontSize: CGFloat {
        MACaptionAppearanceGetRelativeCharacterSize(domain, nil)
    }
    
    public var textEdgeStyle: MACaptionAppearanceTextEdgeStyle {
        MACaptionAppearanceGetTextEdgeStyle(domain, nil)
    }
}
