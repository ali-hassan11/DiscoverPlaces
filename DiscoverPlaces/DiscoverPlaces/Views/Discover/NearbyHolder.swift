//
//  NearbyHeader.swift
//  DiscoverPlaces
//
//  Created by user on 29/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class NearbyHolder: UICollectionReusableView {
    
    let nearbyHeaderController = NearbyHorizontalController()
    
    let captionLabel: UILabel! = {
       let lbl = UILabel()
        lbl.text = "Nearby places you may like..."
        lbl.textColor = .darkText
        lbl.font = .systemFont(ofSize: 18, weight: .light)
        return lbl
    }()
    
    let paddingView: UIView! = {
        let v = UIView()
        v.constrainWidth(constant: 16)
        v.backgroundColor = .clear
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 16), size: .zero)
        
        addSubview(nearbyHeaderController.view)
        nearbyHeaderController.view.anchor(top: captionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
