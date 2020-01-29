//
//  NearbyController.swift
//  DiscoverPlaces
//
//  Created by user on 29/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class NearbyHorizontalController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(NearbyHeaderCell.self, forCellWithReuseIdentifier: "id")
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        fetchNearbyPlaces()
    }

    fileprivate func fetchNearbyPlaces() {
        Service.shared.fetchNearbyPlaces { (results, error) in
            
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
            
            self.results = filteredResults
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! NearbyHeaderCell
        cell.result = results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 24 - 24, height: view.frame.height - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 12, bottom: 12, right: 12)
    }
    
}
