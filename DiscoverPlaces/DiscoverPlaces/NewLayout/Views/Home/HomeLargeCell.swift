//
//  HomeLargeCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class HomeLargeCell: UICollectionViewCell {
    
    let placeImageView = UIImageView(image: UIImage(named: "hotel"))
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 26, weight: .semibold), color: .white, numberOfLines: 3)
    let distanceLabel = UILabel(text: "1.7 Km", font: .systemFont(ofSize: 16, weight: .semibold), color: .lightText, numberOfLines: 1)
    let undicededButton = UIButton(title: "Details", textColor: .white, width: 100, height: 40, font: .systemFont(ofSize: 18, weight: .medium), backgroundColor: UIColor.systemPink, cornerRadius: 10)
    
    var image: UIImage?
    
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

        let stackView = HorizontalStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [placeNameLabel, distanceLabel], spacing: 8),
            undicededButton
        ])
        placeImageView.addSubview(stackView)
        stackView.alignment = .bottom
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 24, bottom: 24, right: 24), size: .zero)
        
        placeImageView.addGradientBackground(firstColor: .clear, secondColor: .black)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

