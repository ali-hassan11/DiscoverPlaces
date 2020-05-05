//
//  ReviewCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class ReviewCell: UICollectionViewCell {
    
    static let id = "reviewCellId"
    
    var review: Review? {
        didSet {
            guard let review = review else { return }
            authorNameLabel.text = review.authorName
            timeAgoLabel.text = review.relativeTimeDescription
            reviewBodyLabel.text = review.text
            starRatingView.populate(with: Double(review.rating))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(highlightView)
        highlightView.isHidden = true
        highlightView.fillSuperview()
        
        roundCorners()
        
        backgroundColor = .secondarySystemBackground
        
        layoutCellViews()
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
    
    let authorNameLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .regular), color: .label, alignment: .left, numberOfLines: 1)
    
    let timeAgoLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .light), color: .secondaryLabel, alignment: .right, numberOfLines: 2)
    
    let starRatingView = StarRatingView()
    
    let reviewBodyLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .light), color: .label, alignment: .left, numberOfLines: 0)
    
    private func layoutCellViews() {
        authorNameLabel.setContentCompressionResistancePriority(.defaultHigh,for: .vertical)
        reviewBodyLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        let nameAndStarStackView = VerticalStackView(arrangedSubviews: [authorNameLabel, starRatingView], spacing: 4)
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
