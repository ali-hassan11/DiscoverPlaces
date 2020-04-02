//
//  SubCategoryHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceGroupHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let searchResponseFilter = SearchResponseFilter()
    
    var location: Location?
    
    var placeGroup: PlacesGroup? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectPlaceInCategoriesHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SmallPlaceCell.self, forCellWithReuseIdentifier: SmallPlaceCell.id)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    
}

extension PlaceGroupHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeGroup?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPlaceCell.id, for: indexPath) as! SmallPlaceCell
        cell.configure(place: placeGroup?.results[indexPath.item], userLocation: self.location)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeId = placeGroup?.results[indexPath.item].place_id else { return }
        didSelectPlaceInCategoriesHandler?(placeId)
    }
}
