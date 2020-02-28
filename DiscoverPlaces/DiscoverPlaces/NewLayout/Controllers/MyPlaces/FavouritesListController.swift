//
//  FavouritesController.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class FavouritesListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var placeIdList: [String]?
    
    let defaults = DefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        refreshData()
        collectionView.register(MyPlaceCell.self, forCellWithReuseIdentifier: MyPlaceCell.id)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        refreshData()
//    }
    
    func refreshData() {
        placeIdList = defaults.getList(listKey: .favourites)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeIdList?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaceCell.id, for: indexPath) as! MyPlaceCell
        cell.listType = .favourites
        cell.placeId = placeIdList?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = PlaceDetailsController()
        detailsController.placeId = placeIdList?[indexPath.item]
        present(detailsController, animated: true, completion: nil)//Change to push
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 16 - 16, height: 100)
    }
    
}
