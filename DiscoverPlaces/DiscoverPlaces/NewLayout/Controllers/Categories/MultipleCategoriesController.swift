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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
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
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
            detailsController.title = name
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



class SubCategoryiesHolder: UICollectionViewCell {
    
    public static let id = "subCategoryiesHolderId"
    
    var subCategoryTitleLabel = UILabel(text: "Sub-Category", font: .systemFont(ofSize: 20, weight: .semibold),color: .label, numberOfLines: 0)
    let horizontalController = SubCategoryHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(subCategoryTitleLabel)
        subCategoryTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 20, bottom: 0, right: 20))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: subCategoryTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
