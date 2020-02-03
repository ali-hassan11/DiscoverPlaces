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
    
    let selectedCategories = ["Restaurants", "Restaurants", "Restaurants"] //Make enum or su'um
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        //Header step 1
        collectionView.register(NearbyHolder.self, forCellWithReuseIdentifier: nearbyCellId)
        collectionView.register(DiscoverCardsHolder.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SelectedCategoriesHolder.self, forCellWithReuseIdentifier: selectedCellId)
    }    
}

extension DiscoverController {
  
    //Delegate & DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCategories.count + 2 //(The 2 is the categories selector + nearby controller)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            //Categories Selector
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectedCellId, for: indexPath) as! SelectedCategoriesHolder
            return cell
        case 1:
            //Nearby header
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nearbyCellId, for: indexPath) as! NearbyHolder
                return cell
        default:
            //Category results
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiscoverCardsHolder
            cell.sectionTitle.text = selectedCategories.first
            return cell
        }
    }
    
    
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            //Categories Selector
            return .init(width: view.frame.width, height: 40)
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
