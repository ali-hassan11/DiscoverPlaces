//
//  SubCategoryHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class PlaceGroupHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let searchResponseFilter = SearchResponseFilter()
    
    var location: Location?
    
    var results: [PlaceResult]? {
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
        collectionView.contentInset = .init(top: 0, left: Constants.sidePadding, bottom: 0, right: Constants.sidePadding)
    }
    
}

extension PlaceGroupHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPlaceCell.id, for: indexPath) as! SmallPlaceCell
        cell.configure(place: results?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeId = results?[indexPath.item].place_id else { return }
        didSelectPlaceInCategoriesHandler?(placeId)
    }
}
