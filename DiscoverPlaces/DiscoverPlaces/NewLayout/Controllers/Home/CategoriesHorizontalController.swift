//
//  CategoriesHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class CategoriesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let numberOfRows:CGFloat = 3
    fileprivate let numberOfColumns:CGFloat = 2
    fileprivate let lineSpacing: CGFloat = 10
    
    var didSelectCategory: ((Category) -> ())?
    
    let categories: [Category] = [.Food, .Cafe, .Shopping, .Nature, .Active, .Religion, .Beauty, .Health, .Hotel]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.contentInset = .init(top: Constants.topPadding, left: Constants.leftPadding, bottom: Constants.bottomPadding, right: Constants.rightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        let categoryName = categories[indexPath.item].rawValue
        cell.categoryLabel.text = categoryName
        cell.categoryImageView.image = UIImage(named: categoryName)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCategory?(categories[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: ((view.frame.width - (Constants.leftPadding + Constants.rightPadding + lineSpacing*numberOfColumns)) / numberOfColumns), height: (view.frame.height - (lineSpacing * (numberOfRows - 1))) / numberOfRows)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}

enum Category: String {
    case Food
    case Cafe
    case Shopping
    case Nature
    case Active
    case Religion
    case Beauty
    case Health
    case Hotel
    
    func subCategories() -> [SubCategory] {
        switch self {
        case .Food: return [.restaurant, .cafe, .meal_delivery, .meal_takeaway]
        default: fatalError()
        }
    }
}

enum SubCategory: String {
    case restaurant
    case cafe
    case meal_delivery
    case meal_takeaway
    
    case notConfiguredYet //Remove this
    
    func formatted() -> String {
        switch self {
        case .restaurant: return "Restaurants"
        case .cafe: return "Cafes"
        case .meal_delivery: return "Delivery"
        case .meal_takeaway: return "Takeaway"
        case .notConfiguredYet: return "notConfiguredYet"
        }
    }
}
