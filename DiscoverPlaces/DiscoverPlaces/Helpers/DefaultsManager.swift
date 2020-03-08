//
//  DefaultsManager.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

// // // ------------------- LOOK MORE INTO THIS ------------------- // // //
class ListObject: NSObject, NSCoding {
    
    let timeStamp: Int
    let placeId: String
    
    init(timeStamp: Int, placeId: String) {
           self.timeStamp = timeStamp
           self.placeId = placeId
       }
    
    func encode(with coder: NSCoder) {
        coder.encode(timeStamp, forKey: "timeStamp")
        coder.encode(placeId, forKey: "placeId")
    }
    
    required convenience init?(coder: NSCoder) {
        let timeStamp = coder.decodeInteger(forKey: "timeStamp")
        let placeId = coder.decodeObject(forKey: "placeId") as! String
        self.init(timeStamp: timeStamp, placeId: placeId)
    }
}
// // // ------------------- LOOK MORE INTO THIS ------------------- // // //


// MARK: Lists
class DefaultsManager {
    
    private static let defaults = UserDefaults.standard
    
    static func addToList(placeId: String, listKey: ListType) {
        if var favourites = defaults.object(forKey: listKey.rawValue) as? [String] {
            if !favourites.contains(placeId) {
                favourites.append(placeId)
                defaults.set(favourites, forKey: listKey.rawValue)
            }
        } else {
            let newFavourites = [placeId]
            defaults.set(newFavourites, forKey: listKey.rawValue)
        }
    }
    
    static func removeFromList(placeId: String, listKey: ListType) {
        if var favourites = defaults.object(forKey: listKey.rawValue) as? [String] {
            if favourites.contains(placeId) {
                favourites = favourites.filter{$0 != placeId}
                defaults.set(favourites, forKey: listKey.rawValue)
            }
        }
    }
    
    static func getList(listKey: ListType) -> [String] {
        if let favourites = defaults.object(forKey: listKey.rawValue) as? [String] {
            return favourites
        } else {
            return []
        }
    }
    
    static func isInList(placeId: String, listKey: ListType) -> Bool {
        if let favourites = defaults.object(forKey: listKey.rawValue) as? [String] {
            if favourites.contains(placeId) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    //MARK: Units
    
    static func isKm() -> Bool {
        if let isKm = defaults.object(forKey: "isKmKey") as? Bool {
            return isKm
        } else {
            return true
        }
    }
}

