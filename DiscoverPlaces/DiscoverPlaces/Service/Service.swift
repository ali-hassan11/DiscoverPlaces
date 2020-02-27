//
//  Service.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

//func buildsearchUrl(searchText)

class Service {
    
    static let shared = Service() //singleton
    
    /* https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=(searchText)&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg */
    
    //Change to findplacefromtext and only get data you need for cells.
    func fetchSearchResults(for searchText: String, completion: @escaping (SearchResponse?, Error?) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchText)&location=\(25.1413),\(55.1853)&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchPlacesForCategory(for category: String, completion: @escaping (SearchResponse?, Error?) -> Void) { //Make category some sort of enum...
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=\(category)&keyword=cruise&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchNearbyPlaces(completion: @escaping (SearchResponse?, Error?) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=25.1988,55.2796&radius=5000&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        //Show touristy places
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchPlaceDetails(placeId: String, completion: @escaping (PlaceDetailResult?, Error?) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, repsonse, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            //success
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch let jsonErr {
                completion(nil, jsonErr)
            }
            
        }.resume()
    }
}
