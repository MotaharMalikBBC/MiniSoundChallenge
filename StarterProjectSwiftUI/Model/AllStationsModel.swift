import Foundation
// Top-level ExperienceResponse model
struct RMSEndpoint: Decodable {
  let data: [InlineDisplayModule]
}
// InlineDisplayModule model for each station block
struct InlineDisplayModule: Decodable {
  let type: String
  let id: String
  let title: String
  let data: [PlayableItem]
  enum codingKeys: String, CodingKey {
    case type
    case id
    case title
    case data
  }
}
// PlayableItem model for individual radio stations
struct PlayableItem: Decodable {
  let type: TypeEnum
  let id, urn: String
  let network: Network
  let titles: Titles
  let synopses: Synopses
  let imageURL: String?
  let duration, progress: Duration
  let container, download: DecodableType?
  let availability: Availability
  let guidance: DecodableType?
  let activities, uris: [DecodableType]
  let playContext, recommendation: DecodableType?
  enum CodingKeys: String, CodingKey {
    case type, id, urn, network, titles, synopses
    case imageURL = "image_url"
    case duration, progress, container, download, availability, guidance, activities, uris
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
enum TypeEnum: String, Codable {
  case playableItem = "playable_item"
}
enum DecodableType: Decodable {
  case string(String)
  case int(Int)
  case double(Double)
  case bool(Bool)
  case null
  case unknown
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if container.decodeNil() {
      self = .null
    } else if let strignValue = try? container.decode(String.self) {
      self = .string(strignValue)
    } else if let intValue = try? container.decode(Int.self) {
      self = .int(intValue)
    } else if let doubleValue = try? container.decode(Double.self) {
      self = .double(doubleValue)
    } else if let boolValue = try? container.decode(Bool.self) {
      self = .bool(boolValue)
    } else {
      self = .unknown
    }
  }
}
