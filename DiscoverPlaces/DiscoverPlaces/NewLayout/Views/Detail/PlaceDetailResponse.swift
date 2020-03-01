//
//  PlaceDetailResult.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

struct PlaceDetailResponse: Decodable {
    let result: PlaceDetailResult?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case status = "status"
    }
}

struct PlaceDetailResult: Decodable {
    let place_id: String
    let name: String?
    let user_Ratings_Total: Int?
    let opening_hours: OpeningHours?
    let formatted_Address: String?
    let formatted_Phone_Number: String?
    let reviews: [Review]?
    let website: String?
    let url: String?
    let photos: [Photo]?
    let rating: Double?
    let types: [String]?
    let geometry: Geometry?
    let vicinity: String?
}

