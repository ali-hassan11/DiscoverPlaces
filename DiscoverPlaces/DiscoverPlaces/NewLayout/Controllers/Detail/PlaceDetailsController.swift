//
//  DetailsViewController.swift
//  DiscoverPlaces
//
//  Created by user on 06/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let placeImagesHolderId = "placeImagesHolderId"
    
    var place: Result?
    var numberOfImages = 0
    
    var placeId: String! {
        didSet {
            numberOfImages = 5
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        //Header 1
        collectionView.register(PlaceImagesHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: placeImagesHolderId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
    }
    
    //Header 2
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: placeImagesHolderId, for: indexPath) as! PlaceImagesHolder
        cell.pageControlView.numberOfPages = numberOfImages
        cell.horizontalController.didEndAccelerating = { index in //weak self?
            cell.pageControlView.currentPage = index
        }
        return cell
    }
    
    //Header 3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            return UICollectionViewCell()//Details
        case 1:
            return UICollectionViewCell()//Similar Places
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
}
