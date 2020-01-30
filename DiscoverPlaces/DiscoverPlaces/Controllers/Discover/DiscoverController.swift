//
//  DiscoverController.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DiscoverController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    
    let types = ["Restaurants", "Restaurants", "Restaurants"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(DiscoverGroupCell.self, forCellWithReuseIdentifier: cellId)
        //Header step 1
        collectionView.register(NearbyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
}

extension DiscoverController {
    
    //Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! NearbyHeader
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: Constants.nearbyHeaderCellHeight)
    }
    
    //Delegate & DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiscoverGroupCell
        cell.sectionTitle.text = types.first
        return cell
    }
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: Constants.discoverGroupSectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
}
