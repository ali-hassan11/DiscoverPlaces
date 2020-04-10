//
//  FavouritesController.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var didSelectPlaceInListHandler: ((String, Location) -> ())?  //Don't think location this is used

    var listType: ListType?
    
    var placeIdList: [String]? {
        didSet {
            if placeIdList != oldValue {
                fetchDataForPlaceIds()
            }
        }
    }
    
    var placeResults = [PlaceDetailResult]()
    
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
        return placeResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaceCell.id, for: indexPath) as! MyPlaceCell
        cell.configure(place: placeResults[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = placeResults[indexPath.item]
        guard let location = place.geometry?.location else { return }
        didSelectPlaceInListHandler?(place.place_id, location) //Don't think location this is used
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let dispatchGroup = DispatchGroup()
    
    func fetchDataForPlaceIds() {
        self.placeResults.removeAll()
        
        print("🟩 PlaceId List Count: \(placeIdList!.count)")
        placeIdList?.forEach{ _ in dispatchGroup.enter() }
        
        placeIdList?.forEach({ (id) in
            fetchData(for: id)
        })
        
        dispatchGroup.notify(queue: .main) {
            print("🟩 PlaceId Results Count: \(self.placeResults.count)")
            self.placeResults.forEach{print($0.name!) ; print($0.rating ?? "Rating = nil") ; print($0.place_id)}
        }
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
            
            self.placeResults.append(result)
            
            self.dispatchGroup.leave()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
