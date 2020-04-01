//
//  SubCategoryHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SmallSquarePlacesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let searchResponseFilter = SearchResponseFilter()
    
    var location: Location?
    
    var subCateegoryGroup: SubCategoryGroup? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectPlaceInCategoriesHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SmallSquarePlaceCell.self, forCellWithReuseIdentifier: SmallSquarePlaceCell.id)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    
//}
//
//extension SmallSquarePlacesHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCateegoryGroup?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallSquarePlaceCell.id, for: indexPath) as! SmallSquarePlaceCell
        cell.place = subCateegoryGroup?.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(String(describing: subCateegoryGroup?.results[indexPath.item].name))")
        guard let placeId = subCateegoryGroup?.results[indexPath.item].place_id else { return }
        didSelectPlaceInCategoriesHandler?(placeId)
    }
}
