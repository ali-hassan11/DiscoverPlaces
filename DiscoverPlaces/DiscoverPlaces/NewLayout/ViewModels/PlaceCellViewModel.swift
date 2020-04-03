//
//  PlaceCellViewModel.swift
//  DiscoverPlaces
//
//  Created by user on 02/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

class PlaceCellViewModel {
    
    public let placeName: String?
    public let address: String?
    public let imageURL: URL?
    public let rating: Double?
    
    init(place: PlaceResult) {
        self.placeName = PlaceCellViewModel.placeName(with: place.name)
        self.address = PlaceCellViewModel.address(with: place)
        self.imageURL = PlaceCellViewModel.imageURL(for: place.photos?.first)
        self.rating = PlaceCellViewModel.rating(for: place.rating)
    }
    
    static func placeName(with name: String?) -> String? {
        guard let name = name else { return nil }
        return name
    }
    
    static func address(with place: PlaceResult) -> String? {
        if let vicinity = place.vicinity {
            return vicinity
        } else if let address = place.formatted_address {
            return address
        } else if let name = place.name {
            return name
        }
        return nil
    }
    
    static func imageURL(for photo: Photo?) -> URL? {
        guard let photo = photo else { return nil }
        guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else { return nil }
        return url
    }
    
    static func rating(for rating: Double?) -> Double? {
        return rating ?? nil
    }
}
