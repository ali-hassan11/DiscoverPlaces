//
//  UrlBuilder.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation

class UrlBuilder {
    
    static func buildImageUrl(with photoRef: String) -> URL? { //Width, Height?
        let urlStr = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(1000)&photoreference=\(photoRef)&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        
        guard let url = URL(string: urlStr) else { return nil }
        
        return url
    }
    
}
