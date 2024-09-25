//
//  SystemSubtitleStyleSettingStatus.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 10/11/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import MediaAccessibility

@objc
public protocol SubtitleSettingsStatus {
    var isUserDefined: Bool { get }
}

@objc
public final class SystemSubtitleStyleSettingsStatus: NSObject, SubtitleSettingsStatus {
    
    private let customSettings: SubtitleStyleSettings
    private let defaultSettings: SubtitleStyleSettings
 
    @objc
    public init(customSettings: SubtitleStyleSettings = MediaAccessibilitySubtitleStyleSettings(domain: .user),
                defaultSettings: SubtitleStyleSettings = MediaAccessibilitySubtitleStyleSettings(domain: .default)) {
        self.customSettings = customSettings
        self.defaultSettings = defaultSettings
    }
    
    public var isUserDefined: Bool {
        guard customSettings.relativeFontSize
                == defaultSettings.relativeFontSize
        else { return true }
        
        guard customSettings.foregroundColor
                == defaultSettings.foregroundColor
        else { return true }
        
        guard customSettings.foregroundOpacity
                == defaultSettings.foregroundOpacity
        else { return true }
        
        guard customSettings.fontDescriptor
                == defaultSettings.fontDescriptor
        else { return true }
        
        guard customSettings.textHightlightColor
                == defaultSettings.textHightlightColor
        else { return true }
        
        guard customSettings.backgroundColorOpacity
                == defaultSettings.backgroundColorOpacity
        else { return true }
        
        guard customSettings.backgroundColor
                == defaultSettings.backgroundColor
        else { return true }
        
        guard customSettings.textHightlightColorOpacity
                == defaultSettings.textHightlightColorOpacity
        else { return true }
        
        guard customSettings.textEdgeStyle
                == defaultSettings.textEdgeStyle
        else { return true }
        
        return false
    }
}
