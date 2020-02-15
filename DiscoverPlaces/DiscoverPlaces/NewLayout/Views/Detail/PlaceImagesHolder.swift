//
//  PlaceImagesHolder.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceImagesHolder: UICollectionReusableView {
    
    let horizontalController = ImagesHorizontalController()
    
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
        
        horizontalController.view.addSubview(pageControlView)
        
        pageControlView.isUserInteractionEnabled = false
        pageControlView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .zero)
        
        
        addSubview(faveButton)
        faveButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
