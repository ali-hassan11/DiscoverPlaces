//
//  DefaultsManager.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DefaultsManager {
    
    private static let defaults = UserDefaults.standard
    
    // MARK: - Add
    static func addToList(placeId: String, listKey: ListType) {
        
        var decodedList = getList(listKey: listKey)
        
        decodedList.append(PlaceListItem(placeId: placeId, timestamp: Int(Date().timeIntervalSince1970)))
        save(list: decodedList, key: listKey.rawValue)
    }
    
    // MARK: - Remove
    static func removeFromList(placeId: String, listKey: ListType) {
        
        var decodedList = getList(listKey: listKey)
        
        var placeIdToRemove: String?
        for place in decodedList {
            if place.placeId == placeId {
                placeIdToRemove = place.placeId
            }
        }
        
        decodedList = decodedList.filter{$0.placeId != placeIdToRemove}
        save(list: decodedList, key: listKey.rawValue)
    }
    
    // MARK: - Is in list
    static func isInList(placeId: String, listKey: ListType) -> Bool {
        
        let list = getList(listKey: listKey)
        
        guard list.count > 0 else  { return false }
        
        var isInList = false
        for place in list {
            if place.placeId == placeId {
                isInList = true
                break
            }
        }
        return isInList
    }
    
    // MARK: - Get
    static func getList(listKey: ListType) -> [PlaceListItem] {
        if let data = defaults.data(forKey: listKey.rawValue) {
            return listFromDecoded(data: data)
        } else {
            return []
        }
    }
    
    
    // MARK: - Helpers
    private static func save(list: [PlaceListItem], key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(list)
            
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Unable to encode Location list")
        }
    }
    
    private static func listFromDecoded(data: Data) -> [PlaceListItem] {
        do {
            let decoder = JSONDecoder()
            let decodedList = try decoder.decode([PlaceListItem].self, from: data)
            return decodedList
        } catch {
            print("Unable to decode list")
            return []
        }
    }
    
    //MARK: Units
    enum Unit {
        case km
        case miles
    }
    
    private static let isKmKey = "isKmKey"
    
    static func isKm() -> Bool {
        if let isKm = defaults.object(forKey: isKmKey) as? Bool {
            return isKm
        } else {
            return true
        }
    }
    
    static func setUnits(to unit: Unit) {
        defaults.set(unit == .km ? true : false, forKey: isKmKey)
    }
}
