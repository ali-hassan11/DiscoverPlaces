//
//  ReviewsHolder.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ReviewsHolder: UICollectionViewCell {

    public static let id = "reviewsHolderId"
    
    let horizontalController = ReviewsHorizontalController()
    let sectionTitle = UILabel(text: "Reviews", font: .systemFont(ofSize: 19, weight: .medium), color: .label, numberOfLines: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground

        addSubview(sectionTitle)
        sectionTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 16))

        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: sectionTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 16, right: 0))

        addBottomSeparator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
