//
//  GoogleLogoCell.swift
//  DiscoverPlaces
//
//  Created by user on 10/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class GoogleLogoCell: UICollectionViewCell {
    
    static let id = "googleCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .systemPink
        let googleImageView = UIImageView(image: UIImage(imageLiteralResourceName: "googleLogo"))
        addSubview(googleImageView)
        googleImageView.constrainWidth(constant: 150)
        googleImageView.contentMode = .scaleAspectFit
        googleImageView.centerInSuperview()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
