//
//  UserLocation.swift
//  DiscoverPlaces
//
//  Created by user on 01/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

class UserLocation {
    
    static func lastSavedLocation() -> Location {
        if let data = UserDefaults.standard.data(forKey: "Location") {
            do {
                let decoder = JSONDecoder()
                let lastSavedLocation = try decoder.decode(Location.self, from: data)
                return lastSavedLocation
            } catch {
                return Location(lat: 25.1412, lng: 55.1852) //Decide on a Default location (Currently Dubai)
            }
        } else {
            return Location(lat: 25.1412, lng: 55.1852) //Decide on a Default location (Currently Dubai)
        }
    }
    
    //SaveLocation
    
}
