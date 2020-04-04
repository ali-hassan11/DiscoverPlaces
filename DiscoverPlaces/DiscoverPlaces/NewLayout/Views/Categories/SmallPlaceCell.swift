//
//  SmallSquarePlaceCell.swift
//  DiscoverPlaces
//
//  Created by user on 13/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SmallPlaceCell: UICollectionViewCell {
    
    public static let id = "smallSquareSpaceCellId"
    
    let placeImageView = UIImageView(image: UIImage(named: ""))
    let placeNameLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium), color: .label, numberOfLines: 2) //Can't be more than 2
    let addressLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryLabel, numberOfLines: 1) //Can't be more that 1
    let starView = StarsView(width: 80)
    
    
    let highlightView: UIView! = {
        let v = UIView()
        v.backgroundColor = UIColor.quaternarySystemFill
        return v
    }()
    
    override var isHighlighted: Bool {
        didSet {
            highlightView.isHidden = self.isHighlighted ? false : true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        placeImageView.backgroundColor = .secondarySystemBackground
        setupPlaceImageView()
        setupStackView()
        configureHighlightView()
    }
    
    func configure(place: PlaceResult?) {
        guard let place = place else { return } //Error
        configureImage(using: place)
        configurePlaceName(using: place)
        configureAddress(using: place)
        configureRating(using: place)
    }
    
    private func configurePlaceName(using place: PlaceResult) {
        placeNameLabel.text = place.name
    }
    
    private func configureImage(using place: PlaceResult) {
        guard let photo = place.photos?.first else { return } //Default Image
        placeImageView.backgroundColor = .secondarySystemBackground
        placeImageView.sd_setImage(with: buildImageUrl(using: photo))
        
    }
    
    private func configureAddress(using place: PlaceResult) {
        if let vicinity = place.vicinity {
            addressLabel.text = vicinity
        } else if let address = place.formatted_address {
            addressLabel.text = address
        } else if let name = place.name {
            addressLabel.text = name
        }
    }
    
    private func configureRating(using place: PlaceResult) {
        guard let rating = place.rating else {
            starView.isHidden = true
            return
        }
        starView.populate(with: rating)
    }
    
    private func buildImageUrl(using photo: Photo) -> URL? {
        guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else {
            return nil
        }
        return url
    }
    
    private func setupPlaceImageView() {
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.35, end: 0.45)
        addSubview(placeImageView)
        placeImageView.roundCorners()
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        placeImageView.constrainHeight(constant: 150)
    }
    
    private func setupStackView() {
        let stackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starView, UIView()], spacing: 4)
        stackView.distribution = .fill
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.anchor(top: placeImageView.bottomAnchor, leading: placeImageView.leadingAnchor, bottom: bottomAnchor, trailing: placeImageView.trailingAnchor, padding: .init(top: 4, left: 4, bottom: 0, right: 4))
    }
    
    private func configureHighlightView() {
        addSubview(highlightView)
        highlightView.roundCorners()
        highlightView.isHidden = true
        if starView.isHidden {
            highlightView.anchor(top: topAnchor, leading: leadingAnchor, bottom: addressLabel.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0))
        } else {
            highlightView.anchor(top: topAnchor, leading: leadingAnchor, bottom: starView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
