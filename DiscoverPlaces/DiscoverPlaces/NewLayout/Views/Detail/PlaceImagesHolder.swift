//
//  PlaceImagesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceImagesHolder: UICollectionReusableView {
    
    public static let id = "placeImagesHolderId"
    
    var rating: Double? {
        didSet {
            guard let rating = rating else {
                return
            }
            starsView.populate(with: rating, displaysNumber: true)
        }
    }
    
    var placeName: String? {
        didSet {
            guard let placeName = placeName else { return }
            placeNameLabel.text = placeName
        }
    }
    
    let horizontalController = ImagesHorizontalController()
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 24, weight: .semibold), color: .white, numberOfLines: 3)
    let starsView = StarsView(width: 100)
    let gradView = UIView()
    let pageControlView: UIPageControl! = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor.systemPink
        pc.tintColor = .black
        pc.currentPage = 0
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .red
        
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
        
        pageControlView.isUserInteractionEnabled = false
//        pageControlView.constrainHeight(constant: 8)
        
        //Gradient View
        addSubview(gradView)
        gradView.fillSuperview()
        gradView.isUserInteractionEnabled = false
        addGradient(firstColor: .clear, secondColor: .black, view: gradView, start: 0.7, end: 0.96)
        
//        Add stars and pageViewTingStackView, if no stars, remove
        pageControlView.backgroundColor = .blue
        let h = HorizontalStackView(arrangedSubviews: [starsView])
        
        let stackView = VerticalStackView(arrangedSubviews: [h, placeNameLabel], spacing: 4)
        addSubview(stackView)
        stackView.alignment = .leading
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 16, right: 20))
        
        addBottomSeparator()
    }
    
    func addGradient(firstColor: UIColor, secondColor: UIColor, view: UIView, start: CGFloat, end: CGFloat) {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.frame
        gradientLayer.startPoint = CGPoint(x: 0, y: start)
        gradientLayer.endPoint = CGPoint(x: 0, y: end)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
