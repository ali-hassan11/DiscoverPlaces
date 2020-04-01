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
    var placeGroups: [SubCategoryGroup]? {
        didSet {
     
        }
    }
    
    var didSelectPlaceInCategoriesHandler: ((String, String) -> ())?
    
    private var placeResults: [PlaceResult]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
        setupCollectionView()
    }

    private func fetchData(subCategory: SubCategory, location: Location) {
        Service.shared.fetchNearbyPlaces(location: location, subCategory: subCategory) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                return
            }
            
            guard let response = response else { return }
            self.placeResults = self.searchResponseFilter.results(from: response)
        }
    }

    private func getLocation() -> Location {
        if let location = self.location {
            return location
        } else {
            return Location(lat: 0, lng: 0) // Default/Last Saves
        }
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
        return placeResults?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallSquarePlaceCell.id, for: indexPath) as! SmallSquarePlaceCell
        cell.place = placeResults?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(String(describing: placeResults?[indexPath.item].name))")
    }
}
