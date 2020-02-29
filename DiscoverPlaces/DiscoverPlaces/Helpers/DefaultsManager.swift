//
//  DefaultsManager.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

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

