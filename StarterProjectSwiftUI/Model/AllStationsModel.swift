//
//  AllStationsModel.swift
//  StarterProjectSwiftUI
//
//  Created by Malik Motahar - Sounds Mobile 1 on 12/09/2024.
//

import Foundation

// Top-level ExperienceResponse model
struct RMSEndpoint: Codable {
    let data: [InlineDisplayModule]
}

// InlineDisplayModule model for each station block
struct InlineDisplayModule: Codable {
    let type: String
    let id: String
    let style: String?
    let title: String
    let description: String?
    let state: String
    let uris: [String]?
    let controls: [String]?
    let total: Int?
    let data: [PlayableItem]
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case type, id, style, title, description, state, uris, controls, total, data
        case imageUrl = "image_url"
    }
}

// PlayableItem model for individual radio stations
struct PlayableItem: Codable {
    let type: String
    let id: String
    let urn: String
    let network: Network
    let titles: Titles
    let synopses: Synopses
    let imageUrl: String?
    let duration: Duration
    let progress: Progress
    let container: String?
    let download: String?
    let availability: Availability
    let release: Release
    let guidance: String?
    let activities: [String]?
    let uris: [String]?
    let playContext: String?
    let recommendation: String?
    

    enum CodingKeys: String, CodingKey {
        case type, id, urn, network, titles, synopses
        case imageUrl = "image_url"
        case duration, progress, container, download, availability, release, guidance, activities, uris
        case playContext = "play_context"
        case recommendation
    }
}

// Network model inside each playable item
struct Network: Codable {
    let id: String
    let key: String
    let shortTitle: String?
    let logoUrl: String?
    let networkType: String?

    enum CodingKeys: String, CodingKey {
        case id, key
        case shortTitle = "short_title"
        case logoUrl = "logo_url"
        case networkType = "network_type"
    }
}

// Titles model inside each playable item
struct Titles: Codable {
    let primary: String
    let secondary: String
    let tertiary: String
    let entityTitle: String?

    enum CodingKeys: String, CodingKey {
        case primary, secondary, tertiary
        case entityTitle = "entity_title"
    }
}

// Synopses model inside each playable item
struct Synopses: Codable {
    let short: String
    let medium: String?
    let long: String?
}

// Duration model inside each playable item
struct Duration: Codable {
    let value: Int
    let label: String
}

// Progress model inside each playable item
struct Progress: Codable {
    let value: Int
    let label: String
}

// Availability model inside each playable item
struct Availability: Codable {
    let from: String?
    let to: String?
    let label: String
}

// Release model inside each playable item
struct Release: Codable {
    let date: String?
    let label: String?
}
