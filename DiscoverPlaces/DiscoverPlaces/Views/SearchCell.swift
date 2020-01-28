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
    
    var searchResult: Result! {
        didSet {
            
            if let photoReference = searchResult.photos?.first?.photo_reference {
                
                let imageUrl = UrlBuilder.buildImageUrl(with: photoReference)
                
                 placeImageView.sd_setImage(with: imageUrl) { (_, err, cache, url) in
                            if let err = err {
                                return
//                                print("Couldn't load image with error: \(err.localizedDescription)")
                            }
                        }
                
                
                placeNameLabel.text = searchResult.name //Make Sentence Case
                placeNameLabel.textColor = .white

            } else {
                //Set a default image
                return
//                placeNameLabel.text = "OOOPS"
//                placeNameLabel.textColor = .red
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
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.25) //Standardize?
        iv.addSubview(overlay)
        overlay.fillSuperview()
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

