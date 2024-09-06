//
//  RMSConfigbox.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 06/09/2024.
//

import Foundation
import SwiftUI


struct RMSConfigBox: View {
    public var user: ApiModel?
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("API key:")
                    .bold()
                Spacer()
                Text(user?.rmsConfig.apiKey ?? "your api key here!!!")
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("root url:")
                    .bold()
                Spacer() 
                Text(user?.rmsConfig.rootURL ?? "your root url here: HOLDER")
            }
            .padding(.vertical, 5)
        }
        .padding()
    }
}
