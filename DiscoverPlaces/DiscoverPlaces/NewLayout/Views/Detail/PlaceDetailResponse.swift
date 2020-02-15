//
//  PlaceDetailResult.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

struct PlaceDetailResponse: Decodable {
    let result: [PlaceDetailResult]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case status
    }
}

struct PlaceDetailResult: Decodable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
