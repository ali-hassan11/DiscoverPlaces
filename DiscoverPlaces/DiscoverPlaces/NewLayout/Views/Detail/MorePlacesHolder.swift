//
//  MorePlacesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class MorePlacesHolder: UICollectionViewCell {
    
    public static let id = "morePlacesHolderId"

    var horizontalController = PlaceGroupHorizontalController(results: nil, didSelectHandler: nil)
    
    let sectionTitle = UILabel(text: "Nearby", font: .systemFont(ofSize: 19, weight: .medium), color: .label, numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(sectionTitle)
        sectionTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 16))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: sectionTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
