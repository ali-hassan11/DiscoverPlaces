//
//  Categories+SubCategories.swift
//  DiscoverPlaces
//
//  Created by user on 10/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

enum Category: String {
    
    case Food
    case Cafe
    case Shopping
    case Nature
    case Active
    case Religion
    case Beauty
    case Health
    case Hotel
    
    func subCategories() -> [SubCategory] {
        switch self {
        case .Food: return [.restaurant, .cafe, .meal_delivery, .meal_takeaway]
        case .Cafe: return [.cafe]
        case .Shopping: return [.shopping_mall, .jewelry_store, .department_store, .clothing_store, .convenience_store]
        default: fatalError()
        }
    }
    
}

enum SubCategory: String {
    
    case restaurant
    case cafe
    case meal_delivery
    case meal_takeaway
    
    case shopping_mall
    case jewelry_store
    case department_store
    case clothing_store
    case convenience_store
    
    case notConfiguredYet //Remove this
    //case drugstore (In health)
    
    func formatted() -> String {
        switch self {
        //Food
        case .restaurant: return "Restaurants"
        case .cafe: return "Cafes"
        case .meal_delivery: return "Delivery"
        case .meal_takeaway: return "Takeaway"
        case .notConfiguredYet: return "notConfiguredYet"
            
        //Shopping
        case .shopping_mall: return "Malls"
        case .jewelry_store: return "Jewellry"
        case .department_store: return "Department Store"
        case .clothing_store: return "Clothing Stores"
        case .convenience_store: return "Convenience"
        }
    }
    
}
