//
//  SearchResults.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

struct Response: Decodable {
    let results: [PlaceResult]
    let status: String?

    enum CodingKeys: String, CodingKey {
        case results
        case status
    }
}

struct PlaceResult: Decodable {
    let geometry: Geometry?
    let icon: String? //Probably won't need this
    let id: String?
    let name: String?
    let photos: [Photo]?
    let placeID: String?
    let types: [String]?
    let vicinity: String? //USE THIS IN DETAIL CELL
    let rating: Double?

    let userRatingsTotal: Int?
    let openingHours: OpeningHours?
    let formattedAddress: String?
    let formattedPhoneNumber: String?
    let reviews: [Review]?
    let website: String?

    enum CodingKeys: String, CodingKey {
        case geometry
        case icon
        case id
        case name
        case openingHours = "opening_hours"
        case photos
        case placeID = "place_id"
        case rating,types
        case userRatingsTotal = "user_ratings_total"
        case vicinity

        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case reviews = "reviews"
        case website = "website"

    }
}

struct Geometry: Decodable {
    let location: Location?
}

struct Location: Decodable {
    let lat: Double?
    let lng: Double?
}

struct OpeningHours: Codable {
    let openNow: Bool
    let weekdayText: [String]

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case weekdayText = "weekday_text"
    }
}

struct Photo: Decodable {
    let height: Int?
    let photoReference: String?
    let width: Int?
    //HTML Attrs?

    enum CodingKeys: String, CodingKey {
        case height
        case photoReference = "photo_reference"
        case width
    }
}

struct Review: Codable {
    let authorName: String
    let authorURL: String
    let language: String
    let profilePhotoURL: String
    let rating: Int
    let relativeTimeDescription: String
    let text: String
    let time: Int

    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case authorURL = "author_url"
        case language = "language"
        case profilePhotoURL = "profile_photo_url"
        case rating = "rating"
        case relativeTimeDescription = "relative_time_description"
        case text = "text"
        case time = "time"
    }
}

extension PlaceResult {
    func containsPhotos() -> Bool {
        if photos != nil && photos?.first != nil {
            return true
        } else {
            return false
        }
    }
}
