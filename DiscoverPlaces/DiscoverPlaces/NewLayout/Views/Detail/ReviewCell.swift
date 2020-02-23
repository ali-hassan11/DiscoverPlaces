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
            reviewBodyLabel.text = review?.text
            starsView.populateStarView(rating: review?.rating ?? 0)
        }
      }
    
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
    
    let authorNameLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16, weight: .regular), color: .label, alignment: .left, numberOfLines: 1)

    let timeAgoLabel = UILabel(text: "2 days Ago", font: .systemFont(ofSize: 14, weight: .light), color: .secondaryLabel, alignment: .right, numberOfLines: 2)

    let starsView = StarsView()

    let reviewBodyLabel = UILabel(text: "Example review text here, Example review text here, Example review text here, Example review text here, Example review text here, ", font: .systemFont(ofSize: 16, weight: .light), color: .label, alignment: .left, numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(highlightView)
        highlightView.isHidden = true
        highlightView.fillSuperview()
        
        authorNameLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                                for: .vertical)

        reviewBodyLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        layer.cornerRadius = 10
        clipsToBounds = true

        backgroundColor = .secondarySystemBackground

        let nameAndStarStackView = VerticalStackView(arrangedSubviews: [authorNameLabel, starsView], spacing: 4)
        nameAndStarStackView.alignment = .leading

        let topStackView = HorizontalStackView(arrangedSubviews: [nameAndStarStackView, timeAgoLabel])
        topStackView.alignment = .top
        
        let stackView = VerticalStackView(arrangedSubviews: [topStackView, reviewBodyLabel, UIView()], spacing: 4)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
