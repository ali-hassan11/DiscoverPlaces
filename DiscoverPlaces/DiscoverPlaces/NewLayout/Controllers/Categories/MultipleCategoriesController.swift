//
//  MultipleCategoriesController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //Inject This & Category?
    var location: Location?
    
    var category: Category! {
        didSet {
            for subCategory in category.subCategories() {
                fetchData(subCategory: subCategory)
            }
        }
    }
    
    var placeResults = [[PlaceResult]]()
    var subCategories = [SubCategory]()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .medium)
        aiv.color = .secondaryLabel
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    private let fadeView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
        
        view.addSubview(fadeView)
        fadeView.alpha = 1
        fadeView.fillSuperview()
        
        fadeView.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func fetchData(subCategory: SubCategory) {
        guard let location = location else {
            fatalError("No Location!")
        }
        
        Service.shared.fetchNearbyPlaces(location: location, subCategory: subCategory) { (results, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let results = results else {
                print("No results?")
                return
            }
            
            //This is repeated in a few places, abstact it to a mapper..?
            var filteredResults = [PlaceResult]()
            
            results.results.forEach({ (result) in
                if result.containsPhotos()
                    && !(result.types?.contains("locality") ?? true)
                {
                    filteredResults.append(result)
                }
            })
            
            //If results < 5, load other places
            
            if filteredResults.count > 0 {
                self.placeResults.append(filteredResults)
                self.subCategories.append(subCategory)
            }
            
            #warning("Not Working yet")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1, animations: {
                    self.fadeView.alpha = 0
                    self.activityIndicatorView.stopAnimating()
                    self.collectionView.reloadData()
                }) { _ in
                    self.fadeView.removeFromSuperview()
                }
                
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
        cell.subCategoryTitleLabel.text = subCategories[indexPath.item].formatted()
        cell.horizontalController.places = placeResults[indexPath.item]
        cell.horizontalController.location = location
        cell.horizontalController.didSelectPlaceInCategoriesHandler = { [weak self] placeId, name in
            let detailsController = PlaceDetailsController()
            detailsController.placeId = placeId
            self?.navigationController?.pushViewController(detailsController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
