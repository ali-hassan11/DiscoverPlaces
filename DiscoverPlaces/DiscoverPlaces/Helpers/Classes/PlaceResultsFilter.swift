//
//  PlaceResultsFilter.swift
//  DiscoverPlaces
//
//  Created by user on 31/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

class SearchResponseFilter {
    
    public func results(from response: SearchResponse) -> [PlaceResult] {
        
        var filteredResults = [PlaceResult]()
        
        response.results.forEach({ result in
            if result.containsPhotos() && result.containsDesiredTypes() {
                filteredResults.append(result)
            }
        })
        
        return filteredResults
    }
    
    public func morePlacesResults(from results: [PlaceResult]) -> [PlaceResult] {
        
        var filteredResults = [PlaceResult]()
        
        results.forEach({ result in
            if result.containsPhotos() && result.containsDesiredTypes() {
                var result = result
                result.rating = nil // TODO: - This is just a temporary fix! shouldn't make rating mutable!

                filteredResults.append(result)
            }
        })
        
        return filteredResults
    }
}
