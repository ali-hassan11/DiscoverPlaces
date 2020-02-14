//
//  PlaceDetailResult.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

struct PlaceDetailResponse: Decodable {
    let result: [PlaceDetailResult] //Returns 1 Result right?
    let status: String
}

struct PlaceDetailResult: Decodable {
//    let icon: String? //Probably won't need this

//    let placeID: String?

    let geometry: Geometry?
    let name: String?
    let photos: [Photo]?
    let id: String?
    let types: [String]?
    let userRatingsTotal: Int?
    let openingHours: OpeningHours?
    let formattedAddress: String?
    let vicinity: String? //USE THIS IN DETAIL CELL
    let formattedPhoneNumber: String?
    let reviews: [Review]?
    let website: String?
    let rating: Double?


    enum CodingKeys: String, CodingKey {
        case geometry
//        case icon
        case id
        case name
        case openingHours = "opening_hours"
        case photos
//        case placeID = "place_id"
        case rating,types
        case userRatingsTotal = "user_ratings_total"
        case vicinity

        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case reviews = "reviews"
        case website = "website"

    }
    //Extra: Check if permamntly closed exsits, if if does, make a nice error screen

}
