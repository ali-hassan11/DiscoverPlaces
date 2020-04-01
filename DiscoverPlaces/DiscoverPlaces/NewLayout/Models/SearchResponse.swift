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
    let vicinity: String?
    let formatted_address: String?

    enum CodingKeys: String, CodingKey {
        case geometry
        case icon
        case place_id
        case name
        case photos
        case rating
        case types
        case vicinity
        case formatted_address
    }
}

extension PlaceResult {
    func containsPhotos() -> Bool {
        return photos != nil && photos?.first != nil
    }
    
    // TODO: - Revisit this
    func containsDesiredTypes() -> Bool {
           return !(types?.contains("locality") ?? true) //City, town...
       }
}


struct Geometry: Decodable {
    let location: Location
}

import CoreLocation

extension Geometry {
    func distanceString(from userLocation: Location) -> String? {
//        guard userLocation.isNotEmpty() else { return nil }
        
        let fromLocation = CLLocation(latitude: location.lat, longitude: location.lng)
        let toLocation = CLLocation(latitude: userLocation.lat, longitude: userLocation.lng)
        let distance = fromLocation.distance(from: toLocation)
        return distance.inUnits()
    }

}

extension Double {
//Write tests for this
    func inUnits() -> String {
        if DefaultsManager.isKm() {
            return "\(inKm().rounded(toPlaces: 1)) Km"
        } else {
            return "\(inMiles().rounded(toPlaces: 1)) Miles"
        }
    }
    
    private func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    private func inKm() -> Double {
        return self / 1000
    }
    
    private func inMiles() -> Double {
        return self * 0.000621371
    }
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

//extension Location {
//    func isNotEmpty() -> Bool {
//        return lat == 0 && lng == 0
//    }
//}

struct OpeningHours: Decodable {
    let openNow: Bool?
    let weekdayText: [String]?

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case weekdayText = "weekday_text"
    }
}

struct Photo: Decodable {
    let height: Int
    let photoReference: String
    let width: Int
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
    let rating: Int
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
