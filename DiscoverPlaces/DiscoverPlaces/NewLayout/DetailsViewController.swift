//
//  DetailsViewController.swift
//  DiscoverPlaces
//
//  Created by user on 06/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var place: Result?
    
    var placeId: String! {
        didSet {
 
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .red
        
    }
    
}
