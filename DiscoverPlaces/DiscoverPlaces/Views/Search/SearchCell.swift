//
//  SearchCell.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell: UICollectionViewCell {
    
    var searchResult: PlaceResult! {
        didSet {
            
            placeNameLabel.text = searchResult.name
            placeNameLabel.textColor = .white
            
            if let photo = searchResult.photos?.first, let reference = photo.photoReference {
                let imageUrl = UrlBuilder.buildImageUrl(with: reference, width: photo.width ?? 2000)
                placeImageView.sd_setImage(with: imageUrl)
            } else {
                //Set a default image
                return
            }
        }
    }
    

    
    let placeImageView: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.layer.cornerRadius = 16 //Standardize
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).cgColor //Standardize
        iv.layer.borderWidth = 0.5 //Standardize?
        iv.addOverlay(color: .black, alpha: 0.25)
        return iv
    }()
    
    let placeNameLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = ""
        lbl.font = .boldSystemFont(ofSize: 28)
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(placeImageView)
        placeImageView.addSubview(placeNameLabel)
        placeImageView.fillSuperview()
        placeNameLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}

