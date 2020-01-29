//
//  PlaceDetailController.swift
//  DiscoverPlaces
//
//  Created by user on 29/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class placeDetailController: BaseCollectionViewController {
    
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .red
        
        let lbl = UILabel()
        lbl.text = name
        view.addSubview(lbl)
        lbl.centerInSuperview()
    }
    
}
