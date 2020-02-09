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
    
    let pageControlView: UIPageControl! = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = Constants.primaryHighlightColor
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
        pageControlView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
