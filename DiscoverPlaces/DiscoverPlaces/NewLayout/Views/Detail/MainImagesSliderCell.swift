//
//  PlaceImagesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

typealias PageIndicator = UISegmentedControl

final class MainImagesSliderCell: UICollectionReusableView {
    
    static let id = "placeImagesHolderId"
    
    public let horizontalController = ImagesHorizontalController(theming: PlaceDetailTheming())
    public let segmentedControl = PageIndicator()
    private let placeNameLabel = UILabel(text: "", font: .systemFont(ofSize: 24, weight: .semibold), color: .white, numberOfLines: 3)
    private let starRatingView = StarRatingView()
    private let gradientView = UIView()
    private let distanceLabel = Font().distanceLabel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setupViews()
        addGradient(firstColor: .clear, secondColor: .black, view: gradientView, start: 0.69, end: 0.96)
    }
    
    public func configure(using placeDetail: PlaceDetailResult, userLocation: Location?) {
        configurePlaceName(using: placeDetail)
        configureRating(using: placeDetail)
        configurePageIndicator(using: placeDetail)
        configurePhotosController(using: placeDetail)
        configureDistanceLabel(using: placeDetail.geometry, and: userLocation)
    }
    
    private func configurePlaceName(using detail: PlaceDetailResult) {
        placeNameLabel.text = detail.name
    }
    
    private func configureRating(using detail: PlaceDetailResult) {
        guard let rating = detail.rating else {
            starRatingView.isHidden = true
            return
        }
        starRatingView.isHidden = false
        starRatingView.populate(with: rating, displaysNumber: true)
    }
    
    private func configurePageIndicator(using detail: PlaceDetailResult) {
        guard let count = detail.photos?.count else { return }
        populatePageIndicator(with: count)
        setupPageIndicatorDecoration()
        layoutPageIndicator()
    }
    
    private func configureDistanceLabel(using detailGeometry: Geometry?, and userLocation: Location?) {
        if let userLocation = userLocation {
            distanceLabel.text = detailGeometry?.distanceString(from: userLocation)
        }
    }
    
    private func populatePageIndicator(with count: Int) {
        segmentedControl.removeAllSegments()
        
        if count == 1 { return }
        
        for i in 1...count {
            segmentedControl.insertSegment(withTitle: nil, at: i, animated: true)
        }
    }
    
    private func setupPageIndicatorDecoration () {
        segmentedControl.isUserInteractionEnabled = false
        segmentedControl.backgroundColor = .quaternaryLabel
        segmentedControl.selectedSegmentTintColor = .systemPink
        
        let nearestPage =  UserDefaults.standard.integer(forKey: Constants.nearestPageKey)
        segmentedControl.selectedSegmentIndex = nearestPage
    }
    
    private func layoutPageIndicator() {
        addSubview(segmentedControl)
        
        let height: CGFloat = 2
        segmentedControl.constrainHeight(constant: height)
        segmentedControl.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    private func configurePhotosController(using placeDetail: PlaceDetailResult) {
        horizontalController.photos = placeDetail.photos
    }
    
    private func setupViews() {
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
        
        addSubview(gradientView)
        gradientView.fillSuperview()
        
        let stackView = HorizontalStackView(arrangedSubviews: [starRatingView, distanceLabel])
        addSubview(stackView)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        addSubview(placeNameLabel)
        placeNameLabel.anchor(top: nil, leading: stackView.leadingAnchor, bottom: stackView.topAnchor, trailing: stackView.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 8, right: 0))
        
        gradientView.isUserInteractionEnabled = false
        placeNameLabel.isUserInteractionEnabled = false
        stackView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
