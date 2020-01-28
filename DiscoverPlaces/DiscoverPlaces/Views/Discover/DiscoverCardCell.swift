//
//  DiscoverCardCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DicoverCardCell: UICollectionViewCell {
    
    var result: Result! {
        didSet{
            placeNamelabel.text = result.name
            
            if let photoReference = result.photos?.first?.photoReference {
                let imageUrl = UrlBuilder.buildImageUrl(with: photoReference)
                placeImageView.sd_setImage(with: imageUrl)
            } else {
                //Set a default image
                return
            }
        }
    }
    
    let placeNamelabel: UILabel! = {
        let lbl = UILabel()
        lbl.text = "Example Place Name"
        lbl.numberOfLines = 2
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textColor = .white
        return lbl
    }()
    
    let placeImageView: UIImageView! = {
        let iv = UIImageView(frame: .zero)
        iv .contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16 //Standardize
        iv.clipsToBounds = true
        iv.addOverlay(color: .black, alpha: 0.25)//Standardize
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(placeImageView)
        placeImageView.fillSuperview()
        
        placeImageView.addSubview(placeNamelabel)
        placeNamelabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
