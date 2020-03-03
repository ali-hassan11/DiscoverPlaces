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

class DefaultsManager {
    
    func addToList(placeId: String, listKey: ListType) {
        //CAN MAKE THIS ALOT SIMPLE: LOOK AT ADD TO CATEGORIES
        if var favourites = UserDefaults.standard.object(forKey: listKey.rawValue) as? [String] {
            if !favourites.contains(placeId) {
                favourites.append(placeId)
                UserDefaults.standard.set(favourites, forKey: listKey.rawValue)
            }
        } else {
            let newFavourites = [placeId]
            UserDefaults.standard.set(newFavourites, forKey: listKey.rawValue)
        }
    }
    
    func removeFromList(placeId: String, listKey: ListType) {
        //CAN MAKE THIS ALOT SIMPLE: LOOK AT ADD TO CATEGORIES
        if var favourites = UserDefaults.standard.object(forKey: listKey.rawValue) as? [String] {
            if favourites.contains(placeId) {
                favourites = favourites.filter{$0 != placeId}
                UserDefaults.standard.set(favourites, forKey: listKey.rawValue)
            }
        }
    }
    
    func getList(listKey: ListType) -> [String] {
        if let favourites = UserDefaults.standard.object(forKey: listKey.rawValue) as? [String] {
            return favourites
        } else {
            return []
        }
    }
    
    func isInList(placeId: String, listKey: ListType) -> Bool {
        if let favourites = UserDefaults.standard.object(forKey: listKey.rawValue) as? [String] {
            if favourites.contains(placeId) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}

