//
//  TTMLSubtitleStyle.swift
//  SMP
//
//  Created by Vinoth Palanisamy on 10/11/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

@objc(BBCSMPTTMLSubtitleStyle)
public class TTMLSubtitleStyle: NSObject, SubtitleStyle {
    
    let mergedStyles: NSDictionary
    let colorParsing = BBCSMPSubtitleColorParser()
    
    @objc
    public init(mergedStyles: NSDictionary) {
        self.mergedStyles = mergedStyles
    }
    
    public var textColor: UIColor {
        let colorString = mergedStyles["color"]
        return colorParsing.color(from: colorString as? String)
    }
    
    public var textHighlightColor: UIColor {
        // This is to match existing styling, we can change to `textHightlightColor` when ever our API starts sending `textHighlightColor` and `backgroundColor` and needs to update backgroundColor logic too.
        guard let colorString = mergedStyles["backgroundColor"] as? String else {
            return UIColor.clear
        }
        return colorParsing.color(from: colorString)
    }
    
    public var textEdgeStyleAttributes: [NSAttributedString.Key: Any] {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.clear
        return [NSAttributedString.Key.shadow: shadow]
    } 
    
    private var fontFamily: [String] {
        return (mergedStyles["fontFamily"] as? String)?.split(separator: ",").compactMap { String($0.trimmingCharacters(in: .whitespaces)) } ?? []
    }
    
    public func font(forSize: CGFloat, isItalic: Bool) -> UIFont {
        for family in fontFamily {
            if family == "ReithSans" {
                let fontStyle = isItalic ? "Italic" : "Regular"
                if let font = UIFont(name: "BBCReithSans-\(fontStyle)", size: forSize) {
                    return font
                }
            }
            
            let availableFontNames = UIFont.fontNames(forFamilyName: family)
            let regularName = availableFontNames.first
            let italicName = availableFontNames.first { $0.lowercased().contains("italic") ||  $0.lowercased().contains("it") }
            
            if let fontName = isItalic ? italicName : regularName,
               let font = UIFont(name: fontName, size: forSize) {
                return font
            }
        }
       
        return isItalic ? .italicSystemFont(ofSize: forSize) : .systemFont(ofSize: forSize)
    }
    
    public var relativeFontSize: CGFloat {
        return 1.0
    }
    
    public var fontSizeAsPercentage: String {
        return mergedStyles["fontSize"] as? String ?? "100%"
    }
    
    public var backgroundColor: UIColor {
        return UIColor.clear
    }
    
    public var fillLineGap: Bool {
        return mergedStyles["fillLineGap"] as? Bool ?? false
    }
}
