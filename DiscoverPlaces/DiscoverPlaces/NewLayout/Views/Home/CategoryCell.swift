//
//  CategoryCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    public static let id = "categoryCellId"

    let categoryLabel = UILabel(text: "", font: .systemFont(ofSize: 25, weight: .medium), color: .white, alignment: .center, numberOfLines: 0)
    let categoryImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        roundCorners()
        
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.addOverlay(color: .black, alpha: 0.5)
        
        addSubview(categoryImageView)
        categoryImageView.fillSuperview()
        categoryImageView.addSubview(categoryLabel)
        categoryLabel.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

