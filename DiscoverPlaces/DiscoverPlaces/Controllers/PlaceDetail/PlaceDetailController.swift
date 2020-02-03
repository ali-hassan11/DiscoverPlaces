//
//  PlaceDetailController.swift
//  DiscoverPlaces
//
//  Created by user on 29/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailController: UIViewController {
    
    var result: Result? { //Or just id to do fetch
        didSet {
            //Fetch Data & Populate cells
            navigationItem.title = result?.name
        }
    }
        
//    let placeImageController = PlaceImageController()
//    let placeInfoController = PlaceInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(placeImageController.view)
//        placeImageController.view.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
//        placeImageController.view.constrainHeight(constant: Constants.placeImageControllerHeight)
//
//        view.addSubview(placeInfoController.view)
//        placeInfoController.view.fillSuperview()
    }
}
