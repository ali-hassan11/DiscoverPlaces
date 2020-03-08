//
//  FavouritesController.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class FavouritesListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var didSelectHandler: ((String) -> ())?

    var placeIdList: [String]? {
        didSet {
            if placeIdList != oldValue {
                fetchDataForPlaceIds()
            }
        }
    }
    
    var placeResults: [PlaceDetailResult]?
    
    let defaults = DefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        refreshData()
        collectionView.register(MyPlaceCell.self, forCellWithReuseIdentifier: MyPlaceCell.id)
    }
    
    func refreshData() {
        placeIdList = DefaultsManager.getList(listKey: .favourites)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeResults?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaceCell.id, for: indexPath) as! MyPlaceCell
        cell.listType = .favourites
        cell.place = placeResults?[indexPath.item]
        return cell
    }
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeId = placeResults?[indexPath.item].place_id else { return }
        didSelectHandler?(placeId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 16 - 16, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func fetchDataForPlaceIds() {
        self.placeResults?.removeAll()
        placeIdList?.forEach({ (id) in
            fetchData(for: id)
        })
    }
    
    func fetchData(for id: String) {
        
        let fields = ["name", "vicinity", "rating", "place_id", "photos"]
        Service.shared.fetchPlaceDetails(placeId: id, fields: fields) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                return
            }
            
            //success
            guard let placeResponse = response else { return }
            guard let result = placeResponse.result else { return }
            
            if self.placeResults != nil {
                self.placeResults?.append(result)
            } else {
                self.placeResults = [result]
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension FavouritesListController: MyPlaceCellDelegate {
    
    func togglePlaceInList(cell: MyPlaceCell) {
        // // // // // -- -- -- -- -- DELEGATE METHOD NOT BEING CALLED??? -- -- -- -- -- // // // // //
        guard let placeIds = placeIdList else { return }
        if placeIds.contains(cell.place!.place_id) {
            placeIdList = placeIdList?.filter { $0 != cell.place!.place_id }
            collectionView.reloadData()
        }
    }
}
