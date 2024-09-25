//
//  UIFonts+Extension.swift
//  SMP
//
//  Created by Vishnu Priya Jayaram Sourirajan on 07/12/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import Foundation
public extension UIFont {
    static func registerFonts() {
        do {
            try UIFont.register(type: "ttf")
        } catch(let error) {
            debugPrint(error.localizedDescription)
        }
    }
    
    private class GetBundle {}
    
    static func register(type: String) throws {
        let frameworkBundle = Bundle(for: GetBundle.self)

        if let fonts = frameworkBundle.urls(forResourcesWithExtension: "ttf", subdirectory: nil) {
            fonts.forEach({ url in
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            })
        }
    }
}
