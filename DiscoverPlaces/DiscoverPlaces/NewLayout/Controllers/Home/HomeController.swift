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
        navigationItem.rightBarButtonItem = locationBarButton
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoriesHolder.self, forCellWithReuseIdentifier: categoriesHolderId)
        //Header 1
        collectionView.register(HomeLargeCellHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: largeCellHolderId)
        
        fetchData()
    }
    
    fileprivate func fetchData() {

        Service.shared.fetchNearbyPlaces { (res, error) in
            
            if let error = error {
                print("Failed to fetch games: ", error)
                return
            }
            
            //success
            guard let res = res else { return }
            
            self.results = res.results
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
    
    //Header 2
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: largeCellHolderId, for: indexPath) as! HomeLargeCellHolder
        cell.horizontalController.results = results
        cell.horizontalController.didSelectHandler = { [weak self] result in
            let detailsController = PlaceDetailsController()
            detailsController.title = result.name
            detailsController.place = result
            detailsController.placeId = result.id
            self?.navigationController?.pushViewController(detailsController, animated: true)
        }
        return cell
    }
    
    //Header 3
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
