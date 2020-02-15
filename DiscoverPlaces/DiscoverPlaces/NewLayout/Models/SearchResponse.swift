//
//  SearchResults.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

struct SearchResponse: Decodable {
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
    let place_id: String?
    let name: String?
    let photos: [Photo]?
    let types: [String]?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case geometry
        case icon
        case place_id
        case name
        case photos
        case rating
        case types
    }
}

struct Geometry: Decodable {
    let location: Location?
}

struct Location: Decodable {
    let lat: Double?
    let lng: Double?
}

struct OpeningHours: Decodable {
    let openNow: Bool?
    let weekdayText: [String]?

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

struct Review: Decodable {
    let authorName: String?
    let language: String?
    let profilePhotoURL: String?
    let rating: Int?
    let relativeTimeDescription: String?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case language = "language"
        case profilePhotoURL = "profile_photo_url"
        case rating = "rating"
        case relativeTimeDescription = "relative_time_description"
        case text = "text"
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
