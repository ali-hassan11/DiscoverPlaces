//
//  DiscoverController.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DiscoverController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let selectedCellId = "selectedId"
    fileprivate let nearbyCellId = "headerId"
    fileprivate let cellId = "cellId"
    
    var categories: [Categoryy]! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = getCategories()
        
        collectionView.backgroundColor = .white
        //Header step 1
        collectionView.register(NearbyHolder.self, forCellWithReuseIdentifier: nearbyCellId)
        collectionView.register(DiscoverCardsHolder.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SelectedCategoriesHolder.self, forCellWithReuseIdentifier: selectedCellId)
    }
    
    func getCategories() -> [Categoryy] {
        
        //Get fron user defaults
        let cats = [Categoryy(name: "amusement_park", isSelected: true),
                    Categoryy(name: "museum", isSelected: true),
                    Categoryy(name: "mosque", isSelected: true),
                    Categoryy(name: "clothing_store", isSelected: true),
                    Categoryy(name: "tourist_attraction", isSelected: true)
        ]
        
        return cats
    }
}

extension DiscoverController {
  
    //Delegate & DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count + 2 //(The 2 is the categories selector + nearby controller)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            //Categories Selector
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectedCellId, for: indexPath) as! SelectedCategoriesHolder
            cell.horizontalController.categories = categories
            return cell
        case 1:
            //Nearby header
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearbyCellId, for: indexPath) as! NearbyHolder
                return cell
        default:
            //Category results
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiscoverCardsHolder
            cell.sectionTitle.text = categories[indexPath.item - 2].name
            cell.horizontalController.category = categories[indexPath.item - 2].name
            return cell
        }
    }
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            //Categories Selector
            return .init(width: view.frame.width, height: 60)
        case 1:
            //Nearby header
            return .init(width: view.frame.width, height: 220)
        default:
            //Category results
            return .init(width: view.frame.width, height: 160)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
