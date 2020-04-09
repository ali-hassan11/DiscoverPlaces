//
//  HomeLargeCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class LargePlaceCell: UICollectionViewCell {
    
    public static let id = "largeCellId"
    
    
    let placeImageView = UIImageView(image: UIImage(named: "cafe"))
    let placeNameLabel = UILabel(text: "", font: .systemFont(ofSize: 24, weight: .semibold), color: .white, numberOfLines: 2)
    let distanceLabel = Font().distanceLabel
    let starRatingView = StarRatingView()
    
    var image: UIImage?
    
    var userLocation: Location?
    
    var result: PlaceResult! {
        didSet {
            guard let photo = result.photos?.first else {
                return
            }
            
            guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else {
                return
            }
            
            placeImageView.sd_setImage(with: url)
            
            placeNameLabel.text = result.name
            
            guard let rating = result.rating else { return }
            starRatingView.populate(with: rating, displaysNumber: true)
            
            guard let userLocation = userLocation else { return }
            distanceLabel.text = result.geometry?.distanceString(from: userLocation)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        clipsToBounds = true

        placeImageView.contentMode = .scaleAspectFill
        addSubview(placeImageView)
        placeImageView.fillSuperview()

        let stackView = HorizontalStackView(arrangedSubviews: [starRatingView, distanceLabel])
        placeImageView.addSubview(stackView)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        addSubview(placeNameLabel)
        placeNameLabel.anchor(top: nil, leading: stackView.leadingAnchor, bottom: stackView.topAnchor, trailing: stackView.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 8, right: 0))
        
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.43, end: 0.84)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

