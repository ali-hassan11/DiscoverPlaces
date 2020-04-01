//
//  MultipleCategoriesController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

struct SubCategoryGroup {
    let title: String
    let results: [PlaceResult]
}

class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
        
    private let searchResponseFilter = SearchResponseFilter()
    
    private var location: Location?
    private var category: Category?
    
    private var subCategoryGroups: [SubCategoryGroup]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
        
        guard let category = category, let location = location else { fatalError() }
        fetchSubCategoryGroups(category: category, location: location)
    }

    private func fetchSubCategoryGroups(category: Category, location: Location) {
        category.subCategories().forEach {
            dispatchGroup.enter()
            fetchdata(subCategory: $0, location: location)
        }
    }
    
    let dispatchGroup = DispatchGroup()
    
    private func fetchdata(subCategory: SubCategory, location: Location) {
        print("FetchData for \(subCategory)")
        var subCategoryGroup: SubCategoryGroup?
        Service.shared.fetchNearbyPlaces(location: location, subCategory: subCategory) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                return
            }
            
            guard let response = response else { return }
            let placeResults = self.searchResponseFilter.results(from: response)
            subCategoryGroup = SubCategoryGroup(title: subCategory.formatted(), results: placeResults)
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("➡️ Response for \(String(describing: subCategoryGroup?.title)) : \n\(String(describing: subCategoryGroup?.results.first?.name))\n")
            
            guard let subCategoryGroup = subCategoryGroup else { return }
            self.subCategoryGroups?.append(subCategoryGroup)
            self.collectionView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    init(category: Category, location: Location) {
        self.location = location
        self.category = category
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MultipleCategoriesController {
    
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return subCategoryGroups?.count ?? 0
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
            
            guard let subCategory = subCategoryGroups?[indexPath.item] else { return UICollectionViewCell() } //ErrorCell
            cell.subCategoryTitleLabel.text = subCategory.title
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: view.frame.width, height: 280)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
}
