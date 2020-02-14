//
//  DiscoverCardCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DicoverCardCell: UICollectionViewCell {
    
    var result: PlaceResult! {
        didSet{
            placeNameLabel.text = result.name
            
            if let photoReference = result.photos?.first?.photoReference {
                let imageUrl = UrlBuilder.buildImageUrl(with: photoReference)
                placeImageView.sd_setImage(with: imageUrl)
            } else {
                //Set a default image
                return
            }
        }
    }
        
    let placeNameLabel: UILabel! = {
        let lbl = UILabel()
        lbl.text = "Example Place Name"
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 15, weight: .medium)
        lbl.textColor = .white
        return lbl
    }()
    
    let placeImageView: UIImageView! = {
        let iv = UIImageView(frame: .zero)
        iv .contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16 //Standardize
        iv.clipsToBounds = true
//        iv.addOverlay(color: .black, alpha: 0.25)//Standardize
      return iv
    }()
    
    let cardView: UIView! = {
       let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        v.constrainHeight(constant: 30)
        
        let grad = CAGradientLayer()
        grad.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        grad.frame = v.bounds
        v.layer.addSublayer(grad)
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
        placeNameLabel.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
