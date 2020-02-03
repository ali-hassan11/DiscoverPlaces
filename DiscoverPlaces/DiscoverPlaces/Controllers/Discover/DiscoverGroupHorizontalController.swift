//
//  DiscoverGroupController.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DiscoverGroupHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var category: String! {
        didSet {
            fetchPlaces(for: category)
        }
    }
    
    var placeResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(DicoverCardCell.self, forCellWithReuseIdentifier: "id")
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
    }
    
    fileprivate func fetchPlaces(for category: String) {
        Service.shared.fetchPlacesForCategory(for: category) { (results, error) in
            
            if let error = error {
                print("Failed to Fetch: \(error.localizedDescription)")
                return
            }
            
            //success
            var filteredResults = [Result]()
            
            results?.results.forEach({ (result) in
                if result.containsPhotos() {
                    filteredResults.append(result)
                }
            })
            
            self.placeResults = filteredResults
            
            
            DispatchQueue.main.async {
                if self.placeResults.count == 0 {
                    //PlaceHolder or alternative?
                    return
                } else {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //Delegate & DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! DicoverCardCell
        cell.result = placeResults[indexPath.row]
        return cell
    }

    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 180, height: view.frame.height - 16)
    }
}


