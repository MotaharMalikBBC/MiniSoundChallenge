//
//  NetworkAPI.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 06/09/2024.
//

import Foundation

struct ApiModel: Codable {
        let status: Status
        let rmsConfig: RMSConfig
}

struct Status: Codable {
    let isOn: Bool
    let title, message, linkTitle: String
    let appStoreURL: String

    enum CodingKeys: String, CodingKey {
        case isOn, title, message, linkTitle
        case appStoreURL = "appStoreUrl"
    }
}

struct RMSConfig: Codable {
    let apiKey: String
    let rootURL: String
    
    enum CodingKeys: String, CodingKey {
            case apiKey
            case rootURL = "rootUrl"
           
        }
    
}
