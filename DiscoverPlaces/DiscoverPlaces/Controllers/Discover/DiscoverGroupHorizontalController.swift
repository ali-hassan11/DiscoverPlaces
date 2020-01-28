//
//  DiscoverGroupController.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DiscoverGroupHorizontalController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var placeResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(DicoverCardCell.self, forCellWithReuseIdentifier: "id")
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        fetchPlaces(for: "restaurant")
    }
    
    fileprivate func fetchPlaces(for category: String) {
        Service.shared.fetchPlacesForCategory(for: category) { (results, error) in
            
            var filteredResults = [Result]()
            
            results?.results.forEach({ (result) in
                if result.containsPhotos() {
                    filteredResults.append(result)
                }
            })
            
            self.placeResults = filteredResults
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertVC = UIAlertController(title: placeResults[indexPath.row].name, message: placeResults[indexPath.row].photos?.first?.photoReference, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Dismiss", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 140, height: view.frame.height - 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 12, bottom: 8, right: 12)
    }
}


