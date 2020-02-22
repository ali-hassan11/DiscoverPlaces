//
//  StarsView.swift
//  DiscoverPlaces
//
//  Created by user on 22/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class StarsView: UIView {
    
    var starStackView = HorizontalStackView(arrangedSubviews: [])
    
    public func populateStarView(rating: Int) {
        
        starStackView.arrangedSubviews.forEach { (view) in
            starStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for _ in 1...rating {
            let starImageView = configureStarImageView(imageName: "star.fill")
            starStackView.addArrangedSubview(starImageView)
        }
        
        let remainingStarsCount = 5 - rating
        
        if remainingStarsCount > 0 {
            for _ in 1...remainingStarsCount {
                let starImageView = configureStarImageView(imageName: "star")
                starStackView.addArrangedSubview(starImageView)
            }
        }
        
        starStackView.distribution = .fillEqually
        addSubview(starStackView)
        starStackView.fillSuperview()
    }
    
    private func configureStarImageView(imageName: String) -> UIImageView {
        let starImageView = UIImageView(image: UIImage(systemName: imageName))
        starImageView.constrainHeight(constant: 16)
        starImageView.constrainWidth(constant: 16)
        starImageView.tintColor = .systemPink
        return starImageView
    }
}
