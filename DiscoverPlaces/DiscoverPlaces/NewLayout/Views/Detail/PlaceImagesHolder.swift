//
//  PlaceImagesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class PlaceImagesHolder: UICollectionReusableView {
    
    public static let id = "placeImagesHolderId"
    
    let horizontalController = ImagesHorizontalController()
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 24, weight: .semibold), color: .white, numberOfLines: 3)
    let starsView = StarsView(width: 100)
    let gradView = UIView()
    
    typealias PageIndicator = UISegmentedControl
    let segmentedControl: PageIndicator! = {
        let sc = UISegmentedControl()
        sc.isUserInteractionEnabled = false
        return sc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setupViews()
        addGradient(firstColor: .clear, secondColor: .black, view: gradView, start: 0.7, end: 0.96)
    }
    
    public func configure(using placeDetail: PlaceDetailResult) {
        configurePlaceName(using: placeDetail)
        configureRating(using: placeDetail)
        configurePageIndicator(using: placeDetail)
        configurePhotosController(using: placeDetail)
    }
    
    private func configurePlaceName(using detail: PlaceDetailResult) {
        placeNameLabel.text = detail.name ?? ""
    }
    
    private func configureRating(using detail: PlaceDetailResult) {
        guard let rating = detail.rating else { return }
        starsView.populate(with: rating, displaysNumber: true)
    }
    
    private func configurePageIndicator(using detail: PlaceDetailResult) {
        guard let count = detail.photos?.count else { return }
        populatePageIndicator(with: count)
        setupPageIndicatorDecoration()
        layoutPageIndicator()
    }
    
    private func populatePageIndicator(with count: Int) {
        segmentedControl.removeAllSegments()
        
        for i in 1...count {
            segmentedControl.insertSegment(withTitle: nil, at: i, animated: true)
        }
    }
    
    private func setupPageIndicatorDecoration () {
        segmentedControl.backgroundColor = .secondarySystemBackground
        segmentedControl.selectedSegmentTintColor = .systemPink
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func layoutPageIndicator() {
        addSubview(segmentedControl)
        
        let height: CGFloat = 1
        segmentedControl.constrainHeight(constant: height)
        segmentedControl.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    private func configurePhotosController(using placeDetail: PlaceDetailResult) {
        horizontalController.photos = placeDetail.photos
    }

    private func addGradient(firstColor: UIColor, secondColor: UIColor, view: UIView, start: CGFloat, end: CGFloat) {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.frame
        gradientLayer.startPoint = CGPoint(x: 0, y: start)
        gradientLayer.endPoint = CGPoint(x: 0, y: end)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
        
        addSubview(gradView)
        gradView.fillSuperview()
        gradView.isUserInteractionEnabled = false
        
        let stackView = VerticalStackView(arrangedSubviews: [starsView, placeNameLabel], spacing: 4)
        addSubview(stackView)
        
        stackView.alignment = .leading
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 16, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
