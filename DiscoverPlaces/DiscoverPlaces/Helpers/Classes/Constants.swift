//
//  Constants.swift
//  DiscoverPlaces
//
//  Created by user on 23/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    //Keys
    static let nearestPageKey = "nearestPageKey"
    static let placeSearchBarTextKey = "placeSearchBarTextKey"
    static let locationKey = "LocationKey"
 
    //Strings
    static let okText = "Ok"
    static let backtext = "Back"
    static let retryText = "Retry"
    static let genericNoConnectionMessage = "There was a problem loading this page. Please check your internet connection and try again."
    static let noInternetForLocatingMessage = "There was a problem finding your location. Please check your internet connection and make sure your location services are enabled."
    static let noInternetConnectionTitle = "No Internet Connection"
    static let noInternetConnetionMessage = "Please check your internet connection and try again."
    static let locationServicesDisabledTitle = "Unable To Locate"
    static let locationServicesDisabledMessage = "Please make sure that location services are turned on in your device settings."
    static let noResultsTitle = "No Results"
    static let noResultsMessage = "There are no results for your chosen location. Try again later or choose a different location."
    static let tryDifferentLocationtext = "Try a different location"
    static func noResults(_ category: String) -> String {
        return "There are no results for \(category) in your chosen location, please try a different category."
    }
    
    //API
    static let googlePlacesAPIkey = "AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
    static let placeDetailFields = ["name" , "place_id", "opening_hours", "photo", "vicinity" ,"geometry" ,"review" ,"website" ,"url" ,"international_phone_number", "formatted_phone_number" ,"formatted_address", "rating"]
    
    
    //Cells
    static let errorCellId = "errorCell"
    static let bottomPaddingCellId = "bottomPaddingCellId"
    
    //Sizes
    static let placeImageControllerHeight: CGFloat = 200
    static let nearbyHeaderCellHeight: CGFloat = 220
    static let discoverGroupSectionHeight: CGFloat = 160
    
    static let googleFooterHeight: CGFloat = 45
    
    //Padding
    static let topPadding: CGFloat = 0
    static let bottomPadding: CGFloat = 0
    static let leftPadding: CGFloat = 20
    static let rightPadding: CGFloat = 20
    static let sidePadding: CGFloat = 16
}
