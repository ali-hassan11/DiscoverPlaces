//
//  MultipleCategoriesController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
        
    var location: Location?
    var category: Category?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
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
            return category?.subCategories().count ?? 0
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
            
            guard let category = category else { return UICollectionViewCell() } //ErrorCell
            
            let subCategory = category.subCategories()[indexPath.item]
            cell.subCategoryTitleLabel.text = subCategory.formatted()
            cell.horizontalController = SmallSquarePlacesHorizontalController(location: location!, subategory: subCategory)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: view.frame.width, height: 280)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
}
