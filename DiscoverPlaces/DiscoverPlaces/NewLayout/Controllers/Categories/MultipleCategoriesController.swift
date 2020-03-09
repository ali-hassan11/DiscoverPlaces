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
            fetchData()
        }
    }
    
    var placeResults: [PlaceResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
    }
    
    private func fetchData() {
        guard let location = location else {
            fatalError("No Location!")
            return
        }
        
        Service.shared.fetchNearbyPlaces(location: location) { (results, error) in
            
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
                if result.containsPhotos()
                    && !(result.types?.contains("locality") ?? true)
                {
                    filteredResults.append(result)
                }
            })
            
            //If results < 5, load other places
            
            self.placeResults = filteredResults
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.subCategories().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
        cell.horizontalController.places = placeResults
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
}



class SubCategoryiesHolder: UICollectionViewCell {
    
    public static let id = "subCategoryiesHolderId"
    
    let subCategoryTitleLabel = UILabel(text: "Sub-Category", font: .systemFont(ofSize: 20, weight: .semibold),color: .label, numberOfLines: 0)
    let horizontalController = SubCategoryHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(subCategoryTitleLabel)
        subCategoryTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 20, bottom: 0, right: 20))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: subCategoryTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 12, right: 0))
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
