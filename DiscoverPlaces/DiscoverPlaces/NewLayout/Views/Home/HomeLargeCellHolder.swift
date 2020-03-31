//
//  HomeLargeCellHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class HomeLargeCellHolder: UICollectionReusableView {
    
    static let id = "largeCellHolderId"
    
    let sectionDescriptionLabel = UILabel(text: "Places of interest near You", font: .systemFont(ofSize: 16, weight: .medium),color: .secondaryLabel , numberOfLines: 0)
    
    let paddingView = PaddingView(width: Constants.leftPadding)
    
    let horizontalController = HomeLargeCellsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [paddingView, sectionDescriptionLabel]),
                                                             horizontalController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
