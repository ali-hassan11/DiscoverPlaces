//
//  PlaceDetailResult.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

//Check if permamntly closed exsits, if if does, make a nice error screen

struct PlaceDetailResponse: Decodable {
    let result: PlaceResult
    let status: String
}
