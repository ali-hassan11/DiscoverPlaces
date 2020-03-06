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
    
    var listType: ListType! {
        didSet {
            displayListIcon()
        }
    }
    
    var place: PlaceDetailResult? {
        didSet {
            populateCell()
            guard let rating = place?.rating else { return }
            starView.populate(with: rating)
        }
    }

    let placeImageView = UIImageView(image: UIImage(named: "cafe"))
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 15.5, weight: .semibold), color: .label, numberOfLines: 2)
    let addressLabel = UILabel(text: "123 Palace Road, London", font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryLabel, alignment: .left, numberOfLines: 1)
    let starView = StarsView(width: 90)
    let listTypeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .systemBackground
  
        addSubview(placeImageView)
        placeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 16, left: 0, bottom: 16, right: 0))
        placeImageView.addConstraint(NSLayoutConstraint(item: placeImageView, attribute: .height, relatedBy: .equal, toItem: placeImageView, attribute: .width, multiplier: 1, constant: 0))
        placeImageView.roundCorners()
        
        addSubview(listTypeButton)
        listTypeButton.centerYInSuperview()
        listTypeButton.constrainHeight(constant: 40)
        listTypeButton.constrainWidth(constant: 40)
        listTypeButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        let detailsStackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starView], spacing: 3)
        detailsStackView.setCustomSpacing(4, after: addressLabel)
        detailsStackView.alignment = .leading
        addSubview(detailsStackView)
        detailsStackView.anchor(top: placeImageView.topAnchor, leading: placeImageView.trailingAnchor, bottom: nil, trailing: listTypeButton.leadingAnchor, padding: .init(top: 4, left: 12, bottom: 0, right: 12))
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell() {
        loadImage()
        configureLabels()
        configureStars()
    }
    
    func loadImage() {
        guard let photo = place?.photos?.first else { return }
        guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else { return }
        placeImageView.sd_setImage(with: url)
    }
    
    func configureLabels() {
        guard let name = place?.name else { return }
        placeNameLabel.text = name
        
        guard let address = place?.vicinity else { return }
        addressLabel.text = address
    }
    
    func displayListIcon() {
        listTypeButton.tintColor = .systemPink
        if listType == ListType.favourites {
            listTypeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else if listType == ListType.toDo {
            listTypeButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
    }
    
    func configureStars() {
        
    }
    
}

