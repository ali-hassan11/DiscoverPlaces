//
//  ReviewDetailViewController.swift
//  DiscoverPlaces
//
//  Created by user on 23/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ReviewDetailViewController: UIViewController {
  
    var review: Review? {
          didSet {
            authorNameLabel.text = review?.authorName
            timeAgoLabel.text = review?.relativeTimeDescription
            reviewBodyTextView.text = review?.text
            starRatingView.populate(with: Double(review?.rating ?? 0))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        layoutStackView()
    }
    
    let reviewCardView: UIView! = {
        let v = UIView()
        v.backgroundColor = .secondarySystemBackground
        //Standardize
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    // TODO: - Create custom fonts for components
    let authorNameLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .regular), color: .label, alignment: .left, numberOfLines: 1)
    
    let timeAgoLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .light), color: .secondaryLabel, alignment: .right, numberOfLines: 2)
    
    let starRatingView = StarRatingView()
    
    let reviewBodyTextView: UITextView! = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16, weight: .light)
        tv.textColor = .label
        tv.textAlignment = .left
        tv.backgroundColor = .clear
        tv.textContainerInset = UIEdgeInsets.zero
        tv.textContainer.lineFragmentPadding = 0
        return tv
    }()
    
    private func layoutStackView() {
        authorNameLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                                for: .vertical)
        
        reviewBodyTextView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        let nameAndStarStackView = VerticalStackView(arrangedSubviews: [authorNameLabel, starRatingView], spacing: 4)
        nameAndStarStackView.alignment = .leading
        
        let topStackView = HorizontalStackView(arrangedSubviews: [nameAndStarStackView, timeAgoLabel])
        topStackView.alignment = .top
        
        let stackView = VerticalStackView(arrangedSubviews: [topStackView, reviewBodyTextView], spacing: 4)
        
        view.addSubview(reviewCardView)
        reviewCardView.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        reviewCardView.addSubview(stackView)
        stackView.anchor(top: reviewCardView.topAnchor, leading: reviewCardView.leadingAnchor, bottom: reviewCardView.bottomAnchor, trailing: reviewCardView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
}
