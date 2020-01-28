//
//  SearchResults.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

// MARK: - Welcome
struct Response: Decodable {
    let results: [Result]
    let status: String?

    enum CodingKeys: String, CodingKey {
        case results, status
    }
}

// MARK: - Result
struct Result: Decodable {
    let geometry: Geometry?
    let icon: String?
    let id, name: String?
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let placeID: String?
    let priceLevel: Int?
    let rating: Double?
    let types: [String]?
    let userRatingsTotal: Int?
    let vicinity: String?

    enum CodingKeys: String, CodingKey {
        case geometry, icon, id, name
        case openingHours = "opening_hours"
        case photos
        case placeID = "place_id"
        case priceLevel = "price_level"
        case rating,types
        case userRatingsTotal = "user_ratings_total"
        case vicinity
    }
}

// MARK: - Geometry
struct Geometry: Decodable {
    let location: Location?
    let viewport: Viewport?
}

// MARK: - Location
struct Location: Decodable {
    let lat, lng: Double?
}

// MARK: - Viewport
struct Viewport: Decodable {
    let northeast, southwest: Location?
}

// MARK: - OpeningHours
struct OpeningHours: Decodable {
    let openNow: Bool?

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

// MARK: - Photo
struct Photo: Decodable {
    let height: Int?
    let photoReference: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case height
        case photoReference = "photo_reference"
        case width
    }
}

extension Result {
    func containsPhotos() -> Bool {
        if photos != nil && photos?.first != nil {
            return true
        } else {
            return false
        }
    }
}
