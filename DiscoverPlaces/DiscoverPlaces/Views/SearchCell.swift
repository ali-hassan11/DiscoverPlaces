//
//  SearchCell.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    let placeImageView: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.layer.backgroundColor = UIColor.clear.cgColor
        iv.layer.cornerRadius = 16 //Standardize
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).cgColor //Standardize
        iv.layer.borderWidth = 0.5 //Standardize?
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3) //Standardize?
        iv.addSubview(overlay)
        overlay.fillSuperview()
        return iv
    }()
    
    let placeNameLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Burj Al-Arab"
        lbl.font = .boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeImageView.image = #imageLiteral(resourceName: "burj")
        
        addSubview(placeImageView)
        placeImageView.addSubview(placeNameLabel)
        placeImageView.fillSuperview()
        placeNameLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}

