//
//  HomeController.swift
//  DiscoverPlaces
//
//  Created by user on 05/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//
import UIKit

class HomeController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let largeCellHolderId = "largeCellHeaderId"
    fileprivate let categoriesHolderId = "categoriesHolderId"

    var results = [PlaceResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationBarButton = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(addTapped))

        locationBarButton.tintColor = .label
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = locationBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoriesHolder.self, forCellWithReuseIdentifier: categoriesHolderId)
        //Header 1
        collectionView.register(HomeLargeCellHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: largeCellHolderId)
        
        fetchData()
    }
    
    fileprivate func fetchData() {

        Service.shared.fetchNearbyPlaces { (results, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let results = results else {
                print("No results?")
                return
            }
            
            var filteredResults = [PlaceResult]()
            
            results.results.forEach({ (result) in
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
    
    @objc func addTapped() {
        let locationSearchVC = UIViewController()
        locationSearchVC.view.backgroundColor = .blue
        show(locationSearchVC, sender: self)
    }
    
    //Header (Large Cell)
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: largeCellHolderId, for: indexPath) as! HomeLargeCellHolder
        cell.horizontalController.results = results
        cell.horizontalController.didSelectHandler = { [weak self] result in
            let detailsController = PlaceDetailsController()
            detailsController.placeId = result.place_id
            self?.navigationController?.pushViewController(detailsController, animated: true)
        }
        return cell
    }
    
    //Header (Large Cell)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 480)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesHolderId, for: indexPath) as! CategoriesHolder
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 380)
    }
}
