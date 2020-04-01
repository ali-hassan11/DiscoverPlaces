//
//  SmallSquarePlaceCell.swift
//  DiscoverPlaces
//
//  Created by user on 13/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SmallSquarePlaceCell: UICollectionViewCell {
    
    public static let id = "smallSquareSpaceCellId"
    
    let placeImageView = UIImageView(image: UIImage(named: "food"))
    let placeNameLabel = UILabel(text: "Burj Khalifah Hotel - Dubai, United Arab Emirates", font: .systemFont(ofSize: 16, weight: .regular), color: .label, numberOfLines: 2)
    let distanceLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryLabel, numberOfLines: 1)
    let starsView = StarsView(width: 80)

    func configure(place: PlaceResult?, userLocation: Location?) {
        guard let place = place else { return } //Error
        
        guard let photo = place.photos?.first else {
            return //Default Image
        }
        
        guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else {
            return /*Default Image*/
        }
        
        placeImageView.backgroundColor = .secondarySystemBackground
        placeImageView.sd_setImage(with: url)
        placeNameLabel.text = place.name
        
        guard let rating = place.rating else {
            print("\(String(describing: self.placeNameLabel.text)): No Rating 🤔🤔🤔")
            return
        }
        starsView.populate(with: rating)
        
        guard let geometry = place.geometry else { return }
        //If no location, use Saved location
        let distanceString = geometry.distanceString(from: userLocation!)
        distanceLabel.text = distanceString
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.35, end: 0.45)
        
        addSubview(placeImageView)
        placeImageView.roundCorners()
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        placeImageView.constrainHeight(constant: 150)
        
        addSubview(placeNameLabel)
        placeNameLabel.anchor(top: placeImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 0, right: 4))
        
        addSubview(starsView)
        starsView.populate(with: 4.5)
        starsView.anchor(top: placeNameLabel.bottomAnchor, leading: placeNameLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        addSubview(distanceLabel)
        distanceLabel.anchor(top: starsView.bottomAnchor, leading: starsView.leadingAnchor, bottom: nil, trailing: starsView.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

