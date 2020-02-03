//
//  SelectedCategoresHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 03/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//
struct Categoryy {
    let name: String!
    let isSelected: Bool!
}

import UIKit

class SelectedCategoresHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
        
    public func toggleSelectedState(index: Int) {
        if collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.backgroundColor == .red {
            collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.backgroundColor = .blue
        } else {
            collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.backgroundColor = .red
        }
    }
    
    var categories: [Categoryy]! {
          didSet {
            collectionView.reloadData()
          }
      }
    
    var didSelectHandler: ((Categoryy, Int) -> ())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectHandler?(categories[indexPath.item], indexPath.item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: "id")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! SelectCategoryCell
        cell.categoryLabel.text = categories[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 90, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

class SelectCategoryCell: UICollectionViewCell {
    
    //didSet
    
    let categoryLabel: UILabel! = {
        let lbl = UILabel(text: "Cat", font: UIFont.systemFont(ofSize: 12, weight: .medium), numberOfLines: 1)
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        layer.cornerRadius = 12 //Standardize
        clipsToBounds = true
        
        addSubview(categoryLabel)
        categoryLabel.fillSuperview()
        
    }
    
    public func toggleSelectedState() {
          if backgroundColor == .red {
              backgroundColor = .blue
          } else {
              backgroundColor = .red
          }
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

