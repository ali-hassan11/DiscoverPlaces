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
            displayIcon()
            displayLabel()
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
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 16, weight: .semibold), color: .label, numberOfLines: 1)
    let addressLabel = UILabel(text: "123 Palace Road, London", font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryLabel, alignment: .left, numberOfLines: 1)
    let starView = StarsView(width: 90)
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupImageView()
        setupIconView()
    
        setupStackView()
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
    
    func displayLabel() {
           if listType == ListType.favourites {
               placeNameLabel.text = "Favourites"
           } else if listType == ListType.toDo {
               placeNameLabel.text = "To-Do"
           }
       }
       
       func displayIcon() {
           if listType == ListType.favourites {
               iconImageView.image = UIImage(systemName: "heart.fill")
           } else if listType == ListType.toDo {
               iconImageView.image = UIImage(systemName: "text.badge.minus")
           }
       }
    
    func setupImageView() {
        placeImageView.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        placeImageView.layer.cornerRadius = 10
        placeImageView.clipsToBounds = true
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.constrainWidth(constant: 60)
        placeImageView.constrainHeight(constant: 60)
    }
    
    func setupIconView() {
        iconImageView.tintColor = .systemPink
        iconImageView.constrainWidth(constant: 25)
        iconImageView.constrainHeight(constant: 25)
    }
    
    
    private func setupStackView() {
        let labelsStackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starView])
        labelsStackView.setCustomSpacing(6, after: addressLabel)
        labelsStackView.alignment = .leading
        
        let stackView = HorizontalStackView(arrangedSubviews: [placeImageView, labelsStackView, iconImageView], spacing: 12)
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 12, right: 4))
    }
    
    func configureStars() {
        
    }
    
}

