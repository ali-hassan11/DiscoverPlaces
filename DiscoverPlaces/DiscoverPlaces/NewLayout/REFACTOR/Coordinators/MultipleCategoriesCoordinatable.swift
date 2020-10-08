//
//  MultipleCategoriesCoordinatable.swift
//  DiscoverPlaces
//
//  Created by user on 08/10/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

protocol MultipleCategoriesCoordinatable {
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushErrorController(message: String)
}
