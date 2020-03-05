//
//  StarsView.swift
//  DiscoverPlaces
//
//  Created by user on 22/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class StarsView: UIView {
    
    init(width: CGFloat) {
        super.init(frame: .zero)
        self.width = width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var starStackView = HorizontalStackView(arrangedSubviews: [])
    var width: CGFloat!
    
    public func populate(with rating: Double, displaysNumber: Bool = false) {
                
        removeAllStars()
        
        //If no full stars
        if rating >= 0 && rating <= 0.75 {
            let starImageView = configureStarImageView(imageName: "star.lefthalf.fill")
            starStackView.addArrangedSubview(starImageView)
            fillRemainderWithEmptyStars()
            return
        } else if rating > 0.75 && rating <= 1 {
            let starImageView = configureStarImageView(imageName: "star.fill")
            starStackView.addArrangedSubview(starImageView)
            fillRemainderWithEmptyStars()
            return
        }
        
        //If full stars
        if rating >= 4.8 {
            fillRemainderWithFullStars()
            return
        }

        let fullStars = Int(rating.rounded(.down))
        
        for _ in 1...fullStars {
            let starImageView = configureStarImageView(imageName: "star.fill")
            starStackView.addArrangedSubview(starImageView)
        }
        
        let remainderStars = rating - Double(fullStars)

        if remainderStars > 0 && remainderStars < 0.25 { //Add more cases for quarter stars
            let starImageView = configureStarImageView(imageName: "star")
            starStackView.addArrangedSubview(starImageView)
        } else {
            let starImageView = configureStarImageView(imageName: "star.lefthalf.fill")
            starStackView.addArrangedSubview(starImageView)
        }

        fillRemainderWithEmptyStars()

        if displaysNumber {
            let numLabel = UILabel(text: String(rating), font: .systemFont(ofSize: 16), color: .lightText, alignment: .center, numberOfLines: 1)
            let padding = PaddingView(width: 4)
            starStackView.addArrangedSubview(padding)
            starStackView.addArrangedSubview(numLabel)
        }
        
        starStackView.distribution = .equalSpacing
        addSubview(starStackView)
        starStackView.fillSuperview()
        
    }
    
    public func populateStarView(rating: Int) {
        
        removeAllStars()
        
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
        starImageView.constrainHeight(constant: width / 5)
        starImageView.constrainWidth(constant: width / 5)
        starImageView.tintColor = .systemPink
        return starImageView
    }
    
    private func fillRemainderWithEmptyStars() {
        while starStackView.arrangedSubviews.count < 5 {
            let starImageView = configureStarImageView(imageName: "star")
            starStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func fillRemainderWithFullStars() {
        while starStackView.arrangedSubviews.count < 5 {
            let starImageView = configureStarImageView(imageName: "star.fill")
            starStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func removeAllStars() {
        starStackView.arrangedSubviews.forEach { (view) in
            starStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
