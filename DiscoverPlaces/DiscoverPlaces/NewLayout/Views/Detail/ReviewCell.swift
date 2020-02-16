//
//  ReviewCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {

    var review: Review? {
          didSet {
            authorNameLabel.text = review?.authorName
            timeAgoLabel.text = review?.relativeTimeDescription
            reviewTextLabel.text = review?.text
              
            //- Try self.width = 0 for all, see if there are no cells -//
          }
      }
    
    let authorNameLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16, weight: .regular), color: .label, alignment: .left, numberOfLines: 1)

    let timeAgoLabel = UILabel(text: "2 days Ago", font: .systemFont(ofSize: 14, weight: .light), color: .secondaryLabel, alignment: .right, numberOfLines: 2)

    let starsView: UIView! = {
        let v = UIView()
        v.backgroundColor = .systemPink
        v.constrainHeight(constant: 20)
        v.constrainWidth(constant: 100)
        return v
    }()

    let reviewTextLabel = UILabel(text: "Example review text here, Example review text here, Example review text here, Example review text here, Example review text here, ", font: .systemFont(ofSize: 16, weight: .light), color: .label, alignment: .left, numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        authorNameLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                                for: .vertical)

        reviewTextLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        
        layer.cornerRadius = 10
        clipsToBounds = true

        backgroundColor = .secondarySystemBackground

        let nameAndStarStackView = VerticalStackView(arrangedSubviews: [authorNameLabel, starsView], spacing: 2)

        let topStackView = HorizontalStackView(arrangedSubviews: [nameAndStarStackView, timeAgoLabel])
        topStackView.alignment = .top

        addSubview(topStackView)
        topStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        addSubview(reviewTextLabel)
        reviewTextLabel.anchor(top: topStackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0
            , left: 12, bottom: 12, right: 12))

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
