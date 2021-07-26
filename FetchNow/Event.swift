import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let events: [Event]
}

// MARK: - Event
struct Event: Codable {
    let type: String
    let title: String
    let shortTitle: String
    let id: Int
    let dateTimeLocal: Date
    let venue: Venue
    let performers: [Performer]

    enum CodingKeys: String, CodingKey {
        case type, id, title
        case dateTimeLocal = "datetime_local"
        case shortTitle = "short_title"
        case venue, performers
    }
}

// MARK: - Performer
struct Performer: Codable {
    let type, name: String
    let image: String?
    let id: Int
    let images: PerformerImages
    let hasUpcomingEvents: Bool
    let primary: Bool?
    let imageAttribution: String?
    let url: String
    let score: Double
    let slug: String
    let homeVenueID: Int?
    let shortName: String
    let numUpcomingEvents: Int
    let imageLicense: String?
    let popularity: Int
    let homeTeam: Bool?
    let location: Location?
    let awayTeam: Bool?

    enum CodingKeys: String, CodingKey {
        case type, name, image, id, images
        case hasUpcomingEvents = "has_upcoming_events"
        case primary
        case imageAttribution = "image_attribution"
        case url, score, slug
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case imageLicense = "image_license"
        case popularity
        case homeTeam = "home_team"
        case location
        case awayTeam = "away_team"
    }
}

// MARK: - PerformerImages
struct PerformerImages: Codable {
    let huge: String
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double
}

// MARK: - Venue
struct Venue: Codable {
    let state, nameV2, postalCode, name: String
    let url: String
    let score: Double
    let location: Location
    let address: String
    let hasUpcomingEvents: Bool
    let numUpcomingEvents: Int
    let city, slug, extendedAddress: String
    let id, popularity: Int
    let metroCode, capacity: Int
    let displayLocation: String

    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, url, score, location, address
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case id, popularity
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}


