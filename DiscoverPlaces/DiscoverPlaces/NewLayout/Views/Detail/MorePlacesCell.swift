//
//  MorePlacesCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MorePlacesCell: UICollectionViewCell {
    
    let placeImageView = UIImageView(image: UIImage(named: "hotel"))
     let placeNameLabel = UILabel(text: "Burj Khalifah Hotel - Dubai", font: .systemFont(ofSize: 17, weight: .semibold), color: .white, numberOfLines: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground

        layer.cornerRadius = 10
        clipsToBounds = true
        
        placeImageView.contentMode = .scaleAspectFill
        addSubview(placeImageView)
        placeImageView.fillSuperview()
        
        addSubview(placeNameLabel)
        placeNameLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
