//
//  NearbyHeaderCell.swift
//  DiscoverPlaces
//
//  Created by user on 29/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class NearbyHeaderCell: UICollectionViewCell {
    
    var result: PlaceResult! {
        didSet{
            placeNameLabel.text = result.name
            
            if let photo = result.photos?.first {
                guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else { return /*Default Image*/ }
                placeImageView.sd_setImage(with: url)
            } else {
                //Set a default image
                return
            }
        }
    }
    
    let placeNameLabel: UILabel! = {
        let lbl = UILabel()
        lbl.text = "The Grand Hotel - Spa and Restaurant"
        lbl.font = .boldSystemFont(ofSize: 24)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.textAlignment = .left
        return lbl
    }()
    
    let placeImageView: UIImageView! = {
        let iv = UIImageView()
        iv .contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16 //Standardize
        iv.clipsToBounds = true
        iv.addOverlay(color: .black, alpha: 0.25)//Standardize
        return iv
    }()
    
    let cardView: UIView! = {
       let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()

        addSubview(placeImageView)
        placeImageView.fillSuperview()
        
        placeImageView.addSubview(cardView)
        cardView.anchor(top: nil, leading: placeImageView.leadingAnchor, bottom: placeImageView.bottomAnchor, trailing: placeImageView.trailingAnchor)
        
        cardView.addSubview(placeNameLabel)
        placeNameLabel.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
