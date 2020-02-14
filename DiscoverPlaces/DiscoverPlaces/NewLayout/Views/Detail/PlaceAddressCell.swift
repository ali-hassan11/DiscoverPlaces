//
//  PlaceAddressCell.swift
//  DiscoverPlaces
//
//  Created by user on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceAddressCell: UICollectionViewCell {
    
    //Icon
    let iconVimageView = UIImageView(width: 30, height: 30)
    
    let cellTitleLabel = UILabel(text: "Today", font: .systemFont(ofSize: 17, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)
    
    let openingHoursLabel = UILabel(text: "09:00 - 15:00", font: .systemFont(ofSize: 17, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconVimageView.image = UIImage(named: "time")
        iconVimageView.contentMode = .scaleAspectFit
        backgroundColor = .systemBackground
        
        let stackView = HorizontalStackView(arrangedSubviews: [iconVimageView, cellTitleLabel, openingHoursLabel], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
