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

    //API
    static let googlePlacesAPIkey = "AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
    static let placeDetailFields = ["name" , "place_id", "opening_hours", "photo", "vicinity" ,"geometry" ,"review" ,"website" ,"url" ,"international_phone_number", "formatted_phone_number" ,"formatted_address", "rating"]
        
    //Sizes
    static let placeImageControllerHeight: CGFloat = 200
    static let nearbyHeaderCellHeight: CGFloat = 220
    static let discoverGroupSectionHeight: CGFloat = 160
    
    static let googleFooterHeight: CGFloat = 45
    
    //Strings
    static let retry = "Retry"
    static let genericNoConnectionMessage = "There was a problem loading this page. Please check your internet connection and try again."
    static let noInternetConnectionTitle = "No Internet Connection"
    static let noInternetConnetionMessage = "Please check that you are connected to the internet"
    static let locationServicesDisabledTitle = "Unable To Locate"
    static let locationServicesDisabledMessage = "Please make sure that location services are turned on in your device settings"
    static let noResultsTitle = "No Results"
    static let noResultsMessage = "There are no results for your chosen location. Try again later or choose a different location."
    static let tryDifferentLocationtext = "Try a differnt location"

    //Color
    static let primaryHighlightColor = UIColor(displayP3Red: 255/255, green: 52/255, blue: 102/255, alpha: 1)
    
    //Padding
    static let topPadding: CGFloat = 0
    static let bottomPadding: CGFloat = 0
    static let leftPadding: CGFloat = 20
    static let rightPadding: CGFloat = 20
    static let sidePadding: CGFloat = 16
    
    //Cells
    static let errorCellId = "errorCellId"
    
    //
    static let imagePlaceHolder = "placeHolderImage"
}
