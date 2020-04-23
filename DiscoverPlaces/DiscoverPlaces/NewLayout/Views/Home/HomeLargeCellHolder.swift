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
    
    let rightPadding = PaddingView(width: sidePadding)
    let leftPadding = PaddingView(width: sidePadding)

    let horizontalController = HomeLargeCellsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .blue
//        sectionDescriptionLabel.backgroundColor = .green
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [leftPadding, sectionDescriptionLabel, rightPadding]), horizontalController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        
    }
    
    func configureTitle(with placeName: String?) {
        if let name = placeName {
            sectionDescriptionLabel.text = "Places of interest - \(name)"
        } else {
            sectionDescriptionLabel.text = "Places of interest near You"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
