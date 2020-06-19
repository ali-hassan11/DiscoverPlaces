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
    case Transport
    case Family
    case Attractions
    
    func subCategories() -> [SubCategory] {
        
        switch self {
        case .Food: return [.restaurant, .cafe, .meal_delivery, .meal_takeaway]
        case .Cafe: return [.cafe]
        case .Shopping: return [.shopping_mall, .department_store, .clothing_store, .jewelry_store, .convenience_store]
        case .Nature: return [.zoo, .aquarium, .florist, .park]
        case .Active: return [.gym, .physiotherapist, .park]
        case .Religion: return [.mosque, .synagogue, .church]
        case .Beauty: return [.spa, .beauty_salon, .hair_care]
        case .Health: return [.hospital, .pharmacy, .dentist, .spa]
        case .Hotel: return [.lodging]
        case .Transport: return [.airport, .train_station, .light_rail_station, .subway_station, .taxi_stand, .bus_station, .car_rental]
        case .Family: return [.amusement_park, .zoo, .park, .bowling_alley, .aquarium]
        case .Attractions: return [.tourist_attraction]
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
    case aquarium
    case zoo
    case florist
    case park
    case gym
    case bowling_alley
    case bicycle_store
    case mosque
    case synagogue
    case church
    case spa
    case beauty_salon
    case hair_care
    case airport
    case train_station
    case light_rail_station
    case subway_station
    case bus_station
    case taxi_stand
    case car_rental
    case amusement_park
    case tourist_attraction
    case lodging
    case bus
    case pharmacy
    case physiotherapist
    case hospital
    case doctor
    case dentist
    case drugstore
        
    func name() -> String {
        
        switch self {
        case .restaurant: return "Restaurant"
        case .cafe: return "Cafe"
        case .meal_delivery: return "Delivery"
        case .meal_takeaway: return "Takeaway"
        case .shopping_mall: return "Malls"
        case .jewelry_store: return "Jewellry"
        case .department_store: return "Department"
        case .clothing_store: return "Clothing"
        case .convenience_store: return "Convenience"
        case .aquarium: return "Aquarium"
        case .zoo: return "Zoo"
        case .florist: return "Florist"
        case .park: return "Park"
        case .gym: return "Gym"
        case .bowling_alley: return "Bowling"
        case .bicycle_store: return "Cycling"
        case .mosque: return "Mosque"
        case .synagogue: return "Synagogue"
        case .church: return "Church"
        case .spa: return "Spa"
        case .beauty_salon: return "Beauty Salon"
        case .hair_care: return "Hair"
        case .airport: return "Airport"
        case .train_station: return "Train"
        case .light_rail_station: return "Light Rail"
        case .subway_station: return "Subway"
        case .bus_station: return "Bus"
        case .taxi_stand: return "Taxi"
        case .car_rental: return "Car Rental"
        case .bus: return "Bus"
        case .amusement_park: return "Amusement Park"
        case .tourist_attraction: return "Tourist Attractions"
        case .lodging: return "Place to Stay"
        case .pharmacy:  return "Pharmacy"
        case .physiotherapist: return "Fitness"
        case .hospital: return "Hospital"
        case .doctor: return "Doctor"
        case .dentist: return "Dentist"
        case .drugstore: return "Drug Store"
        }
    }
    
}
