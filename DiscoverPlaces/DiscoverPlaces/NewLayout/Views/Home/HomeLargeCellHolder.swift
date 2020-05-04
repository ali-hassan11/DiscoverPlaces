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
    
    let placesOfInterestLabel = UILabel(text: "Places of interest ", font: .systemFont(ofSize: 18, weight: .regular),color: .secondaryLabel , numberOfLines: 1)
    let placeNameLabel = UILabel(text: " Near You", font: .systemFont(ofSize: 18, weight: .medium),color: .label , numberOfLines: 1)
    
    let rightPadding = PaddingView(width: Constants.sidePadding)
    let leftPadding = PaddingView(width: Constants.sidePadding)

    let horizontalController = HomeLargeCellsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .blue
//        sectionDescriptionLabel.backgroundColor = .green
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [leftPadding, placesOfInterestLabel, placeNameLabel, UIView(), rightPadding]), horizontalController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 0, bottom: 8, right: 0))
        
    }
    
    func configureTitle(with placeName: String?) {
        if let name = placeName {
            placeNameLabel.text = "- \(name)"
        } else {
            placeNameLabel.text = "Near you"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
