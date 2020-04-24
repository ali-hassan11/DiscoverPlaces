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
    static let key = "AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
    
    //Sizes
    static let placeImageControllerHeight: CGFloat = 200
    static let nearbyHeaderCellHeight: CGFloat = 220
    static let discoverGroupSectionHeight: CGFloat = 160

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
