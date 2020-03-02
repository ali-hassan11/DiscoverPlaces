//
//  MorePlacesHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MorePlacesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let morePlacesCellId = "morePlacesCellId"
    
    var didSelectHandler: ((String, String) -> ())?
    
    var morePlaces: [PlaceResult]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MorePlacesCell.self, forCellWithReuseIdentifier: morePlacesCellId)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return morePlaces?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: morePlacesCellId, for: indexPath) as! MorePlacesCell
        let place = morePlaces?[indexPath.item]
        cell.place = place
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeId = morePlaces?[indexPath.item].place_id, let name = morePlaces?[indexPath.item].name else { return }
        didSelectHandler?(placeId, name)
    }
}
