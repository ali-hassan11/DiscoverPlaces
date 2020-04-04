//
//  FavouritesController.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var didSelectPlaceInListHandler: ((String, Location) -> ())?

    var listType: ListType?
    
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
        guard let listType = listType else { return }
        placeIdList = DefaultsManager.getList(listKey: listType)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeResults?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaceCell.id, for: indexPath) as! MyPlaceCell
        cell.configure(place: placeResults?[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let place = placeResults?[indexPath.item] else { return }
        guard let location = place.geometry?.location else { return }
        didSelectPlaceInListHandler?(place.place_id, location)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
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
        
        let fields = ["name", "vicinity", "rating", "place_id", "photos", "geometry"]
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
