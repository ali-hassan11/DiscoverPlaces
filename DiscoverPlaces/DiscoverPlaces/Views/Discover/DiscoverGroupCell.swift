//
//  DiscoverGroupCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DiscoverGroupCell: UICollectionViewCell {
    
    let sectionTitle: UILabel! = {
        let lbl = UILabel()
        lbl.text = "Section Title"
        return lbl
    }()
    
    let horizontalController = DiscoverGroupHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
