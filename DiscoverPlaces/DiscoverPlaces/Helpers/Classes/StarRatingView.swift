//
//  StarsView.swift
//  DiscoverPlaces
//
//  Created by user on 22/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import Cosmos

class StarRatingView: UIView {
    
    let cosmosView = CosmosView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSettings()
        addToView()
    }
    
    public func populate(with rating: Double, displaysNumber: Bool = false) {
        cosmosView.rating = rating

        if displaysNumber {
            cosmosView.text = String(format: "%.1f", rating)
        }
    }
    
    private func configureSettings() {
        cosmosView.settings.starMargin = 0
        cosmosView.settings.starSize = 20
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.emptyBorderWidth = 1
        cosmosView.settings.emptyBorderColor = .systemPink
        cosmosView.settings.filledBorderColor = .systemPink
        cosmosView.settings.filledColor = .systemPink
        cosmosView.settings.textColor = .secondaryLabel
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
    }
    
    private func addToView() {
        addSubview(cosmosView)
        cosmosView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
