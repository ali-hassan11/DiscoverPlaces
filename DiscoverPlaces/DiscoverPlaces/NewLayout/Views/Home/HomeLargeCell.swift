//
//  HomeLargeCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class HomeLargeCell: UICollectionViewCell {
    
    public static let id = "largeCellId"
    
    let placeImageView = UIImageView(image: UIImage(named: "hotel"))//Try and make empty without loosing gradient
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 24, weight: .semibold), color: .white, numberOfLines: 2)
    //If location not enabled, dont show distance label
    let distanceLabel = UILabel(text: "1.7 Km", font: .systemFont(ofSize: 16, weight: .semibold), color: .lightText, numberOfLines: 1)
    let starsView = StarsView(width: 90)
    
    var image: UIImage?
    
    var userLocation: Location?
    
    var result: PlaceResult! {
        didSet {
            guard let photo = result.photos?.first else {
                return //Default Image
            }
            
            guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else {
                return /*Default Image*/
            }
            
            placeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "transparentBlock"), options: .continueInBackground) { (image, error, _, _) in
                
                if let error = error {
                    print("Falied to load image: ", error)
                    self.placeImageView.image = UIImage(named: "noPhotosFound")
                    return
                }
                
                self.image = image
            }
            placeNameLabel.text = result.name
            
            guard let rating = result.rating else { return }
            starsView.populate(with: rating)
            
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

        let stackView = HorizontalStackView(arrangedSubviews: [starsView, distanceLabel])
        placeImageView.addSubview(stackView)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        addSubview(placeNameLabel)
        placeNameLabel.anchor(top: nil, leading: stackView.leadingAnchor, bottom: stackView.topAnchor, trailing: stackView.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 8, right: 0))
        
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.225, end: 0.35)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

