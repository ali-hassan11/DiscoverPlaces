//
//  UserLocation.swift
//  DiscoverPlaces
//
//  Created by user on 01/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

class UserLoation {
    
    static func lastSavedLocation() -> LocationItem {
        if let data = UserDefaults.standard.data(forKey: "LocationKey") {
            do {
                let decoder = JSONDecoder()
                let lastSavedLocation = try decoder.decode(LocationItem.self, from: data)
                return lastSavedLocation
            } catch {
                return LocationItem(name: "Dubai", selectedLocation:Location(lat: 25.1412, lng: 55.1852), actualUserLocation: nil) //Decide on a Default location (Currently Dubai)
            }
        } else {
            return LocationItem(name: "Dubai", selectedLocation:Location(lat: 25.1412, lng: 55.1852), actualUserLocation: nil) //Decide on a Default location (Currently Dubai)
        }
    }
    
    //func SaveLocation() {
    //}
    
}
