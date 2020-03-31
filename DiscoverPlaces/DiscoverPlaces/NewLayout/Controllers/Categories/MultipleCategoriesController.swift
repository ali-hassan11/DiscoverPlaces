//
//  MultipleCategoriesController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let searchResponseFilter = SearchResponseFilter()
    
    //Inject This & Category?
    var location: Location?
    
    var category: Category!
    
    var placeGroupResults = [[PlaceResult]]()
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
        
//        view.addSubview(fadeView)
//        fadeView.alpha = 1
//        fadeView.fillSuperview()
        
        fadeView.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData(for: category)
    }
//    let subcats: [SubCategory = [.restaurant, .cafe, .meal_delivery, .meal_takeaway]
    
    private func fetchData(for category: Category) {
        for subcategory in category.subCategories() {
            fetchData(for: subcategory)
        }
    }
    
    private func fetchData(for subCategory: SubCategory) {
        var placeGroups = [[PlaceResult]]()
          
          //Sync data fetches
//        let dispatchGroup = DispatchGroup()
        
//        dispatchGroup.enter()
        
        Service.shared.fetchPlacesForCategory(for: subCategory.rawValue) { (response, error) in
            
            if let error = error {
                print("Failed to fetch games: ", error)
                return
            }
            
            //success
            guard let response = response else {
                print("No results?")
                return
            }
            
            //This is repeated in a few places, abstact it to a mapper..?
            let filteredResults = self.searchResponseFilter.filteredResults(from: response)

            if filteredResults.count > 0 {
                self.placeGroupResults.append(filteredResults)
                self.subCategories.append(subCategory)
            }
            
            #warning("Not Working yet")
            DispatchQueue.main.async {
                print("Completed dispatch group tasks..")
                
//                self.placeGroupResults = placeGroups
                self.collectionView.alpha = 0

                UIView.animate(withDuration: 0.35) {
                    self.collectionView.alpha = 1
                }
                
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeGroupResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
//        cell.subCategoryTitleLabel.text = subCategories[indexPath.item].formatted()
   
        cell.horizontalController.places = placeGroupResults[indexPath.item]
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
