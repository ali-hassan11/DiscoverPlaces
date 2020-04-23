//
//  CategoriesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class CategoriesHolder: UICollectionViewCell {
    
    static let id = "categoriesHolderId"
    
    let sectionTitleLabel = UILabel(text: "Feeling Adventurous", font: .systemFont(ofSize: 24, weight: .bold),color: .label, numberOfLines: 0)
    let sectionDescriptionLabel = UILabel(text: "Why not try something new, get inspiration from our range of categories...", font: .systemFont(ofSize: 16, weight: .regular),color: .secondaryLabel , numberOfLines: 0)
    
    let horizontalController = CategoriesHorizontalController()
 
    let paddingView = PaddingView(width: Constants.sidePadding)
    let paddingView2 = PaddingView(width: Constants.sidePadding)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        let stackiew = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [PaddingView(width: Constants.sidePadding), sectionTitleLabel]),
                                                            UIStackView(arrangedSubviews: [PaddingView(width: Constants.sidePadding), sectionDescriptionLabel, PaddingView(width: Constants.sidePadding)]),
                                                            horizontalController.view], spacing: 10)
        addSubview(stackiew)
        stackiew.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
