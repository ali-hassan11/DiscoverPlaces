//
//  SubCategoryHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SmallSquarePlacesHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let searchResponseFilter = SearchResponseFilter()
    
    var subCategory: SubCategory?
    var location: Location?
    
    var didSelectPlaceInCategoriesHandler: ((String, String) -> ())?
    
    private var placeResults: [PlaceResult]?
    
    init(location: Location, subategory: SubCategory) {
        self.subCategory = subategory
        self.location = location
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        guard let subCategory = subCategory, let location = location else { return }
        fetchData(subCategory: subCategory, location: location)
    }
    
    private func fetchData(subCategory: SubCategory, location: Location) {
        Service.shared.fetchNearbyPlaces(location: location, subCategory: subCategory) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                return
            }
            
            guard let response = response else { return }
            self.placeResults = self.searchResponseFilter.results(from: response)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
