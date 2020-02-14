//
//  MorePlacesCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MorePlacesCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 10
        clipsToBounds = true

        backgroundColor = .secondarySystemBackground
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
