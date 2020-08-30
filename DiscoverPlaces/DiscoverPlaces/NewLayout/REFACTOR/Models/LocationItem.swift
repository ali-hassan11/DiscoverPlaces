//
//  LocationItem.swift
//  DiscoverPlaces
//
//  Created by user on 10/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

struct LocationItem: Codable {
    let name: String?
    let selectedLocation: Location
    let actualUserLocation: Location?
}
