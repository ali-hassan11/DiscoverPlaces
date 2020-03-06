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
            guard let rating = rating else { return }
            starsView.populate(with: rating, displaysNumber: true)
        }
    }
    
    let horizontalController = ImagesHorizontalController()
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
        
        //Gradient View
        addSubview(gradView)
        gradView.fillSuperview()
        gradView.isUserInteractionEnabled = false
        addGradient(firstColor: .clear, secondColor: .black, view: gradView)
        
        //StackView
        let stackView = HorizontalStackView(arrangedSubviews: [starsView, pageControlView])
        addSubview(stackView)
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        stackView.constrainHeight(constant: 20)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 20, bottom: 12, right: 20))
        
    }
    
    func addGradient(firstColor: UIColor, secondColor: UIColor, view: UIView) {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.frame
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.85)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.98)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
