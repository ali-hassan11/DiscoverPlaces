//
//  SubCategoryHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SmallSquarePlacesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
        
    var didSelectPlaceInCategoriesHandler: ((String, String) -> ())?
    var location: Location?
    
    var places: [PlaceResult]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SmallSquarePlaceCell.self, forCellWithReuseIdentifier: SmallSquarePlaceCell.id)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallSquarePlaceCell.id, for: indexPath) as! SmallSquarePlaceCell
        if let location = location {
            let distanceString = places?[indexPath.item].geometry?.distanceString(from: location)
            cell.distanceLabel.text = distanceString
        }
        let place = places?[indexPath.item]
        cell.place = place
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeId = places?[indexPath.item].place_id, let name = places?[indexPath.item].name else { return }
        didSelectPlaceInCategoriesHandler?(placeId, name)
    }
    
}
