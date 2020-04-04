//
//  MyPlaceCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MyPlaceCell: UICollectionViewCell {
    
    static public let id = "myListCell"
    
    let placeImageView = UIImageView(image: UIImage(named: ""))
    let placeNameLabel = UILabel(text: "", font: .systemFont(ofSize: 15.5, weight: .semibold), color: .label, numberOfLines: 2)
    let addressLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryLabel, alignment: .left, numberOfLines: 1)
    let starView = StarsView(width: 90)
    let chevronIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
    
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
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.15, end: 0.25)
        placeImageView.contentMode = .scaleAspectFill
        
        addViews()
        addConstraints()
        addBottomSeparator()
        configureHighlightView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(place: PlaceDetailResult?) {
        guard let place = place else { return } //Error
        configureImage(using: place)
        configurePlaceName(using: place)
        configureAddress(using: place)
        configureRating(using: place)
    }
    
    private func configurePlaceName(using place: PlaceDetailResult) {
        placeNameLabel.text = place.name
    }
    
    private func configureImage(using place: PlaceDetailResult) {
        guard let photo = place.photos?.first else { return } //Default Image
        placeImageView.backgroundColor = .secondarySystemBackground
        placeImageView.sd_setImage(with: buildImageUrl(using: photo))
        
    }
    
    private func configureAddress(using place: PlaceDetailResult) {
        if let vicinity = place.vicinity {
            addressLabel.text = vicinity
        } else if let address = place.formatted_address {
            addressLabel.text = address
        } else if let name = place.name {
            addressLabel.text = name
        }
    }
    
    private func configureRating(using place: PlaceDetailResult) {
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
    
    private func configureHighlightView() {
        addSubview(highlightView)
        highlightView.isHidden = true
        highlightView.fillSuperview()
    }
    
    private func addViews() {
        addSubview(placeImageView)
        addSubview(chevronIcon)
        chevronIcon.tintColor = .systemPink
    }
    
    private func addConstraints() {
        // TODO: - Make StackView
        placeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 0))
        placeImageView.addConstraint(NSLayoutConstraint(item: placeImageView, attribute: .height, relatedBy: .equal, toItem: placeImageView, attribute: .width, multiplier: 1, constant: 0))
        placeImageView.roundCorners()
        
        chevronIcon.centerYInSuperview()
        chevronIcon.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        
        let detailsStackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starView], spacing: 3)
        detailsStackView.setCustomSpacing(4, after: addressLabel)
        detailsStackView.alignment = .leading
        addSubview(detailsStackView)
        detailsStackView.anchor(top: placeImageView.topAnchor, leading: placeImageView.trailingAnchor, bottom: nil, trailing: chevronIcon.leadingAnchor, padding: .init(top: 4, left: 12, bottom: 0, right: 12))
    }
    
    func configureStars() {
        
    }
    
}

