//
//  MorePlacesCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MorePlacesCell: UICollectionViewCell {
    
    var place: PlaceResult? {
        didSet {
            guard let photo = place?.photos?.first else {
                return //Default Image
            }
            
            guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else {
                return /*Default Image*/
            }
            
            placeImageView.sd_setImage(with: url)
            placeNameLabel.text = place?.name
        }
    }
    
    let placeImageView = UIImageView(image: UIImage(named: "hotel"))
    let placeNameLabel = UILabel(text: "Burj Khalifah Hotel - Dubai", font: .systemFont(ofSize: 16, weight: .medium), color: .white, numberOfLines: 2)
    
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
        
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.06, end: 0.175)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
