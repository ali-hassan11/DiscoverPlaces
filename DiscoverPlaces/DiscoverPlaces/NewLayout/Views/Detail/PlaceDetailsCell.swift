//
//  PlaceDetailsCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailsCell: UICollectionViewCell {
    
    var place: Result? {
        didSet {
            
        }
    }
    
    let placeNameLabel = UILabel(text: "Burj Al Arab", font: .boldSystemFont(ofSize: 24), color: .label, alignment: .center, numberOfLines: 0)
    
    let addressLabel = UILabel(text: "123 Buckingham Place Place, Victoria, London, United Kingdom, E17 7AJ", font: .systemFont(ofSize: 19), color: .secondaryLabel, alignment: .center, numberOfLines: 0)
    
    let starView: UIView! = {
        let v = UIView()
        v.backgroundColor = Constants.primaryHighlightColor
        v.constrainHeight(constant: 22)
        v.constrainWidth(constant: 115)
        return v
    }()
    
    let reviewsButton: UIButton! = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "reviewsButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.constrainWidth(constant: 80)
        return btn
    }()
    
    let websiteButton: UIButton! = {
        let btn = UIButton()
        btn.backgroundColor = .secondaryLabel
        btn.constrainHeight(constant: 44)
        btn.constrainWidth(constant: 44)
        return btn
    }()
    
    let navigateButton: UIButton! = {
        let btn = UIButton()
        btn.backgroundColor = .secondaryLabel
        btn.constrainHeight(constant: 44)
        btn.constrainWidth(constant: 44)
        return btn
    }()
    
    let shareButton: UIButton! = {
        let btn = UIButton()
        btn.backgroundColor = .secondaryLabel
        btn.constrainHeight(constant: 44)
        btn.constrainWidth(constant: 44)
        return btn
    }()
    
    let openingTimesTileLabel = UILabel(text: "Opening Times", font: .systemFont(ofSize: 23), color: .label, alignment: .center, numberOfLines: 0)
    
    let openingTimesLabel = UILabel(text: hoursText, font: .systemFont(ofSize: 19), color: .secondaryLabel, alignment: .center, numberOfLines: 0)
    
    let line1: UIView! = {
        let v = UIView()
        v.constrainHeight(constant: 1)
        v.backgroundColor = .opaqueSeparator
        return v
    }()
    
    let line2: UIView! = {
        let v = UIView()
        v.constrainHeight(constant: 1)
        v.backgroundColor = .opaqueSeparator
        return v
    }()
    
    let line3: UIView! = {
        let v = UIView()
        v.constrainHeight(constant: 1)
        v.backgroundColor = .opaqueSeparator
        return v
    }()
    
    let padding1 = UIView()
    let padding2 = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        //TopStack
        let ratingsStackView = UIStackView(arrangedSubviews: [padding1, starView, reviewsButton, padding2])
        ratingsStackView.spacing = 6
        
        let topStackView = VerticalStackView(arrangedSubviews: [placeNameLabel,
                                                                       addressLabel,
                                                                       ratingsStackView], spacing: 8)
        topStackView.alignment = .center
        
        
        addSubview(topStackView)
        topStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        //MiddleStack
        let buttonStackView = HorizontalStackView(arrangedSubviews: [websiteButton, navigateButton, shareButton], spacing: 0)
        buttonStackView.distribution = .equalCentering
        
        let middleStackView = VerticalStackView(arrangedSubviews: [line1, buttonStackView, line2], spacing: 4)
       
        addSubview(middleStackView)
        middleStackView.anchor(top: topStackView.bottomAnchor, leading: topStackView.leadingAnchor, bottom: nil, trailing: topStackView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        //BottomStack
        let bottomStack = VerticalStackView(arrangedSubviews: [openingTimesTileLabel, openingTimesLabel], spacing: 8)
        
        addSubview(bottomStack)
        bottomStack.anchor(top: middleStackView.bottomAnchor, leading: topStackView.leadingAnchor, bottom: nil, trailing: topStackView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

let hoursText = "Monday: 09:00 - 17:00\nTuesday: 09:00 - 17:00\nWednesday: 09:00 - 17:00\nThursday: 09:00 - 17:00\nFriday: 09:00 - 17:00\nSaturday: 09:00 - 17:00\nSunday: 09:00 - 17:00"
