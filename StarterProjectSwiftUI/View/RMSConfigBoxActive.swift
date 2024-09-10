//
//  RMSConfigbox.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 06/09/2024.
//

import Foundation
import SwiftUI


struct RMSConfigBoxActive: View {
    public var user: ApiModel?
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("API key:").accessibilityLabel("API key")
                    .bold()
                Spacer()
                Text(user?.rmsConfig.apiKey ?? "your api key here!!!").accessibilityLabel(user?.rmsConfig.apiKey ?? "your api key here!!!")
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("root url:")
                    .bold()
                    .accessibilityLabel("root url")
                    
                Spacer()
                Text(user?.rmsConfig.rootURL ?? "your root url here: HOLDER")
                    .accessibilityLabel(user?.rmsConfig.rootURL ?? "your root url here: HOLDER")
                    .accessibilityAddTraits(.isLink)
            }
           
            .padding(.vertical, 5)
        }
        .padding()
    }
}
