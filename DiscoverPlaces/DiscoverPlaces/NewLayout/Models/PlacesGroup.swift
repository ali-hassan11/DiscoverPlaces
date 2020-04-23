//
//  PlacesGroup.swift
//  DiscoverPlaces
//
//  Created by user on 23/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

struct PlacesGroup {
    let title: String?
    let results: [PlaceResult]
    
    init(title: String? = nil, results: [PlaceResult]?) {
        self.title = title
        self.results = results ?? []
    }
}
