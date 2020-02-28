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
           displayLabel()
        }
    }
    
    var placeId: String? {
        didSet {
            //Load Data
        }
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
            setIconForState(type: .favourites)
        } else if listType == ListType.toDo {
            
        }
    }
    
    func setIconForState(type: ListType) {
        
    }

    let placeImageView = UIImageView(image: UIImage(named: "pool"))
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 18, weight: .semibold), color: .label, numberOfLines: 1)
    let addressLabel = UILabel(text: "123 Palace Road, London", font: .systemFont(ofSize: 15, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)
    let starView = UIView() //STARSVIEW
    let iconImageView = UIImageView(image: UIImage(systemName: "heart"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        placeImageView.layer.cornerRadius = 10
        placeImageView.clipsToBounds = true
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.constrainWidth(constant: 60)
        placeImageView.constrainHeight(constant: 60)
        
        starView.backgroundColor = .systemPink
        starView.constrainHeight(constant: 18)
        starView.constrainWidth(constant: 100)
        
        iconImageView.tintColor = .systemPink
        iconImageView.constrainWidth(constant: 30)
        iconImageView.constrainHeight(constant: 30)
        
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starView])
        labelsStackView.setCustomSpacing(6, after: addressLabel)
        labelsStackView.alignment = .leading
        
        let stackView = HorizontalStackView(arrangedSubviews: [placeImageView, labelsStackView, iconImageView], spacing: 12)
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 12, right: 4))
        
        addBottomSeparator()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

