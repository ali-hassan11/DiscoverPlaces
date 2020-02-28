//
//  CategoryCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    public static let id = "categoryCellId"

    let categoryLabel = UILabel(text: "Category", font: .systemFont(ofSize: 20, weight: .semibold), color: .white, alignment: .center, numberOfLines: 0)
    let categoryImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.addOverlay(color: .black, alpha: 0.35)

        
        addSubview(categoryImageView)
        categoryImageView.fillSuperview()
        categoryImageView.addSubview(categoryLabel)
        categoryLabel.centerInSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

