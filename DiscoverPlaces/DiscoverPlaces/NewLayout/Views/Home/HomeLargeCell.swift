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
    
    var result: PlaceResult! {
        didSet {
            if let photo = result.photos?.first, let reference = photo.photoReference {
                guard let url = UrlBuilder.buildImageUrl(with: reference, width: photo.width ?? 2000) else {
                    return /*Default Image*/
                }
                placeImageView.sd_setImage(with: url)
            } else {
                //Default Image
            }
            placeNameLabel.text = result.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .lightGray
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

