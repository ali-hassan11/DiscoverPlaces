//
//  MultipleCategoriesController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var category: Category! {
        didSet {
            print("Fetch \(category.subCategories())")
            places = [PlaceResult(geometry: nil, icon: nil, place_id: "id", name: "TestName 1", photos: nil, types: nil, rating: 1),
                      PlaceResult(geometry: nil, icon: nil, place_id: "id", name: "TestName 2", photos: nil, types: nil, rating: 2),
                      PlaceResult(geometry: nil, icon: nil, place_id: "id", name: "TestName 3", photos: nil, types: nil, rating: 3),
                      PlaceResult(geometry: nil, icon: nil, place_id: "id", name: "TestName 4", photos: nil, types: nil, rating: 4),
                      PlaceResult(geometry: nil, icon: nil, place_id: "id", name: "TestName 5", photos: nil, types: nil, rating: 5),
            ]
            
            //pass places to horizontalController
        }
    }
    
    var places: [PlaceResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.subCategories().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
        cell.horizontalController.places = places
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
        horizontalController.view.anchor(top: subCategoryTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 42, right: 0))
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
