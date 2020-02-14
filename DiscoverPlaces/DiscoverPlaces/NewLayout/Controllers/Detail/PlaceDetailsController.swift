//
//  DetailsViewController.swift
//  DiscoverPlaces
//
//  Created by user on 06/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    //Move Ids to cells
    fileprivate let placeImagesHolderId = "placeImagesHolderId"
    fileprivate let addressCellId = "addressCellId"
    fileprivate let openingTimeCellId = "openingTimeCellId"
    fileprivate let phoneNumberCellId = "phoneNumberCellId"
    fileprivate let webAddressCellId = "webAddressCellId"

    fileprivate let morePlacesHolderId = "morePlacesHolderId"

    fileprivate let errorCellId = "errorCellId"
    
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


        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: addressCellId)
        collectionView.register(OpeningTimeCell.self, forCellWithReuseIdentifier: openingTimeCellId)
        collectionView.register(PhoneNumberCell.self, forCellWithReuseIdentifier: phoneNumberCellId)
        collectionView.register(WebAddressCell.self, forCellWithReuseIdentifier: webAddressCellId)

        //More Places
        collectionView.register(MorePlacesHolder.self, forCellWithReuseIdentifier: morePlacesHolderId)
        //Header 1
        collectionView.register(PlaceImagesHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: placeImagesHolderId)

        //Error
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: errorCellId)
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
            //Address
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addressCellId, for: indexPath) as! AddressCell
            return cell
        case 1:
            //Hours
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: openingTimeCellId, for: indexPath) as! OpeningTimeCell
            return cell
        case 2:
            //PhoneNumber
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: phoneNumberCellId, for: indexPath) as! PhoneNumberCell
            return cell
        case 3:
            //Website
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: webAddressCellId, for: indexPath) as! WebAddressCell
            return cell
        case 4:
            //More Places
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: morePlacesHolderId, for: indexPath) as! MorePlacesHolder
            return cell
        default:
            #if DEBUG
            fatalError("Too many cells in section")
            #else
            let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: errorCellId, for: indexPath)
            return errorCell
            #endif
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            //Address
            return .init(width: view.frame.width, height: 60)
        case 1:
            //Hours
            return .init(width: view.frame.width, height: 60)
        case 2:
            //PhoneNumber
            return .init(width: view.frame.width, height: 60)
        case 3:
            //Website
            return .init(width: view.frame.width, height: 60)
        case 4:
            //More Places
            return .init(width: view.frame.width, height: 220)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}
