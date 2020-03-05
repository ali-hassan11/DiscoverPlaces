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
    
    let horizontalController = ImagesHorizontalController()
    
    let starsView = StarsView(width: 100)
    
    var rating: Double? {
        didSet {
            guard let rating = rating else { return }
            starsView.populate(with: rating, displaysNumber: true)
        }
    }
    
    let faveButton: UIButton! = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "heartEmpty"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.constrainWidth(constant: 44)
        btn.constrainHeight(constant: 44)
        return btn
    }()
    
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
        
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        v.layer.cornerRadius = 10
        addSubview(v)
        
        v.addSubview(starsView)
        starsView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        
        v.anchor(top: starsView.topAnchor, leading: starsView.leadingAnchor, bottom: starsView.bottomAnchor, trailing: starsView.trailingAnchor, padding: .init(top: -5, left: -8, bottom: -5, right: -8))
        horizontalController.view.addSubview(pageControlView)
        
        pageControlView.isUserInteractionEnabled = false
        pageControlView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .zero)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
