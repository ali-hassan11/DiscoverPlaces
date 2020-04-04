//
//  SubCategoryiesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 13/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SubCategoryiesHolder: UICollectionViewCell {
    
    public static let id = "subCategoryiesHolderId"
    
    var subCategoryTitleLabel = UILabel(text: "Sub-Category", font: .systemFont(ofSize: 20, weight: .semibold),color: .label, numberOfLines: 0)
    var horizontalController = PlaceGroupHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(subCategoryTitleLabel)
        subCategoryTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: sidePadding, bottom: 0, right: sidePadding))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: subCategoryTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
